# 📊 SQL Business Intelligence & Executive Analytics Dashboard

> **Turning transactional data into actionable business insights using SQL and Power BI.**

## 📌 Project Overview

This project is an **Executive Business Intelligence Dashboard** built to analyze online retail transactions and provide a clear, decision-focused view of business performance.

The project uses **SQL as the primary analytical layer** to transform transactional data into business-ready metrics and summary views, which can then be used to build an interactive executive dashboard in **Power BI**.

The analysis focuses on:

- Revenue performance
- Order volume
- Customer behavior
- Product performance
- Geographic sales
- Monthly and yearly sales trends
- Customer segmentation
- Cancellation analysis

---

## 🎯 Business Objective

The objective of this project is to transform raw retail transaction data into meaningful business intelligence that can help answer questions such as:

- How much revenue is being generated?
- How many orders and customers are there?
- What is the average order value?
- How are sales changing over time?
- Which countries generate the most revenue?
- Which products generate the highest revenue?
- How many customers are repeat customers?
- How much revenue comes from repeat customers?
- What is the cancellation rate?
- Which customers generate the highest revenue?

---

## 🗂️ Dataset

The project uses the **Online Retail II** dataset from the **UCI Machine Learning Repository**.

The dataset contains transactional records from a UK-based online retail business and includes information such as:

- Invoice Number
- Stock Code
- Product Description
- Quantity
- Invoice Date
- Unit Price
- Customer ID
- Country

### Dataset Source

**UCI Machine Learning Repository – Online Retail II**

https://archive.ics.uci.edu/dataset/502/online%2Bretail%2Bii

> The original dataset is not included in this repository because of GitHub file-size limitations.

---

## 🛠️ Tools & Technologies

### SQL
- MySQL
- MySQL Workbench
- SQL Views
- Aggregations
- `GROUP BY`
- `ORDER BY`
- `CASE`
- `COUNT`
- `SUM`
- `ROUND`
- `DISTINCT`
- Date-based analysis
- Subqueries

### Data Visualization
- Power BI
- Interactive dashboards
- KPI cards
- Charts
- Tables
- Slicers

### Data Preparation
- Microsoft Excel
- CSV
- Data cleaning and transformation

---

## 🏗️ Project Workflow

```text
Raw Retail Dataset
        ↓
Data Cleaning
        ↓
MySQL Database
        ↓
SQL Analysis
        ↓
Business Intelligence Views
        ↓
Power BI Dashboard
        ↓
Executive Insights



## 🗄️ SQL Analysis

The SQL analysis creates several business intelligence views from the retail transaction data.

### 1. Executive KPIs

The `executive_kpis` view provides the main business performance indicators:

- Total Revenue
- Total Orders
- Total Customers
- Units Sold
- Average Order Value

Example output:

| KPI | Value |
|---|---:|
| Total Revenue | £17,743,429.18 |
| Total Orders | 36,969 |
| Total Customers | 5,878 |
| Units Sold | 10,706,167 |
| Average Order Value | £479.95 |

---

### 2. Monthly Sales

The `monthly_sales` view analyzes sales performance by:

- Year
- Month
- Revenue
- Units Sold
- Total Orders

This view supports the **monthly revenue trend** visualization in the dashboard.

---

### 3. Yearly Sales

The `yearly_sales` view summarizes:

- Year
- Total Revenue
- Units Sold
- Total Orders

This provides a high-level comparison of annual business performance.

---

### 4. Country Sales

The `country_sales` view analyzes business performance across countries.

Metrics include:

- Country
- Total Revenue
- Units Sold
- Total Orders

This supports geographic analysis and helps identify the major revenue-generating markets.

---

### 5. Top Products

The `top_products` view identifies products with the highest sales contribution.

Metrics include:

- Product Description
- Units Sold
- Total Revenue

This supports the **Top Products** section of the executive dashboard.

---

### 6. Customer Segments

Customers are classified into:

- **Repeat Customer**
- **One-Time Customer**

The classification is based on the number of completed orders associated with each customer.

The analysis also calculates:

- Customer Count
- Total Revenue

This helps understand the contribution of repeat customers to overall revenue.

---

### 7. Customer Sales

The `customer_sales` view provides customer-level sales information.

Metrics include:

- Customer ID
- Total Orders
- Units Sold
- Total Revenue

This can be used to identify high-value customers and understand customer purchasing behavior.

---

### 8. Cancellation Analysis

The `cancellation_summary` view analyzes cancelled versus completed orders.

It calculates:

- Cancelled Orders
- Completed Orders
- Total Orders
- Cancellation Rate

This provides an additional operational KPI for the executive dashboard.

---

## 📊 Dashboard

The Power BI dashboard is designed as an **executive-style Business Intelligence dashboard**.

The planned dashboard structure includes:

### KPI Section

- 💰 Total Revenue
- 🛒 Total Orders
- 👥 Total Customers
- 📦 Units Sold
- 💷 Average Order Value

### Sales Analysis

- Monthly Revenue Trend
- Yearly Sales Performance
- Revenue by Country
- Top Products

### Customer Analysis

- Repeat vs One-Time Customers
- Customer Revenue Analysis
- Top Customers

### Operational Analysis

- Cancellation Rate
- Completed vs Cancelled Orders
- Transaction-level details

### Interactive Filters

The dashboard will support filters such as:

- Date
- Year
- Country
- Product

---

## 💡 Key Business Questions

The project is designed to answer the following business questions:

1. What is the overall revenue generated?
2. How many orders have been completed?
3. How many unique customers have made purchases?
4. What is the average order value?
5. Which months generate the highest revenue?
6. Which countries contribute the most revenue?
7. Which products generate the highest revenue?
8. How many customers are repeat customers?
9. How much revenue is generated by repeat customers?
10. Which customers have the highest purchase value?
11. What proportion of orders are cancelled?
12. How does business performance change across years?

---

## 📁 Repository Structure

```text
sql-business-intelligence-executive-analytics-dashboard/
│
├── README.md
│
├── sql_business_intelligence.sql
│
└── dashboard/
    └── dashboard_screenshot.png
## 📈 Business Intelligence Approach

The project follows a simple BI architecture:

### Data Layer

Raw online retail transaction data.

### Analytical Layer

MySQL database containing cleaned transactional data and SQL analytical views.

### Visualization Layer

Power BI dashboard containing KPIs, trends, geographic analysis, product analysis, and customer insights.

### Decision Layer

Executive-level insights derived from the dashboard.

---

## 🚀 Future Improvements

Future improvements may include:

- RFM customer segmentation
- Customer lifetime value analysis
- Product category analysis
- Cohort analysis
- Customer retention analysis
- Advanced Power BI measures
- Automated data refresh
- Drill-through analysis
- Additional executive KPIs

---

## 👩‍💻 Author

### Lubna Shireen R

**B.Tech – Electronics & Communication Engineering | Data Science**

Interested in:

- Data Analytics
- Business Intelligence
- Data Science
- SQL
- Power BI
- Machine Learning
