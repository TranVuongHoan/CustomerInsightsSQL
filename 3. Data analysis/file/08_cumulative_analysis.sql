/*
Cumulative Analysis
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
    SELECT 
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t

/*
 1. Year-over-Year Sales Performance
2010: Sales = 43K → This was the starting point.

2011: Sales = ~7.1M → Massive jump, indicating likely business expansion or product launch.

2012: Sales = ~5.8M → Slight decline from 2011, possibly due to market saturation or external factors.

2013: Sales = ~16.3M → Huge spike, nearly triple the previous year, suggesting a highly successful year (promotions, product line, seasonal campaigns, etc.).

2014: Sales = 45K → Only includes January, so not useful for full-year comparison.

✅ Observation: The business experienced a strong upward trend from 2010 to 2013, with minor fluctuation in 2012. 2013 stands out as a breakthrough year.

🟦 2. Cumulative Sales Trend (Running Total)
By 2011, cumulative sales hit ~7.1M

By 2012, cumulative = ~13M

By 2013, cumulative = ~29.3M

✅ Observation: Cumulative growth was accelerating—each year added significantly more than the last. This signals compounding growth, which is ideal in a maturing business.

🟦 3. Moving Average Price Trend
2010: Avg Price ≈ 3,101

2011: ≈ 3,146 (slight increase)

2012: ≈ 2,670 (drop)

2013: ≈ 2,080 (further drop)

2014: ≈ 1,668

✅ Observation: While sales increased, average price steadily decreased over time. This is common in high-growth phases where businesses reduce prices to increase volume (e.g., discounts, bulk deals, market penetration strategies).
/*