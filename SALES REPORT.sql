CREATE TABLE Supermarket_sale (
								Invoice_id VARCHAR(20), 
								Branch VARCHAR(5), 
								City VARCHAR(50),
								Customer_type VARCHAR(20),
								Gender VARCHAR(10),
								Product_line VARCHAR(100),
								Unit_price NUMERIC(10,2),
								Quantity INT,
								Tax_5 NUMERIC(10,2),
								Total NUMERIC(10,2),
								Date DATE,
								Time TIME,
								Payment VARCHAR(20),
								Cogs NUMERIC(10,2),
								Gross_Margin_percentage NUMERIC(10,2),
								Gross_income NUMERIC(10,2),
								Rating NUMERIC(4,2)
);


--KPI TOTAL SALES--
SELECT ROUND(SUM(total),2) AS Total_sales 
FROM Supermarket_sale;

--KPI TOTAL PROFIT--
SELECT ROUND(SUM(gross_income),2) AS Total_profit
FROM Supermarket_sale;

--KPI AVERAGE PROFIT--
SELECT ROUND(AVG(gross_margin_percentage),2) AS AVG_margin
FROM Supermarket_sale;

--KPI TOTAL TRANSACTIONS --
SELECT COUNT(DISTINCT invoice_id) AS Total_transactions
FROM supermarket_sale;


-- PRODUCT PERFORMANCE ANALYSIS --
SELECT *
FROM Supermarket_sale

SELECT product_line,
	   branch, 
	   ROUND(SUM(total), 2) AS Total_sales,
	   ROUND(SUM(quantity), 2) AS Total_quantity,
	   ROUND(SUM(gross_income), 2) AS TOtal_profit,
	   ROUND(AVG(rating), 2) AS Avg_rating
FROM Supermarket_sale
GROUP BY product_line, branch
ORDER BY total_sales DESC;

-- PROFITABILITY ANALYSIS--
SELECT branch, 
	   product_line,
	   ROUND(SUM(total), 2) AS total_sales,
	   ROUND(SUM(cogs), 2) AS total_cogs,
	   ROUND(SUM(gross_income), 2) AS total_profit,
	   ROUND(AVG(gross_margin_percentage), 2) AVG_margin
FROM Supermarket_sale
GROUP BY branch, product_line
ORDER BY total_profit DESC;

-- OPERATIONAL EFFICIENCY --
SELECT branch,
	   EXTRACT(HOUR FROM time) AS Sales_hour,
	   TO_CHAR(date, 'Day') AS day_of_week,
	   EXTRACT(DOW FROM date) AS day_number,
	   COUNT(invoice_id) AS total_Transactios,
	   ROUND(SUM(total), 2) AS total_sales
FROM Supermarket_sale
GROUP BY branch, EXTRACT(HOUR FROM time),TO_CHAR(date, 'Day'),EXTRACT(DOW FROM date)
ORDER BY branch, sales_hour;


-- MONTHLY TREND & STORE PERFORMANCE --
SELECT 
		DATE_TRUNC('month', date) AS month, branch,
		SUM(total) AS Total_sales, 
		SUM(gross_income) AS total_profit
FROM Supermarket_sale
GROUP BY DATE_TRUNC('month', date), branch
ORDER BY month;


SELECT 
		branch,
		ROUND(SUM(total), 2) AS total_sales,
		ROUND(SUM(gross_income), 2) AS total_profit,
		RANK() OVER(ORDER BY SUM(gross_income) DESC) AS Profit_rank
FROM Supermarket_sale
GROUP BY branch;


--Dimension Table---
SELECT DISTINCT branch AS Dim_branch
FROM Supermarket_sale;
