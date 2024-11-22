CREATE DATABASE SalesAnalysis;

CREATE TABLE sales_sample (      /* Create a table named sales_sample */
Product_Id INT,
Region VARCHAR(50),
Date DATE,
Sales_Amount NUMERIC
);

INSERT INTO sales_sample (Product_Id, Region, Date, Sales_Amount)       /* Inserting data into sales_sample */
VALUES
(1, 'East', '2024-11-01', 500),
(2, 'West', '2024-11-02', 600),
(3, 'North', '2024-11-03', 700),
(4, 'South', '2024-11-04', 800),
(5, 'East', '2024-11-05', 900),
(6, 'West', '2024-11-06', 400),
(7, 'North', '2024-11-07', 300),
(8, 'South', '2024-11-08', 200),
(9, 'East', '2024-11-09', 1000),
(10, 'West', '2024-11-10', 1100);

SELECT                                    /* Drill Down-Analyze sales data at a more detailed level */
Region, 
Product_Id, 
SUM(Sales_Amount) AS Total_Sales
FROM 
sales_sample
GROUP BY 
Region, Product_Id
ORDER BY 
Region, Product_Id;

SELECT                                       /* Rollup- To summarize sales data at different levels of granularity */
Region, 
Product_Id , 
SUM(Sales_Amount) AS Total_Sales
FROM 
sales_sample
GROUP BY 
ROLLUP (Region, Product_Id)
ORDER BY 
Region, Product_Id;
							
SELECT                                       /* Cube - To analyze sales data from multiple dimensions simultaneously */
Region, 
Product_Id, 
Date, 
SUM(Sales_Amount) AS Total_Sales
FROM 
sales_sample
GROUP BY 
Region, Product_Id, Date
UNION ALL
SELECT 
Region, 
Product_Id, 
NULL AS Date, 
SUM(Sales_Amount) AS Total_Sales
FROM 
sales_sample
GROUP BY 
Region, Product_Id
HAVING 
Region IS NOT NULL AND Product_Id IS NOT NULL
UNION ALL
SELECT 
Region, 
NULL AS Product_Id, 
NULL AS Date, 
SUM(Sales_Amount) AS Total_Sales
FROM 
sales_sample
GROUP BY 
Region
HAVING 
Region IS NOT NULL
UNION ALL
SELECT 
NULL AS Region, 
NULL AS Product_Id, 
NULL AS Date, 
SUM(Sales_Amount) AS Total_Sales
FROM 
sales_sample;

SELECT                                 /* Slice- To extract a subset of data based on specific criteria */
Product_Id, 
Region, 
Date, 
Sales_Amount
FROM 
sales_sample
WHERE 
Date BETWEEN '2024-11-01' AND '2024-11-05';

SELECT                                     /* Dice - To extract data based on multiple criteria.*/
Product_Id, 
Region, 
Date, 
Sales_Amount
FROM 
sales_sample
WHERE 
Region IN ('East', 'West') 
AND Date BETWEEN '2024-11-01' AND '2024-11-07'
AND Sales_Amount > 400;