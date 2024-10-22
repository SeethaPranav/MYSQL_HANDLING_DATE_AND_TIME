CREATE DATABASE challenge28;
use challenge28;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10, 2)
);
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2023-01-15 10:30:00', 150.00),
(2, 102, '2023-02-20 14:45:00', 200.50),
(3, 101, '2023-03-05 09:15:00', 300.75),
(4, 103, '2023-03-10 16:20:00', 120.00),
(5, 104, '2023-04-15 11:00:00', 250.00);

SELECT * FROM orders;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    registration_date DATE
);

INSERT INTO customers (customer_id, customer_name, registration_date) VALUES
(101, 'Alice Johnson', '2022-12-01'),
(102, 'Bob Smith', '2023-01-15'),
(103, 'Carol White', '2023-02-10'),
(104, 'David Brown', '2023-03-20');

SELECT * FROM customers;

#1.Total Number of Orders Placed by Each Customer
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

#2. Finding Orders Placed in a Specific Date Range
SELECT *
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31';

#3. Calculating the Number of Days Since a Customer Registered
SELECT c.customer_name, DATEDIFF(CURDATE(), c.registration_date) AS days_since_registration
FROM customers c;

#4. Aggregating Total Sales Per Month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month, SUM(total_amount) AS total_sales
FROM orders
GROUP BY order_month
ORDER BY order_month;

#5. Finding the Latest Order Date for Each Customer
SELECT c.customer_name, MAX(o.order_date) AS latest_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

#6. Running Total of Sales Over Time
SELECT order_date, 
       SUM(total_amount) OVER (ORDER BY order_date) AS running_total
FROM orders
ORDER BY order_date;

#7. Identifying Customers with Orders in the Last 30 Days
SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

#8. Counting Orders by Month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month, COUNT(order_id) AS order_count
FROM orders
GROUP BY order_month
ORDER BY order_month;



