CREATE DATABASE sql_bi_dashboard_db;
USE sql_bi_dashboard_db;

CREATE TABLE online_retail (
    `invoice_no` VARCHAR(20),
    `stock_code` VARCHAR(20),
    `description` VARCHAR(255),
    `quantity` INT,
    `invoice_date` DATETIME,
    `unit_price` DECIMAL(12,3),
    `customer_id` INT NULL,
    `country` VARCHAR(100),
    `revenue` DECIMAL(15,3),
    `year` INT,
    `month` INT,
    `month_name` VARCHAR(20),
    `year_month` VARCHAR(7)
);

SELECT COUNT(*) AS total_rows
FROM online_retail;

TRUNCATE TABLE online_retail;
SELECT COUNT(*) AS total_rows
FROM online_retail;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

USE sql_bi_dashboard_db;
LOAD DATA LOCAL INFILE 'C:/Users/lubna shireen/OneDrive/Documents/Lubna Work/Projects/SQL Business Intelligence & Executive Analytics Dashboard/online_retail_cleaned_sql.csv'
INTO TABLE online_retail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    `invoice_no`,
    `stock_code`,
    `description`,
    `quantity`,
    `invoice_date`,
    `unit_price`,
    `customer_id`,
    `country`,
    `revenue`,
    `year`,
    `month`,
    `month_name`,
    `year_month`
);
SELECT COUNT(*) AS total_rows
FROM online_retail;

SELECT *
FROM online_retail
LIMIT 5;

SELECT 
    ROUND(SUM(revenue), 2) AS total_revenue
FROM online_retail;
SELECT
    COUNT(DISTINCT invoice_no) AS total_orders
FROM online_retail
WHERE invoice_no NOT LIKE 'C%';
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM online_retail
WHERE customer_id IS NOT NULL;
SELECT
    ROUND(
        SUM(revenue) /
        COUNT(DISTINCT CASE
            WHEN invoice_no NOT LIKE 'C%' THEN invoice_no
        END),
        2
    ) AS average_order_value
FROM online_retail;
SELECT
    SUM(quantity) AS units_sold
FROM online_retail
WHERE invoice_no NOT LIKE 'C%';
SELECT
    ROUND(
        COUNT(DISTINCT CASE
            WHEN invoice_no LIKE 'C%' THEN invoice_no
        END) * 100.0
        / COUNT(DISTINCT invoice_no),
        2
    ) AS cancellation_rate
FROM online_retail;

SELECT
    `year_month`,
    ROUND(SUM(`revenue`), 2) AS total_revenue,
    SUM(`quantity`) AS units_sold,
    COUNT(DISTINCT `invoice_no`) AS total_orders
FROM `online_retail`
GROUP BY `year_month`
ORDER BY `year_month`;

SELECT
    `year_month`,
    ROUND(SUM(`revenue`), 2) AS total_revenue
FROM `online_retail`
GROUP BY `year_month`
ORDER BY `year_month`;
SELECT
    `country`,
    ROUND(SUM(`revenue`), 2) AS total_revenue
FROM `online_retail`
GROUP BY `country`
ORDER BY total_revenue DESC;

SELECT
    `description`,
    SUM(`quantity`) AS units_sold,
    ROUND(SUM(`revenue`), 2) AS total_revenue
FROM `online_retail`
WHERE `description` IS NOT NULL
GROUP BY `description`
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    `description`,
    SUM(`quantity`) AS units_sold,
    ROUND(SUM(`revenue`), 2) AS total_revenue
FROM `online_retail`
WHERE `description` IS NOT NULL
GROUP BY `description`
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    `customer_id`,
    ROUND(SUM(`revenue`), 2) AS total_revenue,
    SUM(`quantity`) AS units_sold,
    COUNT(DISTINCT `invoice_no`) AS total_orders
FROM `online_retail`
WHERE `customer_id` IS NOT NULL
  AND `invoice_no` NOT LIKE 'C%'
GROUP BY `customer_id`
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    `customer_id`,
    ROUND(SUM(`revenue`), 2) AS total_revenue,
    SUM(`quantity`) AS units_sold,
    COUNT(DISTINCT `invoice_no`) AS total_orders
FROM `online_retail`
WHERE `customer_id` IS NOT NULL
  AND `customer_id` <> 0
  AND `invoice_no` NOT LIKE 'C%'
GROUP BY `customer_id`
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    `description`,
    SUM(`quantity`) AS units_sold,
    ROUND(SUM(`revenue`), 2) AS total_revenue
FROM `online_retail`
WHERE `description` IS NOT NULL
  AND `invoice_no` NOT LIKE 'C%'
GROUP BY `description`
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    `country`,
    ROUND(SUM(`revenue`), 2) AS total_revenue,
    SUM(`quantity`) AS units_sold,
    COUNT(DISTINCT `invoice_no`) AS total_orders
FROM `online_retail`
WHERE `invoice_no` NOT LIKE 'C%'
GROUP BY `country`
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    COUNT(DISTINCT CASE
        WHEN `invoice_no` LIKE 'C%' THEN `invoice_no`
    END) AS cancelled_orders,
    
    COUNT(DISTINCT CASE
        WHEN `invoice_no` NOT LIKE 'C%' THEN `invoice_no`
    END) AS completed_orders,
    
    COUNT(DISTINCT `invoice_no`) AS total_orders
FROM `sql_bi_dashboard_db`.`online_retail`;

USE sql_bi_dashboard_db;
SELECT
    `invoice_no`,
    `invoice_date`,
    `customer_id`,
    `country`,
    `description`,
    `quantity`,
    ROUND(`revenue`, 2) AS revenue
FROM `online_retail`
WHERE `invoice_no` NOT LIKE 'C%'
ORDER BY `invoice_date` DESC
LIMIT 20;

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT
        `customer_id`,
        COUNT(DISTINCT `invoice_no`) AS total_orders
    FROM `online_retail`
    WHERE `customer_id` IS NOT NULL
      AND `customer_id` <> 0
      AND `invoice_no` NOT LIKE 'C%'
    GROUP BY `customer_id`
) AS customer_orders
GROUP BY customer_type
ORDER BY customer_count DESC;

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    ROUND(SUM(total_revenue), 2) AS total_revenue
FROM (
    SELECT
        `customer_id`,
        COUNT(DISTINCT `invoice_no`) AS total_orders,
        SUM(`revenue`) AS total_revenue
    FROM `online_retail`
    WHERE `customer_id` IS NOT NULL
      AND `customer_id` <> 0
      AND `invoice_no` NOT LIKE 'C%'
    GROUP BY `customer_id`
) AS customer_summary
GROUP BY customer_type
ORDER BY total_revenue DESC;

SELECT
    YEAR(invoice_date) AS sales_year,
    MONTH(invoice_date) AS sales_month,
    ROUND(SUM(revenue), 2) AS total_revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM online_retail
WHERE invoice_no NOT LIKE 'C%'
GROUP BY YEAR(invoice_date), MONTH(invoice_date)
ORDER BY sales_year, sales_month;

SELECT
    country,
    ROUND(SUM(revenue), 2) AS total_revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM online_retail
WHERE invoice_no NOT LIKE 'C%'
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    description,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM online_retail
WHERE description IS NOT NULL
  AND invoice_no NOT LIKE 'C%'
GROUP BY description
ORDER BY total_revenue DESC
LIMIT 10;
SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM online_retail
WHERE customer_id IS NOT NULL
  AND customer_id <> 0
  AND invoice_no NOT LIKE 'C%'
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    CASE
        WHEN total_orders > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS customer_type,
    COUNT(*) AS customer_count,
    ROUND(SUM(total_revenue), 2) AS total_revenue
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS total_orders,
        ROUND(SUM(revenue), 2) AS total_revenue
    FROM online_retail
    WHERE customer_id IS NOT NULL
      AND customer_id <> 0
      AND invoice_no NOT LIKE 'C%'
    GROUP BY customer_id
) AS customer_summary
GROUP BY customer_type
ORDER BY total_revenue DESC;

SELECT
    COUNT(DISTINCT CASE
        WHEN invoice_no LIKE 'C%' THEN invoice_no
    END) AS cancelled_orders,

    COUNT(DISTINCT CASE
        WHEN invoice_no NOT LIKE 'C%' THEN invoice_no
    END) AS completed_orders,

    COUNT(DISTINCT invoice_no) AS total_orders
FROM online_retail;

SELECT
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT invoice_no),
        2
    ) AS average_order_value
FROM online_retail
WHERE invoice_no NOT LIKE 'C%'
  AND customer_id IS NOT NULL
  AND customer_id <> 0;
  
  CREATE OR REPLACE VIEW executive_kpis AS
SELECT
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue) / COUNT(DISTINCT invoice_no), 2) AS average_order_value
FROM online_retail
WHERE invoice_no NOT LIKE 'C%';

SELECT * FROM executive_kpis;

CREATE OR REPLACE VIEW executive_kpis AS
SELECT
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT invoice_no),
        2
    ) AS average_order_value
FROM online_retail
WHERE invoice_no NOT LIKE 'C%'
    AND customer_id IS NOT NULL
    AND customer_id <> 0;
    SELECT * FROM executive_kpis;
    
    CREATE OR REPLACE VIEW monthly_sales AS
SELECT
    YEAR(invoice_date) AS sales_year,
    MONTH(invoice_date) AS sales_month,
    ROUND(SUM(revenue), 2) AS total_revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM online_retail
WHERE invoice_no NOT LIKE 'C%'
    AND customer_id IS NOT NULL
    AND customer_id <> 0
GROUP BY
    YEAR(invoice_date),
    MONTH(invoice_date)
ORDER BY
    sales_year,
    sales_month;
    SELECT * FROM monthly_sales;
    
    CREATE OR REPLACE VIEW country_sales AS
SELECT
    country,
    ROUND(SUM(revenue), 2) AS total_revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM online_retail
WHERE invoice_no NOT LIKE 'C%'
    AND customer_id IS NOT NULL
    AND customer_id <> 0
GROUP BY country
ORDER BY total_revenue DESC;

SELECT * FROM country_sales;

CREATE OR REPLACE VIEW top_products AS
SELECT
    description,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM online_retail
WHERE description IS NOT NULL
    AND invoice_no NOT LIKE 'C%'
    AND customer_id IS NOT NULL
    AND customer_id <> 0
GROUP BY description
ORDER BY total_revenue DESC
LIMIT 10;

SELECT * FROM top_products;
CREATE OR REPLACE VIEW customer_segments AS
SELECT
    CASE
        WHEN total_orders > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS customer_type,
    COUNT(*) AS customer_count,
    ROUND(SUM(total_revenue), 2) AS total_revenue
FROM
(
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS total_orders,
        SUM(revenue) AS total_revenue
    FROM online_retail
    WHERE customer_id IS NOT NULL
      AND customer_id <> 0
      AND invoice_no NOT LIKE 'C%'
    GROUP BY customer_id
) AS customer_summary
GROUP BY
    CASE
        WHEN total_orders > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END;
    SELECT * FROM customer_segments;

CREATE OR REPLACE VIEW yearly_sales AS
SELECT
    YEAR(invoice_date) AS sales_year,
    ROUND(SUM(revenue), 2) AS total_revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM online_retail
WHERE invoice_no NOT LIKE 'C%'
  AND customer_id IS NOT NULL
  AND customer_id <> 0
GROUP BY YEAR(invoice_date)
ORDER BY sales_year;

SELECT * FROM yearly_sales;

CREATE OR REPLACE VIEW customer_sales AS
SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM online_retail
WHERE customer_id IS NOT NULL
  AND customer_id <> 0
  AND invoice_no NOT LIKE 'C%'
GROUP BY customer_id
ORDER BY total_revenue DESC;

CREATE OR REPLACE VIEW cancellation_summary AS
SELECT
    COUNT(DISTINCT CASE
        WHEN invoice_no LIKE 'C%' THEN invoice_no
    END) AS cancelled_orders,

    COUNT(DISTINCT CASE
        WHEN invoice_no NOT LIKE 'C%' THEN invoice_no
    END) AS completed_orders,

    COUNT(DISTINCT invoice_no) AS total_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN invoice_no LIKE 'C%' THEN invoice_no
        END)
        / COUNT(DISTINCT invoice_no) * 100,
        2
    ) AS cancellation_rate
FROM online_retail;
SELECT * FROM cancellation_summary;
