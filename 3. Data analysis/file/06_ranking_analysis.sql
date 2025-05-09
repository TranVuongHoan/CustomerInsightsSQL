/*
Ranking Analysis
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.
*/

-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue;

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;

-- The 3 customers with the fewest orders placed
SELECT TOP 3
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders ;

/*
Top Performing Products
Mountain Bike Series Dominance
- The Mountain-200 series generates exceptional revenue across all variants:
	+ Black-46: $1,373,454 (Rank #1)
	+ Black-42: $1,363,128 (Rank #2)
	+ Silver-38: $1,339,394 (Rank #3)
	+ Silver-46: $1,301,029 (Rank #4)
	+ Black-38: $1,294,854 (Rank #5)
- Key Insight: The 46-inch models outperform their smaller counterparts, suggesting customer preference for larger frame sizes. The black color variant slightly outperforms silver.

Other Product Performance
- Touring Tire Tube: $7,440 (top non-bike product)
- Bike Wash - Dissolver: $7,272
- Patch Kit/8 Patches: $6,382

Observation: Non-bike products generate significantly less revenue compared to the Mountain-200 series, with accessories averaging under $10,000 in revenue.

Customer Analysis
High-Value Customers
Top customers by revenue generation:
- Kailyn Henderson & Nichole Nara: $13,294 each
- Margaret He: $13,268
- Randall Dominguez: $13,265
- Adriana Gonzalez: $13,242
- Rosa Hu: $13,215

Pattern: The top 10 customers all generate between 12,914−13,294 in revenue, showing remarkably consistent high-value purchasing behavior.

Order Frequency Analysis
- Chloe Young, Wyatt Hill, and Jordan King each have only 1 order recorded
- Contrasts sharply with high-revenue customers who likely have multiple purchases

Insight: The business has both:
- A core group of loyal, high-spending customers
- Many one-time purchasers with minimal order history

Strategic Recommendations
- Mountain Bike Expansion:
	+ Develop additional color/frame size variants of the Mountain-200 series
	+ Consider premium pricing for 46-inch models given their popularity

- Customer Segmentation Strategy:
	+ Create loyalty programs for top 10 customers (all generating >$12,900)
	+ Develop win-back campaigns for one-time purchasers

- Product Development:
	+ Investigate why accessories generate so little revenue compared to bikes
	+ Consider bundling accessories with bike purchases

- Inventory Management:
	+ Prioritize stock availability for Mountain-200 series
	+ Review inventory levels for low-performing accessories

- Marketing Focus:
	+ Target marketing of larger frame sizes (46-inch)
	+ Highlight black color option as premium choice

*/
