# 🛒 E-Commerce Sales Analysis using SQL

> A complete SQL data-analysis project built on **1,500 e-commerce
> orders** using MySQL.

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Rows](https://img.shields.io/badge/Dataset-1%2C500%20Rows-orange)
![Project](https://img.shields.io/badge/Project-Data%20Analysis-success)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

------------------------------------------------------------------------

## 📌 Project Overview

This project analyzes an e-commerce sales dataset using **MySQL** to
discover useful business insights related to:

-   💰 Revenue and sales performance
-   📦 Product performance
-   👥 Customer spending behavior
-   🏙️ City-wise sales
-   💳 Payment method performance
-   🏷️ Discount analysis
-   📅 Monthly sales trends
-   🏆 Product and category rankings

The project starts with basic SQL queries and progresses to advanced
concepts such as **CASE statements, subqueries, CTEs, RANK(),
ROW_NUMBER(), and PARTITION BY**.

------------------------------------------------------------------------

## 🎯 Objectives

1.  Calculate total and average sales.
2.  Identify the best-performing product categories.
3.  Find top-selling products.
4.  Identify high-value and loyal customers.
5.  Compare sales across cities.
6.  Analyze payment methods.
7.  Study monthly sales trends.
8.  Understand the effect of discounts.
9.  Practice advanced SQL techniques.
10. Convert raw sales data into business insights.

------------------------------------------------------------------------

## 📊 Dataset

**Dataset:** `ecommerce_sales_1500_rows.csv`

**Records:** 1,500

### Columns

  Column               Description
  -------------------- -------------------------
  `Order_ID`           Unique order identifier
  `Order_Date`         Date of the order
  `Customer_Name`      Customer name
  `City`               Customer city
  `Category`           Product category
  `Product`            Product name
  `Quantity`           Units purchased
  `Unit_Price`         Price per unit
  `Discount_Percent`   Discount applied
  `Total_Amount`       Final order amount
  `Payment_Method`     Payment method
  `Order_Status`       Order status

------------------------------------------------------------------------

## 🧰 Tools & Technologies

-   **MySQL**
-   **MySQL Workbench**
-   **CSV**
-   SQL Data Analysis

### SQL Concepts Used

`SELECT` · `WHERE` · `ORDER BY` · `GROUP BY` · `HAVING` · `COUNT()` ·
`SUM()` · `AVG()` · `CASE` · `LIMIT` · `Subqueries` · `CTEs` · `RANK()`
· `ROW_NUMBER()` · `PARTITION BY`

------------------------------------------------------------------------

## 📁 Project Structure

``` text
ecommerce-sql-project/
│
├── README.md
├── ecommerce_sales_analysis_project.sql
└── ecommerce_sales_1500_rows.csv
```

------------------------------------------------------------------------

## 🚀 How to Run

### 1. Clone the repository

``` bash
git clone https://github.com/YOUR-USERNAME/ecommerce-sql-project.git
cd ecommerce-sql-project
```

### 2. Open MySQL Workbench

Open:

``` text
ecommerce_sales_analysis_project.sql
```

### 3. Create the database

The SQL script contains:

``` sql
CREATE DATABASE ecommerce_project;
USE ecommerce_project;
```

### 4. Create the table

Run the `CREATE TABLE ecommerce_sales` section.

### 5. Import the CSV

In MySQL Workbench:

``` text
Schemas
→ ecommerce_project
→ Tables
→ Right Click
→ Table Data Import Wizard
→ Select ecommerce_sales_1500_rows.csv
```

### 6. Verify the data

``` sql
SELECT COUNT(*) AS Total_Rows
FROM ecommerce_sales;
```

Expected:

``` text
1500
```

------------------------------------------------------------------------

## 🔍 Key Analysis Questions

The project answers questions such as:

### 💰 Sales Analysis

-   What is the total revenue?
-   What is the average order value?
-   Which category generates the highest revenue?
-   Which city generates the highest sales?

### 📦 Product Analysis

-   What are the top 10 products by revenue?
-   Which products sell the most units?
-   What are the most expensive products?
-   Which product performs best within each category?

### 👥 Customer Analysis

-   Who are the top 10 customers by spending?
-   Which customers have the highest average order value?
-   Who are the loyal customers with at least 3 completed orders?

### 💳 Payment Analysis

-   Which payment method generates the highest revenue?
-   How many completed orders use each payment method?

### 📅 Time Analysis

-   How do sales vary month by month?
-   Which months perform best?

### 🏷️ Discount Analysis

-   How are sales distributed across discount percentages?
-   How does discount level relate to sales?

### 🧠 Advanced SQL

-   Which orders are above average order value?
-   How do products rank by revenue?
-   Which product ranks #1 within each category?
-   Which product generates the highest revenue in each city?

------------------------------------------------------------------------

## ⭐ Featured SQL Examples

### Top 10 Products by Revenue

``` sql
SELECT
    Product,
    SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;
```

### Loyal Customers

``` sql
SELECT
    Customer_Name,
    COUNT(*) AS Total_Orders,
    SUM(Total_Amount) AS Total_Spent
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Customer_Name
HAVING COUNT(*) >= 3
ORDER BY Total_Spent DESC;
```

### Product Ranking

``` sql
SELECT
    Product,
    SUM(Total_Amount) AS Total_Sales,
    RANK() OVER (
        ORDER BY SUM(Total_Amount) DESC
    ) AS Sales_Rank
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Product
ORDER BY Sales_Rank;
```

### Top Product in Each City

``` sql
WITH city_product_sales AS (
    SELECT
        City,
        Product,
        SUM(Total_Amount) AS Total_Sales
    FROM ecommerce_sales
    WHERE Order_Status = 'Completed'
    GROUP BY City, Product
),
ranked_products AS (
    SELECT
        City,
        Product,
        Total_Sales,
        ROW_NUMBER() OVER (
            PARTITION BY City
            ORDER BY Total_Sales DESC
        ) AS Product_Rank
    FROM city_product_sales
)
SELECT
    City,
    Product,
    Total_Sales
FROM ranked_products
WHERE Product_Rank = 1;
```

------------------------------------------------------------------------

## 📈 Business Value

This analysis can help an e-commerce business:

-   Identify high-performing products.
-   Understand customer purchasing behavior.
-   Find valuable and repeat customers.
-   Compare regional performance.
-   Monitor payment preferences.
-   Track monthly revenue trends.
-   Evaluate discount strategies.
-   Make data-driven decisions.

------------------------------------------------------------------------

## 🧠 What I Learned

Through this project, I practiced:

-   Writing SQL queries from scratch.
-   Data aggregation and filtering.
-   Business-oriented data analysis.
-   `GROUP BY` and `HAVING`.
-   Nested queries and subqueries.
-   Common Table Expressions.
-   Window functions.
-   Ranking and partitioning.
-   Turning raw data into meaningful insights.

------------------------------------------------------------------------

## 🔮 Future Improvements

Possible next steps:

-   Build a **Power BI dashboard**.
-   Add interactive sales visualizations.
-   Create customer segmentation.
-   Add profit and cost columns.
-   Perform monthly growth analysis.
-   Add advanced KPI calculations.

------------------------------------------------------------------------

## 👨‍💻 Author

**Your Name**

> SQL Data Analysis Project --- E-Commerce Sales

If you found this project useful, consider giving the repository a ⭐.

------------------------------------------------------------------------

## 📜 License

This project is intended for educational and portfolio purposes.
