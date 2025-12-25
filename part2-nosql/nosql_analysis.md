# NoSQL Analysis - MongoDB Assignment

## 1. Introduction to NoSQL
NoSQL databases are designed for flexibility, scalability, and performance. Unlike relational databases, they allow storing data in formats like key-value pairs, documents, or graphs. MongoDB is a popular document-based NoSQL database that stores data in JSON-like structures, called BSON. This flexibility is particularly useful for applications like product catalogs where each product may have different specifications and reviews.

## 2. Advantages of MongoDB for Product Catalog
MongoDB is ideal for a product catalog because it allows nested data structures such as reviews arrays and specifications objects. Aggregation operations can compute statistics like average ratings and category-wise pricing efficiently. Updating individual documents or adding new fields is simple, without requiring schema migration. This makes MongoDB flexible and efficient for e-commerce or inventory management systems.

## 3. Explanation of Implemented Operations
**Operation 1:** The sample JSON data is imported into the `products` collection. This forms the base dataset.  
**Operation 2:** A basic query retrieves all electronics products with a price below 50000, returning only name, price, and stock.  
**Operation 3:** Aggregation is used to calculate average ratings from the reviews array. Products with average rating >= 4 are selected.  
**Operation 4:** A new review is added to product "ELEC001" using the `$push` operator to update the nested array.  
**Operation 5:** Complex aggregation calculates average price and product count by category, then sorts categories by average price in descending order.  

MongoDB operations efficiently handle nested data, dynamic schema, and analytical queries, making it a powerful tool for real-world product management.
