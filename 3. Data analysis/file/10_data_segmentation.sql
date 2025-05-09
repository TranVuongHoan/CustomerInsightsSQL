/*

Data Segmentation Analysis

Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/
WITH product_segments AS (
    SELECT
        product_key,
        product_name,
        cost,
        CASE 
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500 THEN '100-500'
            WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM gold.dim_products
)
SELECT 
    cost_range,
    COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/
WITH customer_spending AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount) AS total_spending,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key
)
SELECT 
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT 
        customer_key,
        CASE 
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS segmented_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;

/*
1. Strategic Insights:
- Mass Market Focus
	+ 73% of products priced under 500 indicate a volume-driven strategy
	+ These likely generate revenue through high turnover despite lower margins

- Premium Segment Opportunity
	+ The 30% in 500+ ranges represent higher-margin potential
	+ Requires targeted marketing to high-value customers

- Balanced Portfolio Structure
	+ Relatively even distribution between budget and mid-range tiers
	+ Clear premium/luxury differentiation at higher price points

Recommended Actions:
- For sub-500 products: Focus on volume strategies (bundling, cross-selling)
- For 500+ products: Enhance premium positioning and value-added services
- Profitability analysis: Identify which segments deliver best actual margins (not just unit count)
- This distribution suggests a strategically diversified portfolio covering all major price points, with opportunities to optimize performance within each tier.

2. Key Insights
- Dominance of New Customers:
- Newcomers make up 81% of the customer base, indicating either:
✓ Successful acquisition strategies
✓ Potential retention challenges

- Loyalty Pipeline Leakage:
	+ Only 12% become "Regular" and 9% reach "VIP" status
	+ Suggests room to improve engagement post-first purchase

- VIP Opportunity:
	+ Though just 9% of total, VIPs likely contribute >30% of revenue (Pareto Principle)

3. Strategic Recommendations
A. Retention Focus
- Launch onboarding programs to convert New → Regular (e.g., post-purchase discounts)
- Implement loyalty tiers with incremental benefits

B. VIP Cultivation
- Exclusive perks: Early access, concierge services
- Predictive analytics to identify potential VIPs early

C. Data Enhancement
Track:
- Customer Lifetime Value (LTV) per segment
- Retention rates at 30/90/365 days

*/