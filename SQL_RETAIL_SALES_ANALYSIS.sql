CREATE DATABASE p1_retail_db;


--Create table
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

--. Data Exploration & Cleaning

--Determine the total number of records in the dataset.
SELECT COUNT(*) FROM retail_sales;

--Find out how many unique customers are in the dataset.
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

--Identify all unique product categories in the dataset.
SELECT DISTINCT category FROM retail_sales;

--Check for any null values in the dataset and delete records with missing data.
SELECT * FROM retail_sales_tb
WHERE 
    sale_date IS NULL 
	OR sale_time IS NULL
	OR customer_id IS NULL
	OR gender IS NULL
	OR age IS NULL
	OR category IS NULl
	OR quantiy IS NULL
	OR price_per_unit IS NULL
	OR cogs IS NULL;

DELETE FROM retail_sales_tb
WHERE 
    sale_date IS NULL
	OR sale_time IS NULL
	OR customer_id IS NULL
	OR gender IS NULL
	OR age IS NULL
	OR category IS NULL
	OR quantiy IS NULL
	OR price_per_unit IS NULL
	OR cogs IS NULL;

--Data Analysis & Findings
--Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM retail_sales_tb
WHERE sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT 
  *
FROM retail_sales_tb
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4

--Write a SQL query to calculate the total sales (total_sale) for each category.**:
select category,sum(total_Sale),count(*) from retail_sales_tb
group by category
order by 1

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) from retail_Sales_tb
where category='Beauty'

--Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from retail_sales_tb 
where total_Sale>1000

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,count(transactions_id) from retail_sales_tb
group by 1,2
order by 1

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
year,
month,
avg_sale
from


(
select 
extract(year from sale_date)as year,
extract(month from sale_date)as month,
avg(total_sale) as Avg_Sale,
rank()over(partition by extract(year from sale_date)order by avg(total_sale)desc)as rank

from retail_sales_tb
group by 1,2
)as t1
where rank =1

--Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale) from retail_Sales_tb
group by 1
order by 2 desc

limit 5

--Write a SQL query to find the number of unique customers who purchased items from each category.
select category ,count(distinct customer_id) from retail_Sales_tb
group by 1

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales_tb
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

--END OF THE PROJECT


















