-- E-COMMERCE SALES ANALYSIS USING SQL
-- MySQL Project | Dataset: ecommerce_sales_1500_rows.csv

CREATE DATABASE ecommerce_project;
USE ecommerce_project;

CREATE TABLE ecommerce_sales (
    Order_ID VARCHAR(20) PRIMARY KEY,
    Order_Date DATE,
    Customer_Name VARCHAR(100),
    City VARCHAR(50),
    Category VARCHAR(50),
    Product VARCHAR(100),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Percent INT,
    Total_Amount DECIMAL(12,2),
    Payment_Method VARCHAR(50),
    Order_Status VARCHAR(30)
);

-- IMPORT CSV USING MYSQL WORKBENCH:
-- Schemas > ecommerce_project > Tables > Right Click >
-- Table Data Import Wizard > select ecommerce_sales_1500_rows.csv

-- VERIFY DATA
SELECT COUNT(*) AS Total_Rows FROM ecommerce_sales;
SELECT * FROM ecommerce_sales LIMIT 10;

-- 1. TOTAL SALES
SELECT SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed';

-- 2. TOTAL ORDERS
SELECT COUNT(*) AS Total_Orders FROM ecommerce_sales;

-- 3. COMPLETED ORDERS
SELECT COUNT(*) AS Completed_Orders
FROM ecommerce_sales
WHERE Order_Status = 'Completed';

-- 4. AVERAGE ORDER VALUE
SELECT AVG(Total_Amount) AS Average_Order_Value
FROM ecommerce_sales
WHERE Order_Status = 'Completed';

-- 5. CATEGORY-WISE SALES
SELECT Category, SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 6. CATEGORY-WISE ORDER COUNT
SELECT Category, COUNT(*) AS Total_Orders
FROM ecommerce_sales
GROUP BY Category
ORDER BY Total_Orders DESC;

-- 7. COMPLETE CATEGORY PERFORMANCE
SELECT Category, COUNT(*) AS Total_Orders,
       SUM(Quantity) AS Total_Quantity_Sold,
       SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 8. CITY-WISE SALES
SELECT City, SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY City
ORDER BY Total_Sales DESC;

-- 9. TOP 10 PRODUCTS BY REVENUE
SELECT Product, SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;

-- 10. TOP 10 PRODUCTS BY QUANTITY
SELECT Product, SUM(Quantity) AS Total_Quantity_Sold
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Product
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;

-- 11. MOST EXPENSIVE PRODUCTS
SELECT Product, Category, Unit_Price
FROM ecommerce_sales
ORDER BY Unit_Price DESC
LIMIT 10;

-- 12. TOP PRODUCT + CATEGORY PERFORMANCE
SELECT Category, Product,
       SUM(Quantity) AS Total_Quantity_Sold,
       SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Category, Product
ORDER BY Total_Sales DESC
LIMIT 10;

-- 13. TOP 10 CUSTOMERS
SELECT Customer_Name, COUNT(*) AS Total_Orders,
       SUM(Total_Amount) AS Total_Spent
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Customer_Name
ORDER BY Total_Spent DESC
LIMIT 10;

-- 14. CUSTOMER AVERAGE ORDER VALUE
SELECT Customer_Name, COUNT(*) AS Total_Orders,
       AVG(Total_Amount) AS Average_Order_Value
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Customer_Name
ORDER BY Average_Order_Value DESC
LIMIT 10;

-- 15. LOYAL CUSTOMERS
SELECT Customer_Name, COUNT(*) AS Total_Orders,
       SUM(Total_Amount) AS Total_Spent,
       AVG(Total_Amount) AS Average_Order_Value
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Customer_Name
HAVING COUNT(*) >= 3
ORDER BY Total_Spent DESC;

-- 16. PAYMENT METHOD PERFORMANCE
SELECT Payment_Method, COUNT(*) AS Total_Orders,
       SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Payment_Method
ORDER BY Total_Sales DESC;

-- 17. ORDER STATUS DISTRIBUTION
SELECT Order_Status, COUNT(*) AS Total_Orders
FROM ecommerce_sales
GROUP BY Order_Status
ORDER BY Total_Orders DESC;

-- 18. MONTH-WISE SALES
SELECT YEAR(Order_Date) AS Year, MONTH(Order_Date) AS Month,
       SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- 19. DISCOUNT-WISE SALES
SELECT Discount_Percent, COUNT(*) AS Total_Orders,
       SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Discount_Percent
ORDER BY Discount_Percent;

-- 20. ORDER VALUE CLASSIFICATION
SELECT Order_ID, Customer_Name, Total_Amount,
       CASE
           WHEN Total_Amount >= 50000 THEN 'High Value'
           WHEN Total_Amount >= 20000 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS Order_Category
FROM ecommerce_sales
WHERE Order_Status = 'Completed';

-- 21. HIGH/MEDIUM/LOW VALUE ORDERS
SELECT
    CASE
        WHEN Total_Amount >= 50000 THEN 'High Value'
        WHEN Total_Amount >= 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Order_Category,
    COUNT(*) AS Total_Orders,
    SUM(Total_Amount) AS Total_Sales
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY
    CASE
        WHEN Total_Amount >= 50000 THEN 'High Value'
        WHEN Total_Amount >= 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END
ORDER BY Total_Sales DESC;

-- 22. SUBQUERY: ABOVE AVERAGE ORDERS
SELECT Order_ID, Customer_Name, Total_Amount
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
  AND Total_Amount > (
      SELECT AVG(Total_Amount)
      FROM ecommerce_sales
      WHERE Order_Status = 'Completed'
  )
ORDER BY Total_Amount DESC;

-- 23. CTE: CATEGORY PERFORMANCE
WITH category_sales AS (
    SELECT Category, COUNT(*) AS Total_Orders,
           SUM(Total_Amount) AS Total_Sales
    FROM ecommerce_sales
    WHERE Order_Status = 'Completed'
    GROUP BY Category
)
SELECT Category, Total_Orders, Total_Sales
FROM category_sales
ORDER BY Total_Sales DESC;

-- 24. WINDOW FUNCTION: PRODUCT RANKING
SELECT Product, SUM(Total_Amount) AS Total_Sales,
       RANK() OVER (ORDER BY SUM(Total_Amount) DESC) AS Sales_Rank
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Product
ORDER BY Sales_Rank;

-- 25. CATEGORY-WISE PRODUCT RANKING
SELECT Category, Product, SUM(Total_Amount) AS Total_Sales,
       RANK() OVER (
           PARTITION BY Category
           ORDER BY SUM(Total_Amount) DESC
       ) AS Category_Rank
FROM ecommerce_sales
WHERE Order_Status = 'Completed'
GROUP BY Category, Product
ORDER BY Category, Category_Rank;

-- 26. TOP PRODUCT IN EACH CITY
WITH city_product_sales AS (
    SELECT City, Product, SUM(Total_Amount) AS Total_Sales
    FROM ecommerce_sales
    WHERE Order_Status = 'Completed'
    GROUP BY City, Product
),
ranked_products AS (
    SELECT City, Product, Total_Sales,
           ROW_NUMBER() OVER (
               PARTITION BY City
               ORDER BY Total_Sales DESC
           ) AS Product_Rank
    FROM city_product_sales
)
SELECT City, Product, Total_Sales
FROM ranked_products
WHERE Product_Rank = 1
ORDER BY Total_Sales DESC;

-- END OF PROJECT
