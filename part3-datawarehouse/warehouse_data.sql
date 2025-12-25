-- =========================
-- INSERT INTO dim_date (30 rows)
-- =========================
INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,FALSE),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,FALSE),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,FALSE),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,FALSE),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,FALSE),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,TRUE),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,TRUE),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,FALSE),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,FALSE),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,FALSE),
(20240111,'2024-01-11','Thursday',11,1,'January','Q1',2024,FALSE),
(20240112,'2024-01-12','Friday',12,1,'January','Q1',2024,FALSE),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,TRUE),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,TRUE),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,FALSE),
(20240116,'2024-01-16','Tuesday',16,1,'January','Q1',2024,FALSE),
(20240117,'2024-01-17','Wednesday',17,1,'January','Q1',2024,FALSE),
(20240118,'2024-01-18','Thursday',18,1,'January','Q1',2024,FALSE),
(20240119,'2024-01-19','Friday',19,1,'January','Q1',2024,FALSE),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,TRUE),
(20240121,'2024-01-21','Sunday',21,1,'January','Q1',2024,TRUE),
(20240122,'2024-01-22','Monday',22,1,'January','Q1',2024,FALSE),
(20240123,'2024-01-23','Tuesday',23,1,'January','Q1',2024,FALSE),
(20240124,'2024-01-24','Wednesday',24,1,'January','Q1',2024,FALSE),
(20240125,'2024-01-25','Thursday',25,1,'January','Q1',2024,FALSE),
(20240126,'2024-01-26','Friday',26,1,'January','Q1',2024,FALSE),
(20240127,'2024-01-27','Saturday',27,1,'January','Q1',2024,TRUE),
(20240128,'2024-01-28','Sunday',28,1,'January','Q1',2024,TRUE),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,FALSE),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,FALSE);

-- =========================
-- INSERT INTO dim_product (15 rows)
-- =========================
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Laptop','Electronics','Computers',55000),
('P002','Smartphone','Electronics','Mobiles',30000),
('P003','Television','Electronics','TV',45000),
('P004','Headphones','Electronics','Audio',2500),
('P005','Refrigerator','Electronics','Appliances',65000),
('P006','Office Chair','Furniture','Seating',8000),
('P007','Dining Table','Furniture','Tables',25000),
('P008','Sofa','Furniture','Living',40000),
('P009','Bed','Furniture','Bedroom',35000),
('P010','Wardrobe','Furniture','Storage',30000),
('P011','T-Shirt','Clothing','Topwear',800),
('P012','Jeans','Clothing','Bottomwear',2000),
('P013','Jacket','Clothing','Winter',5000),
('P014','Shoes','Clothing','Footwear',3500),
('P015','Cap','Clothing','Accessories',500);

-- =========================
-- INSERT INTO dim_customer (12 rows)
-- =========================
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','John Doe','Mumbai','Maharashtra','Retail'),
('C002','Asha Kumar','Delhi','Delhi','Corporate'),
('C003','Ravi Patel','Ahmedabad','Gujarat','Retail'),
('C004','Neha Sharma','Bengaluru','Karnataka','Retail'),
('C005','Amit Verma','Mumbai','Maharashtra','Corporate'),
('C006','Pooja Singh','Delhi','Delhi','Retail'),
('C007','Karan Mehta','Ahmedabad','Gujarat','Corporate'),
('C008','Sneha Iyer','Bengaluru','Karnataka','Retail'),
('C009','Rahul Das','Mumbai','Maharashtra','Retail'),
('C010','Anita Roy','Delhi','Delhi','Corporate'),
('C011','Vikram Rao','Bengaluru','Karnataka','Retail'),
('C012','Meena Shah','Ahmedabad','Gujarat','Retail');

-- =========================
-- INSERT INTO fact_sales (40 rows)
-- =========================
INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
(20240106,1,1,2,55000,5000,105000),
(20240107,2,2,1,30000,0,30000),
(20240113,3,3,1,45000,3000,42000),
(20240114,4,4,3,2500,0,7500),
(20240120,5,5,1,65000,5000,60000),
(20240121,6,6,2,8000,0,16000),
(20240127,7,7,1,25000,2000,23000),
(20240128,8,8,1,40000,3000,37000),
(20240115,9,9,1,35000,0,35000),
(20240116,10,10,1,30000,2000,28000),
(20240117,11,11,4,800,0,3200),
(20240118,12,12,2,2000,0,4000),
(20240119,13,1,1,5000,500,4500),
(20240122,14,2,2,3500,0,7000),
(20240123,15,3,3,500,0,1500),
(20240124,1,4,1,55000,3000,52000),
(20240125,2,5,2,30000,4000,56000),
(20240126,3,6,1,45000,0,45000),
(20240127,4,7,5,2500,0,12500),
(20240128,5,8,1,65000,5000,60000),
(20240201,6,9,2,8000,0,16000),
(20240202,7,10,1,25000,2000,23000),
(20240106,8,11,1,40000,3000,37000),
(20240107,9,12,1,35000,0,35000),
(20240113,10,1,1,30000,0,30000),
(20240114,11,2,3,800,0,2400),
(20240120,12,3,2,2000,0,4000),
(20240121,13,4,1,5000,500,4500),
(20240127,14,5,2,3500,0,7000),
(20240128,15,6,4,500,0,2000),
(20240115,1,7,1,55000,0,55000),
(20240116,2,8,1,30000,2000,28000),
(20240117,3,9,1,45000,0,45000),
(20240118,4,10,2,2500,0,5000),
(20240119,5,11,1,65000,5000,60000),
(20240122,6,12,2,8000,0,16000),
(20240123,7,1,1,25000,2000,23000),
(20240124,8,2,1,40000,3000,37000),
(20240125,9,3,1,35000,0,35000),
(20240126,10,4,1,30000,0,30000);
