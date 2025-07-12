# Customer & Sales Analytics Project Summary

## Project Overview
**Objective**: Analyze 3+ years of customer/sales data (2010-2014) to uncover business insights and optimize operations.

**Data Scope**:
- 18,484 customers across 5+ countries
- 27,659 orders with 60,423 units sold
- $29.3M total revenue
- 295 product SKUs across 4 categories

## Key Work Phases

### 1. Data Examination
- Reviewed 3 core datasets:
  - Customer demographics (age, location, gender)
  - Product catalog (categories, pricing, maintenance)
  - Sales transactions (orders, dates, revenue)

### 2. Data Transformation
- Standardized date formats (YYYY-MM-DD)
- Validated referential integrity (customer/product keys)
- Cleaned categorical values (gender, marital status)
- Calculated derived metrics:
  - Customer age
  - Order fulfillment time
  - Product age at sale

### 3. Data Modeling
**Star Schema Implementation**:
- **Fact Table**: `fact_sales` (transactions)
- **Dimension Tables**: 
  - `dim_customers` (demographics)
  - `dim_products` (catalog details)
- Established PK/FK relationships for query optimization

### 4. Key Findings

**Customer Insights**:
- Balanced gender distribution (50.5% Male / 49.5% Female)
- Multi-generational appeal (ages 29-76)
- Geographic concentration: US (40%), Australia (19%)

**Product Performance**:
- Bikes drive 96% of revenue ($28.3M)
- Mountain-200 series top sellers ($1.3M per variant)
- Clothing underperforms (1% revenue share)

**Sales Trends**:
- 2013 breakout year ($16.3M revenue)
- Declining AOV (2010: $3,101 → 2014: $1,668)
- Healthy inventory turnover (205x)

## Strategic Recommendations

**Product**:
- Expand Mountain-200 line variants
- Bundle accessories with bikes
- Re-evaluate clothing category strategy

**Customer**:
- Launch VIP loyalty program
- Targeted win-back campaigns
- Enhance demographic segmentation

**Operations**:
- Improve demand forecasting
- Audit inventory management
- Clean CRM data for better analytics

## Tools & Techniques
- **SQL**: Complex queries with CTEs/window functions
- **Data Modeling**: Star schema implementation
- **Analysis**: Cohort analysis, trend forecasting

![Data](Image/modelsql.png)
