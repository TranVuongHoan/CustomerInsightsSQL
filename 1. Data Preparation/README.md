# Data Preparation

## Data Examination

In the initial phase of the project, I examined the original data files, which were provided in table format. Below is a summary of the fields contained in each file:

### `gold_customers.png`: Contains information about customers.

- `customer_id`: Unique identifier for each customer  
- `customer_number`: Customer account number  
- `first_name`: Customer's first name  
- `last_name`: Customer's last name  
- `country`: Customer's country of residence  
- `marital_status`: Marital status (Married/Single)  
- `gender`: Gender (Male/Female)  
- `birthdate`: Date of birth  
- `create_date`: Date when customer account was created  

### `gold_products.png`: Contains product information.

- `product_key`: Unique product identifier  
- `product_id`: Product SKU or model number  
- `product_number`: Product reference number  
- `product_name`: Full product name  
- `category_id`: Product category identifier  
- `category`: Broad product category (e.g., Components, Bikes, Clothing)  
- `subcategory`: Specific product type (e.g., Road Frames, Mountain Bikes, Socks)  
- `maintenance_cost`: Whether the product requires maintenance (Yes/No)  
- `product_line`: Product line classification  
- `start_date`: Date when product was introduced  

### `gold_sales.png`: Contains sales transaction records.

- `order_number`: Unique sales order identifier  
- `product_key`: References product_key in products table  
- `customer_key`: References customer_id in customers table  
- `order_date`: Date when order was placed  
- `shipping_date`: Date when order was shipped  
- `due_date`: Expected delivery date  
- `sales_amount`: Total sale amount  
- `quantity`: Number of units sold  
- `price`: Unit price  

## Data Transformation

To prepare the data for efficient analysis, I took the following transformation steps:

### 1. Data Structure Validation
- Verified that all `customer_key` values in sales data exist in customers table
- Confirmed all `product_key` values in sales data exist in products table
- Checked for consistent data types across related fields

### 2. Date Format Standardization
- Converted all date fields (`birthdate`, `create_date`, `order_date`, `shipping_date`, `due_date`, `start_date`) to standardized `YYYY-MM-DD` format
- Validated date ranges for logical consistency (e.g., birthdates before create dates)

### 3. Data Cleaning
- Standardized categorical values (e.g., "Married"/"Single", "Male"/"Female", "Yes"/"No")
- Verified numerical ranges (positive values for prices, quantities, sales amounts)
- Checked for missing values in critical fields (`customer_id`, `product_key`, `order_number`)

### 4. Relationship Mapping
- Created reference dictionaries to map:
  - Customer IDs to customer names and demographics
  - Product keys to product details and categories
  - Order numbers to full transaction details

### 5. Data Enhancement
- Calculated derived fields:
  - Customer age from birthdate
  - Order fulfillment time (`shipping_date` - `order_date`)
  - Product age at time of sale (`order_date` - `start_date`)

### 6. Data Validation
- Cross-referenced sales amounts with quantity × price calculations
- Verified country names for consistency
- Checked product categorization logic

## Data Quality Notes

The following observations were made during data preparation:

1. **Customer Data**:
   - Majority of customers are from Australia (22) followed by United States (9) and Canada (2)
   - Age range spans from 29 to 76 years old
   - Gender distribution is relatively balanced (17 Male, 16 Female)

2. **Product Data**:
   - Products fall into 3 main categories: Components, Bikes, and Clothing
   - Mountain bikes and road bikes are the most common subcategories
   - Maintenance requirements vary by product type

3. **Sales Data**:
   - Orders contain 1-4 line items each
   - Prices range from $2 to $159 per unit
   - All orders in the sample were placed and shipped in March 2013

![Data](image/gold.dim_customers.png)
![Data](image/gold.fact_sales.png)
![Data](image/gold.dim_products.png)
