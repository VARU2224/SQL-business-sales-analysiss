
-- Project 2: SQL Business Sales Analysis
-- Database: SQLite
-- Dataset: 10 sample sales records

CREATE TABLE sales (
    order_id INTEGER PRIMARY KEY,
    product TEXT,
    category TEXT,
    region TEXT,
    sales_amount REAL,
    profit REAL,
    quantity INTEGER
);

INSERT INTO sales VALUES
(1, 'Laptop', 'Electronics', 'North', 50000, 8000, 5),
(2, 'Phone', 'Electronics', 'South', 30000, 5000, 10),
(3, 'Tablet', 'Electronics', 'East', 20000, 3000, 8),
(4, 'Laptop', 'Electronics', 'West', 45000, 7000, 4),
(5, 'Phone', 'Electronics', 'North', 35000, 6000, 12),
(6, 'Tablet', 'Electronics', 'South', 22000, 2500, 7),
(7, 'Laptop', 'Electronics', 'East', 55000, 10000, 6),
(8, 'Phone', 'Electronics', 'West', 32000, 4500, 9),
(9, 'Tablet', 'Electronics', 'North', 18000, 2000, 5),
(10, 'Laptop', 'Electronics', 'South', 60000, 12000, 6);

-- 1. Overall business performance
SELECT
    SUM(sales_amount) AS total_revenue,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM sales;

-- 2. Sales by product
SELECT product, SUM(sales_amount) AS total_sales
FROM sales
GROUP BY product
ORDER BY total_sales DESC;

-- 3. Sales and profit by region
SELECT
    region,
    SUM(sales_amount) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- 4. Profit by product
SELECT product, SUM(profit) AS total_profit
FROM sales
GROUP BY product
ORDER BY total_profit DESC;

-- 5. Revenue contribution by product
SELECT
    product,
    ROUND(
        SUM(sales_amount) * 100.0 /
        (SELECT SUM(sales_amount) FROM sales), 2
    ) AS revenue_percentage
FROM sales
GROUP BY product
ORDER BY revenue_percentage DESC;

-- 6. Orders above average order value
SELECT order_id, product, region, sales_amount
FROM sales
WHERE sales_amount > (SELECT AVG(sales_amount) FROM sales)
ORDER BY sales_amount DESC;

-- 7. Rank orders by sales
SELECT
    order_id,
    product,
    sales_amount,
    RANK() OVER (ORDER BY sales_amount DESC) AS sales_rank
FROM sales;
