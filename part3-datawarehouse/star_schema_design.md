Section 1: Schema Overview
FACT TABLE: fact_sales

Grain: One row per product per order line item
Business Process: Sales transactions

Measures (Numeric Facts):

quantity_sold: Number of units sold

unit_price: Price per unit at the time of sale

discount_amount: Discount applied to the line item

total_amount: Final amount calculated as (quantity_sold × unit_price − discount_amount)

Foreign Keys:

date_key → dim_date

product_key → dim_product

customer_key → dim_customer

DIMENSION TABLE: dim_date

Purpose: Date dimension for time-based analysis
Type: Conformed dimension

Attributes:

date_key (PK): Surrogate key (integer, format YYYYMMDD)

full_date: Actual calendar date

day_of_week: Monday, Tuesday, etc.

month: Numeric month (1–12)

month_name: January, February, etc.

quarter: Q1, Q2, Q3, Q4

year: Calendar year (e.g., 2023, 2024)

is_weekend: Boolean flag indicating weekend

DIMENSION TABLE: dim_product

Purpose: Product-related descriptive information for sales analysis
Type: Slowly Changing Dimension (Type 2 – optional)

Attributes:

product_key (PK): Surrogate key

product_id: Natural product identifier from source system

product_name: Name of the product

category: Product category (e.g., Electronics)

subcategory: Product subcategory (e.g., Laptops)

brand: Brand name

start_date: Record effective start date

end_date: Record effective end date

is_current: Boolean flag for current record

DIMENSION TABLE: dim_customer

Purpose: Customer demographic and geographic analysis
Type: Slowly Changing Dimension (Type 2 – optional)

Attributes:

customer_key (PK): Surrogate key

customer_id: Natural customer identifier

customer_name: Full customer name

gender: Customer gender

city: City of residence

state: State of residence

country: Country of residence

start_date: Record effective start date

end_date: Record effective end date

is_current: Boolean flag for current record

Section 2: Design Decisions

The chosen granularity of one row per product per order line item ensures the most detailed level of sales data is captured. This allows accurate calculation of measures such as revenue, discounts, and quantities while supporting detailed transactional analysis. Finer granularity enables flexibility, as higher-level summaries can always be derived from detailed data, but not vice versa.

Surrogate keys are used instead of natural keys to improve performance, maintain consistency, and handle changes in source system identifiers. They also support Slowly Changing Dimensions by allowing multiple historical versions of dimension records without affecting fact table integrity.

This star schema design supports drill-down and roll-up operations effectively. Analysts can roll up sales data by month, quarter, or year using the date dimension, or drill down from category to individual products using the product dimension. The simple structure and clear relationships ensure fast query performance and intuitive reporting.

Section 3: Sample Data Flow
Source Transaction

Order Number: 101

Customer: John Doe

Product: Laptop

Quantity: 2

Unit Price: 50,000

Becomes in Data Warehouse

fact sales:
{
date_key: 20240115,
product_key: 5,
customer_key: 12,
quantity_sold: 2,
unit_price: 50000,
discount_amount: 0,
total_amount: 100000
}


dim date:
{
date_key: 20240115,
full_date: '2024-01-15',
day_of_week: 'Monday',
month: 1,
month_name: 'January',
quarter: 'Q1',
year: 2024,
is_weekend: false
}


dim product:
{
product_key: 5,
product_name: 'Laptop',
category: 'Electronics',
subcategory: 'Computers',
brand: 'ABC'
}


dim customer:
{
customer_key: 12,
customer_name: 'John Doe',
city: 'Mumbai',
state: 'Maharashtra',
country: 'India'
}



