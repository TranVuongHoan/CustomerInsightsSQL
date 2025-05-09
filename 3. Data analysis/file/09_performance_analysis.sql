/*
Performance Analysis (Year-over-Year, Month-over-Month)
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.
*/

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

WITH yearly_product_sales AS (
    SELECT
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY 
        YEAR(f.order_date),
        p.product_name
)
SELECT
    order_year,
    product_name,
    current_sales,
    AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
    current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
    CASE 
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
    -- Year-over-Year Analysis
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
    CASE 
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS py_change
FROM yearly_product_sales
ORDER BY product_name, order_year;

/*
1. Cyclical Sales Patterns (2012–2014)
- Many products (e.g., All-Purpose Bike Stand, AWC Logo Cap) show a boom-bust cycle:
	+ 2012: Below average sales
	+ 2013: Sharp increase (often 10–100x growth)
	+ 2014: Sudden drop back below average

- Suggests inventory mismanagement, demand misforecasting, or market saturation.

2. High-Performing Products
- Premium bikes (Mountain-200, Road-150 series) show consistent, massive growth:
	+ *Mountain-200 Black 38*: +900,000 units (2011–2013)
	+ *Road-150 Red 48*: +1.19M units (2010–2011)

- Indicates strong brand loyalty and premium market potential.

3. Volatile Apparel & Accessories
- Extreme fluctuations in clothing (e.g., Classic Vests, Short-Sleeve Jerseys):
	+ Classic Vest L: 11,968 (2013) → 512 (2014)
	+ Short-Sleeve Jersey S: 21,384 (2013) → 486 (2014)

- Points to poor demand forecasting, seasonal mismatches, or quality issues.

4. Consistently "Average" Products
- Some items (*Mountain-400-W, Touring-1000*) match exact average sales yearly.
- Could indicate:
	+ Overly rigid inventory controls
	+ Missed growth opportunities

5. Strategic Implications
- Strengths: Premium bikes are high-growth, high-margin products.
- Weaknesses: Apparel suffers from unpredictable demand swings.
- Opportunities: Improve forecasting, expand premium bike lines.
- Threats: Cyclical drops risk overstocking/stockouts.

Recommended Actions
- Fix forecasting models (especially for apparel).
- Leverage premium bike success (expand marketing, variants).
- Investigate causes of sales cycles (inventory policies, market trends).
- Review "average" products for hidden growth potential.
*/