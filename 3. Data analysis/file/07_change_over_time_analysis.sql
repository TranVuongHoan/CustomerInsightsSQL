/*
Change Over Time Analysis
*/

-- Analyse sales performance over time
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');

/*
1. Total Sales by Year:
In 2010, only one month (December) is recorded, with sales of about 43 thousand. In 2011, sales increased significantly, reaching approximately 6.5 million. In 2012, this grew to over 7.1 million. The biggest jump happened in 2013, where total sales reached nearly 17.7 million—more than double the previous year. Only January is available for 2014, so no full-year analysis can be made.
Conclusion: From 2011 to 2013, there was strong and consistent sales growth, suggesting increased market reach or consumer demand.

2. Average Sales per Customer:
In early 2011, the average sales per customer were around 3,200. By 2013, this number dropped to around 800–1,300 depending on the month. So while total sales rose, the amount each customer spent on average decreased. This could indicate lower prices, more discounts, or more customers purchasing smaller amounts.
Conclusion: Customer volume likely increased, but individual spending dropped.

3. Average Quantity per Customer:
In 2011, each customer purchased about 1 item on average. By 2013, this increased to over 2 items per customer in many months. This suggests that customers were buying more items per visit—possibly due to bundle deals, expanded product ranges, or better promotions.
Conclusion: The quantity purchased per customer improved steadily, which is a positive sign for product appeal or sales strategies.
*/