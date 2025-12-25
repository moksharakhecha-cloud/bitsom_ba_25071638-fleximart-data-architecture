import pandas as pd
import numpy as np
import mysql.connector
from dateutil import parser

# ================= DATABASE CONFIG =================
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "0916",  
    "database": "fleximart"
}

# ================= DATA QUALITY TRACKING =================
report = {
    "customers": {"processed": 0, "duplicates_removed": 0, "missing_handled": 0, "loaded": 0},
    "products": {"processed": 0, "duplicates_removed": 0, "missing_handled": 0, "loaded": 0},
    "sales": {"processed": 0, "duplicates_removed": 0, "missing_handled": 0, "loaded": 0}
}

# ================= HELPER FUNCTIONS =================
def format_phone(phone):
    if pd.isna(phone):
        return None
    digits = ''.join(filter(str.isdigit, str(phone)))
    if len(digits) >= 10:
        return "+91-" + digits[-10:]
    return None

def parse_date_safe(date_val):
    try:
        return parser.parse(str(date_val)).date()
    except:
        return None

# ================= EXTRACT =================
print("Starting ETL Pipeline...")

customers_df = pd.read_csv("customers_raw.csv")
print(customers_df.columns)
products_df = pd.read_csv("products_raw.csv")
sales_df = pd.read_csv("sales_raw.csv")

report["customers"]["processed"] = len(customers_df)
report["products"]["processed"] = len(products_df)
report["sales"]["processed"] = len(sales_df)

# ================= TRANSFORM: CUSTOMERS =================
before = len(customers_df)
customers_df.drop_duplicates(inplace=True)
report["customers"]["duplicates_removed"] = before - len(customers_df)

missing_email = customers_df["email"].isna().sum()
customers_df.dropna(subset=["email"], inplace=True)
report["customers"]["missing_handled"] += missing_email

customers_df["phone"] = customers_df["phone"].apply(format_phone)
customers_df["registration_date"] = customers_df["registration_date"].apply(parse_date_safe)

# ================= TRANSFORM: PRODUCTS =================
before = len(products_df)
products_df.drop_duplicates(inplace=True)
report["products"]["duplicates_removed"] = before - len(products_df)

missing_price = products_df["price"].isna().sum()
products_df["price"].fillna(products_df["price"].mean(), inplace=True)

missing_stock = products_df["stock_quantity"].isna().sum()
products_df["stock_quantity"].fillna(0, inplace=True)

report["products"]["missing_handled"] = missing_price + missing_stock

products_df["category"] = products_df["category"].str.strip().str.title()

# ================= TRANSFORM: SALES =================
before = len(sales_df)
sales_df.drop_duplicates(inplace=True)
report["sales"]["duplicates_removed"] = before - len(sales_df)

missing_ids = sales_df[["customer_id", "product_id"]].isna().any(axis=1).sum()
sales_df.dropna(subset=["customer_id", "product_id"], inplace=True)
report["sales"]["missing_handled"] = missing_ids

sales_df["order_date"] = sales_df["order_date"].apply(parse_date_safe)

# ================= LOAD =================
conn = mysql.connector.connect(**DB_CONFIG)
cursor = conn.cursor()

try:
    # ---- Load Customers ----
    for _, row in customers_df.iterrows():
        cursor.execute("""
            INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            row["first_name"],
            row["last_name"],
            row["email"],
            row["phone"],
            row["city"],
            row["registration_date"]
        ))
        report["customers"]["loaded"] += 1

    # ---- Load Products ----
    for _, row in products_df.iterrows():
        cursor.execute("""
            INSERT INTO products (product_name, category, price, stock_quantity)
            VALUES (%s, %s, %s, %s)
        """, (
            row["product_name"],
            row["category"],
            row["price"],
            int(row["stock_quantity"])
        ))
        report["products"]["loaded"] += 1

    # ---- Load Orders & Order Items ----
    for _, row in sales_df.iterrows():
        cursor.execute("""
            INSERT INTO orders (customer_id, order_date, total_amount)
            VALUES (%s, %s, %s)
        """, (
            int(row["customer_id"]),
            row["order_date"],
            float(row["quantity"] * row["unit_price"])
        ))

        order_id = cursor.lastrowid

        cursor.execute("""
            INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            order_id,
            int(row["product_id"]),
            int(row["quantity"]),
            float(row["unit_price"]),
            float(row["quantity"] * row["unit_price"])
        ))

        report["sales"]["loaded"] += 1

    conn.commit()
    print("Data loaded successfully.")

except Exception as e:
    conn.rollback()
    print("Error occurred:", e)

finally:
    cursor.close()
    conn.close()

# ================= DATA QUALITY REPORT =================
with open("data_quality_report.txt", "w") as f:
    for table, stats in report.items():
        f.write(f"{table.upper()}\n")
        for key, value in stats.items():
            f.write(f"{key}: {value}\n")
        f.write("\n")

print("ETL Pipeline Completed.")
