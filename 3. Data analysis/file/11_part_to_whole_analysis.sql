/*

Part-to-Whole Analysis
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.
*/
-- Which categories contribute the most to overall sales?
WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;

/*
1. Strategic Insights
- Bikes (96.46%):
	+ Core Revenue Generator: Accounts for nearly all sales.
	+ Opportunity: Expand high-margin bike models (e.g., premium/VIP offerings).
	+ Risk: Over-reliance on one category; diversify to mitigate market shocks.

- Accessories (2.39%):
	+ Upsell Potential: Complements bike purchases (e.g., helmets, locks).
	+ Action: Bundle with bikes or promote via targeted campaigns.

- Clothing (1.16%):
	+ Underperformance: Likely due to weak branding or limited assortment.
	+ Fix: Rebrand as lifestyle merchandise (e.g., cycling apparel collaborations).

3. Recommendations
A. Double Down on Bikes
- Launch limited editions or custom builds to boost margins.
- Offer subscription services (e.g., maintenance + accessories).

B. Grow Accessories
- Bundling: "Bike + Accessory" kits at a discount.
- Visibility: Feature accessories at checkout (online/in-store).

C. Revitalize Clothing
- Partnerships: Collaborate with cycling influencers for branded gear.
- Quality Upgrade: Invest in technical fabrics (e.g., moisture-wicking).
*/