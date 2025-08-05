#create database:
create database Inventory_Management;

#use database:
use Inventory_Management;

#create First Table:
create table Categories (
	Category_id INT PRIMARY KEY AUTO_INCREMENT,
	Category_name VARCHAR(100) UNIQUE NOT NULL,
	Description TEXT
);

#create Second Table:
create table  Products(
    Product_id INT PRIMARY KEY ,
	Product_name VARCHAR(100) NOT NULL,
	Category_id INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
	Stock_quantity INT NOT NULL,
	Reorder_level INT NOT NULL,
	FOREIGN KEY (Category_id) REFERENCES Categories(Category_id)
);

#create Third Table:
create table suppliers (
	Supplier_id INT PRIMARY KEY AUTO_INCREMENT,
	Supplier_name VARCHAR(100) NOT NULL,
	Contact_name VARCHAR(50),
    Address TEXT,
	Phone_number VARCHAR(15) UNIQUE

);
#create Forth Table:
create Table  Orders (
	Order_id INT PRIMARY KEY AUTO_INCREMENT,
	Order_date DATE NOT NULL,
	Supplier_id INT NOT NULL,
	Total_amount DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (Supplier_id) REFERENCES Suppliers(supplier_id)
);
#creat Fifth Table:
create Table OrderDetails (
	Order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
	Order_id INT NOT NULL,
	Product_id INT NOT NULL,
	Quantity INT NOT NULL,
	Unit_price DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (order_id) REFERENCES Orders(order_id),
	FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

#insert into categories
insert into categories (Category_name, Description) values
('Stationery','School and Office Supplies'),
('Furniture','Home and Office Furniture'),
('Sports','Sports Equpment'),
('Toys','Toys for Kids'),
('Clothing','Men and Women Clothes'),
('Leather','Shoes and Belt Items'),
('Books','Education and Joke and Story Books'),
('Fruits','Aggregate, multiple and accessory types'),
('Vegetables','Leafy greens, Bulb vegetables and Flower vegetables'),
('Beauty','Cosmetics and Personal Care'),
('Electronics','Devices, Phones and Laptop'),
('Groceries','Daily Groceries Items'); 

select * from categories;

#insert into Products
insert into Products (Product_id,Product_name,Category_id,Price,Stock_quantity,Reorder_level) values
(201, 'Mobile Phone', 11, 999.99, 16, 6),
(202, 'Table', 2, 260.00, 9, 4),
(203, 'Rice Bag 5KG', 12, 30.50, 0, 11),
(204, 'T-Shirt', 5, 11.00, 60, 25),
(205, 'Pencil', 1, 3.50, 110, 350),
(206, 'Action Figure', 4, 16.75, 6, 6),
(207, 'Story Book', 7, 13.00, 21, 6),
(208, 'Basketball', 3, 35.00, 13, 7),
(209, 'Work Shoes', 6, 71.00, 26, 11),
(210, 'Face Cream', 10, 19.00, 0, 11),
(211, 'Table Fan', 11, 250.00, 39, 5),
(212, 'Projector', 11, 150.00, 10, 3);

select * from products;

#insert into suppliers
insert into suppliers (Supplier_name,Contact_name,Address,Phone_number) values
('ABC and Co.', 'Sarath', 'MG Road', '8792980937'),
('Toy Bazaar', 'Mani', 'Indiranagar', '9023783678'),
('Infosys', 'Ragu', 'Electronic City', '7890347555'),
('Wipro', 'Raja', 'Sarjapur', '8902340987'),
('V Guard', 'Deva', 'Kodathi', '7891746289'),
('Book Planet', 'Kumar', 'Jayanagar', '9678239457'),
('Eram Power Pvt. Ltd', 'Suman', 'Attibele', '9848784878'),
('Product World','Ajith','Hoskote', '9045894789'),
('swiggy','Karthi','Koramangala', '8967875437'),
('Honeywell','Alagu','Marthalli', '9087986578'),
('Cafe Coffee Day Ltd', 'Arum','Sivaji Nagar', '7890347689'),
('Face Beauty and Co.', 'Prabu', 'Madivala', '9090765436');

select * from suppliers;

#insert into Order
insert into orders (Order_date,Supplier_id,Total_amount) values
('2025-06-28', 1, 4700.00) ,
('2025-05-30', 2, 1500.00) ,
('2025-04-18', 3, 500.00) ,
('2024-12-22', 4, 1400.00) ,
('2025-01-17', 5, 400.00) ,
('2025-06-22', 6, 550.00) ,
('2025-02-11', 7, 700.00) ,
('2025-03-24', 8, 1000.00) ,
('2025-04-22', 9, 2300.00) ,
('2025-01-29', 10, 700.00) ,
('2024-10-30', 11, 1200.00) ,
('2024-12-10', 12, 880.00) ;

select * from orders;

insert into OrderDetails (Order_detail_id,Order_id,Product_id,Quantity,Unit_price) values
(301, 1, 201, 8, 500),
(302, 2, 202, 10, 870),
(303, 3, 203, 2, 600),
(304, 4, 204, 5, 200),
(305, 5, 205, 7, 400),
(306, 6, 206, 12, 1500),
(307, 7, 207, 3, 720),
(308, 8, 208, 4, 990),
(309, 9, 209, 9, 630),
(310, 10, 210, 11, 2000),
(311, 11, 211, 14, 2070),
(312, 12, 212, 3, 370);

select *from OrderDetails;

# 1) Retrieve the names and prices of all products that are currently out of stock

SELECT product_name ,price 
FROM products 
WHERE stock_quantity=0;

# 2) List the total number of products in each category.

SELECT c.category_name, c.category_id, COUNT(p.product_id) AS total_product
FROM categories AS c
LEFT JOIN products AS p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

# 3) Find all suppliers who have supplied products worth more than 1000.

SELECT s.supplier_id, s.supplier_name, SUM(o.total_amount) AS total_supplied
FROM suppliers AS s
JOIN orders AS o ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_id, s.supplier_name
HAVING SUM(o.total_amount) > 1000;

# 4) Get the details of products with stock quantity less than their reorder level.

SELECT *
FROM products
WHERE stock_quantity < reorder_level;

# 5) Retrieve the order id and total amounts for orders placed in last 30 days.

SELECT order_id, total_amount
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 80 DAY;

# 6) List all products along with their categories ,ordered by product name.

SELECT p.product_id, p.product_name, c.category_name
FROM products AS p
JOIN categories AS c ON p.category_id = c.category_id
ORDER BY p.product_name;

# 7) Get the names of suppliers who have not supplied any products in the last 6 months.

SELECT s.supplier_id, s.supplier_name
FROM suppliers AS s
LEFT JOIN orders AS o ON s.supplier_id = o.supplier_id 
AND o.order_date >= CURDATE() - INTERVAL 6 MONTH
WHERE o.order_id IS NULL;

# 8) Find the total amount spent on orders for each supplier.

SELECT s.supplier_id, s.supplier_name, SUM(o.total_amount) AS total_spent
FROM suppliers AS s
JOIN orders AS o ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_id, s.supplier_name;

# 9) Retrieve the product name and total quantites ordered for each product in last year.

SELECT p.product_name, SUM(od.quantity) AS total_quantity_ordered
FROM products AS p
JOIN orderdetails od ON p.product_id = od.product_id
JOIN orders AS o ON od.order_id = o.order_id
WHERE o.order_date >= CURDATE() - INTERVAL 1 YEAR
GROUP BY p.product_name
ORDER BY total_quantity_ordered DESC;

# 10) Get a list of products that belong to the Electronics category and have the price greater than 200.

SELECT p.product_id, p.product_name, p.price, c.category_name
FROM products AS p
JOIN categories AS c ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics' AND p.price > 200;

