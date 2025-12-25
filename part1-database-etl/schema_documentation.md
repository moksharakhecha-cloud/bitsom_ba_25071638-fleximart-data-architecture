Database Schema Documentation

 1. Entity–Relationship Description

   ENTITY: customers
 Purpose: 
Stores information about customers who place orders in the system.

 Attributes:
- `customer_id` (Primary Key): Unique identifier for each customer
- `first_name`: Customer’s first name
- `last_name`: Customer’s last name
- `email`: Customer’s email address
- `phone`: Customer’s contact number

Relationships:
- One customer can place many orders (1:M relationship with `orders` table)

---

  ENTITY: orders
  Purpose: 
Stores order details placed by customers.

Attributes:
- `order_id` (Primary Key): Unique identifier for each order
- `order_date`: Date the order was placed
- `customer_id` (Foreign Key): References `customers.customer_id`
- `total_amount`: Total value of the order

Relationships:
- Each order is placed by one customer (M:1 with `customers`)
- One order can contain many products (1:M with `order_items`)

---

   ENTITY: products
 Purpose:  
Stores information about products available for purchase.

 Attributes:
- `product_id` (Primary Key): Unique identifier for each product
- `product_name`: Name of the product
- `price`: Price of the product
- `stock_quantity`: Available quantity in stock

 Relationships:
- One product can appear in **many orders** (1:M with `order_items`)


 ENTITY: order_items
Purpose:  
Acts as a junction table to manage the many-to-many relationship between orders and products.

 Attributes:
- `order_item_id` (Primary Key): Unique identifier for each order item
- `order_id` (Foreign Key): References `orders.order_id`
- `product_id` (Foreign Key): References `products.product_id`
- `quantity`: Quantity of the product ordered

 Relationships:
- Each record links one order to one product



 2. Normalization Explanation (Third Normal Form)

The database design follows Third Normal Form (3NF) to ensure data integrity and reduce redundancy.  
First Normal Form (1NF) is achieved because all tables contain atomic values, and each field stores a single piece of data. There are no repeating groups or multivalued attributes.

Second Normal Form (2NF) is satisfied because all non-key attributes are fully functionally dependent on their entire primary key. For example, in the `order_items` table, the quantity depends on the combination of order and product, not on only one part of the relationship.

Third Normal Form (3NF) is met because there are no transitive dependencies. Non-key attributes do not depend on other non-key attributes. For instance, customer details such as name and email are stored only in the `customers` table and not repeated in the `orders` table. This ensures that customer-related data depends only on `customer_id`.

Functional dependencies in the schema include:
- `customer_id → first_name, last_name, email, phone`
- `order_id → order_date, customer_id, total_amount`
- `product_id → product_name, price, stock_quantity`

This design avoids update anomalies by storing each fact in only one place, insert anomalies by allowing independent insertion of customers or products, and delete anomalies by ensuring that deleting an order does not remove customer or product data.



 3. Sample Data Representation

 customers

| customer_id | first_name | last_name | email             | phone        |
|------------|------------|-----------|-------------------|--------------|
| 1          | John       | Doe       | john@example.com  | 1234567890   |
| 2          | Jane       | Smith     | jane@example.com  | 0987654321   |



 orders

| order_id | order_date | customer_id | total_amount |
|---------|------------|-------------|--------------|
| 101     | 2024-01-10 | 1           | 150.00       |
| 102     | 2024-01-12 | 2           | 200.00       |


 products

| product_id | product_name | price | stock_quantity |
|-----------|--------------|-------|----------------|
| 1         | Laptop       | 1000  | 10             |
| 2         | Mouse        | 25    | 50             |


 order_items

| order_item_id | order_id | product_id | quantity |
|--------------|----------|------------|----------|
| 1            | 101      | 1          | 1        |
| 2            | 102      | 2          | 2        |

