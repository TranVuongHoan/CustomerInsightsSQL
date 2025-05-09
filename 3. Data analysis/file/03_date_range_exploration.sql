/*
Date Range Exploration 
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.
*/

-- Determine the first and last order date and the total duration in months
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Find the youngest and oldest customer based on birthdate
SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;

/*
1. Sales Timeline Analysis
- First Order Date: 2010-12-29
-> Insights: Business operations began tracking sales in late 2010

- Last Order Date: 2014-01-28
-> Dataset covers until early 2014 (3+ years of data)

- Total Duration: 37 months
-> ~3.1 years of transactional history available

Key Observation: The data represents a complete business cycle from 2010-2014, suitable for identifying annual trends and seasonality.

2. Customer Demographics
Key Findings:
- 72-year age span between youngest and oldest customers
- Multi-generational appeal: Customer base spans from:
	+ Centenarians (likely family purchases)
	+ Prime-age millennials (core buying demographic)
- Data Quality Note: 109-year-old customer may require validation (potential data entry error)
/*