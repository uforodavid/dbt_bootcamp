# Young Data Professionals dbt Bootcamp: Brazilian E-Commerce Analytics

A comprehensive dbt project using the Brazilian E-Commerce (Olist) dataset to demonstrate modern data transformation practices and analytics engineering patterns.

## 📊 Dataset Overview

**Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

**About the Data:**
- 100k orders from 2016 to 2018
- Multiple marketplaces in Brazil
- Real commercial data anonymized
- Complete order lifecycle including payments, reviews, and logistics

**Raw Tables:**
- `olist_customers_dataset` - Customer information and location
- `olist_orders_dataset` - Order status and timestamps
- `olist_order_items_dataset` - Items within orders
- `olist_order_payments_dataset` - Payment transactions
- `olist_order_reviews_dataset` - Customer reviews and ratings
- `olist_products_dataset` - Product catalog
- `olist_sellers_dataset` - Seller information
- `olist_geolocation_dataset` - Brazilian zip codes and coordinates

## 🎯 Business Questions We Can Answer

### Customer Analytics
- Who are our most valuable customers (Customer Lifetime Value)?
- What's our customer retention and repeat purchase rate?
- Which cities and states have the highest customer concentration?
- What's the average time between first and second purchase?
- How can we segment customers using RFM (Recency, Frequency, Monetary) analysis?
- What percentage of customers make only one purchase?

### Order & Sales Performance
- What's our monthly and quarterly revenue trend?
- What's the average order value by region and product category?
- How many orders are we processing daily/weekly/monthly?
- What's the order completion rate vs cancellation rate?
- Which product categories drive the most revenue?
- What's the seasonal trend in sales?

### Payment Insights
- What's the preferred payment method by region?
- How do installment plans affect order value?
- What's the average number of installments per order?
- What's the relationship between payment type and order value?
- Which payment methods have the highest transaction values?

### Operations & Logistics
- What's our average delivery time by state?
- Which sellers are performing best in terms of volume and ratings?
- What's our on-time delivery rate?
- Where are delivery delays most common?
- What's the correlation between delivery time and review scores?
- Which shipping routes are most efficient?

### Product Performance
- What are the top 10 products by revenue and volume?
- Which categories have the highest review scores?
- What's the product return/cancellation rate?
- What are common cross-sell opportunities?
- Which products have the longest delivery times?

## 🏗️ dbt Project Architecture

### Modeling Layers

We follow the **staging → intermediate → marts** pattern for clear data lineage and maintainability.

```
models/
├── staging/           # Clean, standardized raw data
├── intermediate/      # Business logic and enrichment
└── marts/            # Business-ready analytical models
    ├── core/         # Shared dimensions and facts
    ├── marketing/    # Customer analytics
    ├── sales/        # Revenue and sales metrics
    └── operations/   # Logistics and fulfillment
```

### Layer 1: Staging Models (`stg_`)

**Purpose:** Standardize and clean raw source data

```
models/staging/
├── _sources.yml
├── _stg_olist.yml
├── stg_olist__customers.sql
├── stg_olist__orders.sql
├── stg_olist__order_items.sql
├── stg_olist__order_payments.sql
├── stg_olist__order_reviews.sql
├── stg_olist__products.sql
├── stg_olist__sellers.sql
└── stg_olist__geolocation.sql
```

**Key Transformations:**
- Rename columns to follow consistent naming conventions
- Cast data types appropriately
- Parse and standardize dates
- Basic data quality filters
- No business logic or joins

### Layer 2: Intermediate Models (`int_`)

**Purpose:** Apply business logic and create reusable building blocks

```
models/intermediate/
├── _int_olist.yml
├── int_olist__order_enriched.sql           # Orders + items + payments joined
├── int_olist__customer_orders.sql          # Customer order aggregations
├── int_olist__order_delivery_metrics.sql   # Delivery performance calculations
├── int_olist__payment_summary.sql          # Payment aggregations per order
└── int_olist__product_metrics.sql          # Product-level metrics
```

**Key Transformations:**
- Join related staging models
- Calculate derived metrics
- Create flags and indicators
- Aggregate to appropriate grain

### Layer 3: Marts

**Purpose:** Business-ready models for specific use cases

#### Core Marts (`marts/core/`)

Foundational dimensional models following star schema design.

```
models/marts/core/
├── _core_olist.yml
├── dim_customers.sql      # Customer dimension
├── dim_products.sql       # Product dimension
├── dim_sellers.sql        # Seller dimension
├── dim_dates.sql          # Date dimension
├── dim_geography.sql      # Location dimension
└── fct_orders.sql         # Order fact table
```

**`fct_orders` - Grain: One row per order**
```sql
Columns:
- order_id (PK)
- customer_id (FK)
- seller_id (FK)
- order_date
- approved_date
- delivered_carrier_date
- delivered_customer_date
- estimated_delivery_date
- order_status
- total_order_value
- total_freight_value
- total_items
- payment_type
- payment_installments
- payment_value
- review_score
- delivery_days
- estimated_delivery_days
- is_delivered_on_time (boolean)
- is_delayed (boolean)
```

**`dim_customers` - Grain: One row per customer**
```sql
Columns:
- customer_id (PK)
- customer_unique_id
- customer_city
- customer_state
- customer_zip_code_prefix
- first_order_date
- last_order_date
- total_orders
- total_items_purchased
- total_revenue
- total_freight_paid
- avg_order_value
- avg_review_score
- customer_lifetime_days
- is_repeat_customer (boolean)
```

#### Marketing Marts (`marts/marketing/`)

Customer-focused analytics for retention and segmentation.

```
models/marts/marketing/
├── _marketing_olist.yml
├── customer_rfm_scores.sql
├── customer_ltv.sql
├── customer_cohorts.sql
└── customer_segments.sql
```

**`customer_rfm_scores` - RFM Analysis**
```sql
Columns:
- customer_id
- recency_days          # Days since last order
- frequency             # Total number of orders
- monetary_value        # Total spend
- recency_score (1-5)
- frequency_score (1-5)
- monetary_score (1-5)
- rfm_score            # Combined score (e.g., "555")
- customer_segment     # 'Champions', 'Loyal', 'At Risk', etc.
```

#### Sales Marts (`marts/sales/`)

Revenue and sales performance analytics.

```
models/marts/sales/
├── _sales_olist.yml
├── sales_daily.sql
├── sales_monthly.sql
├── sales_by_category.sql
├── sales_by_region.sql
└── sales_by_payment_method.sql
```

**`sales_daily` - Daily Sales Metrics**
```sql
Columns:
- date
- total_orders
- total_revenue
- total_items_sold
- avg_order_value
- unique_customers
- new_customers
- repeat_customers
- avg_delivery_days
- on_time_delivery_rate
```

#### Operations Marts (`marts/operations/`)

Logistics and operational efficiency metrics.

```
models/marts/operations/
├── _operations_olist.yml
├── delivery_performance.sql
├── seller_performance.sql
├── payment_analysis.sql
└── logistics_summary.sql
```

**`delivery_performance` - Delivery Analytics**
```sql
Columns:
- state
- city (optional)
- total_orders
- avg_delivery_days
- avg_estimated_delivery_days
- on_time_orders
- delayed_orders
- on_time_percentage
- avg_delay_days (for delayed orders)
- fastest_delivery_days
- slowest_delivery_days
```

## 🔧 dbt Features Demonstrated

### Testing Strategy

```yaml
# Example from models/marts/core/fct_orders.yml
models:
  - name: fct_orders
    tests:
      - dbt_utils.expression_is_true:
          expression: "total_order_value >= 0"
    columns:
      - name: order_id
        data_tests:
          - unique
          - not_null
      - name: customer_id
        data_tests:
          - not_null
          - relationships:
              to: ref('dim_customers')
              field: customer_id
      - name: delivered_customer_date
        data_tests:
          - dbt_utils.expression_is_true:
              expression: ">= order_date"
```

**Test Types:**
- Schema tests (unique, not_null, accepted_values, relationships)
- Data tests (custom SQL queries)
- dbt_utils tests (expression_is_true, recency, etc.)

### Documentation

- Comprehensive `.yml` files for each layer
- Column-level descriptions
- Model-level descriptions with business context
- Data lineage visualization with `dbt docs generate`

### Macros

```
macros/
├── calculate_rfm_score.sql
├── get_business_days.sql
├── safe_divide.sql
└── generate_schema_name.sql
```

Example macro usage for RFM calculation:
```sql
{{ calculate_rfm_score('recency_days', 'frequency', 'monetary_value') }}
```

### Incremental Models

For performance optimization on large fact tables:

```sql
-- models/marts/core/fct_orders.sql
{{
    config(
        materialized='incremental',
        unique_key='order_id',
        on_schema_change='fail'
    )
}}

SELECT ...
FROM {{ ref('int_olist__order_enriched') }}
{% if is_incremental() %}
    WHERE order_date > (SELECT MAX(order_date) FROM {{ this }})
{% endif %}
```

### Seeds

Reference data for enrichment:

```
seeds/
├── payment_type_mapping.csv
├── state_regions.csv
└── product_category_translations.csv
```

### Packages

Recommended dbt packages (in `packages.yml`):

```yaml
packages:
  - package: dbt-labs/dbt_utils
    version: 1.1.1
  - package: calogica/dbt_expectations
    version: 0.10.0
  - package: dbt-labs/codegen
    version: 0.12.0
```

## 📚 Bootcamp Curriculum Modules

### Module 1: Introduction to dbt & Setup
- dbt installation and project initialization
- Connecting to Database
- Understanding project structure
- Source configuration

### Module 2: Staging Models
- Source freshness checks
- Basic transformations
- Naming conventions
- CTEs and select statements

### Module 3: Intermediate Models
- Joining tables
- Window functions
- Aggregations
- Best practices for reusability

### Module 4: Dimensional Modeling
- Star schema concepts
- Building fact tables
- Creating dimension tables
- Slowly changing dimensions (SCD Type 2)

### Module 5: Business Logic in Marts
- Customer analytics
- Sales reporting
- KPI calculations
- Domain-specific modeling

### Module 6: Testing & Data Quality
- Schema tests
- Data tests
- Custom tests
- Testing strategy

### Module 7: Documentation
- Model documentation
- Column descriptions
- dbt docs generate and serve
- Exposures

### Module 8: Advanced Features
- Incremental models
- Snapshots
- Macros and Jinja
- Packages
- Setting Custom Schema

### Module 9: Performance & Optimization
- Query optimization
- Materialization strategies
- Partitioning and clustering
- Cost management

### Module 10: Production Deployment
- Environments (dev/prod)
- CI/CD with dbt Cloud or GitHub Actions
- Orchestration
- Monitoring and alerting

## 🚀 Getting Started

### Prerequisites
- Database/Datawarehouse
- dbt Core or dbt Cloud
- Python 3.8+
- Git

### Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/uforodavid/ydp_dbt_bootcamp.git
cd ydp_dbt_bootcamp
```

2. **Install dbt**
```bash
pip install dbt-snowflake
```

3. **Configure profiles.yml**
```yaml
dbt_olist:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: your_account
      user: your_username
      password: your_password
      role: your_role
      database: olist_dev
      warehouse: your_warehouse
      schema: dbt_your_name
      threads: 4
```

4. **Run dbt**
```bash
dbt deps           # Install packages
dbt seed           # Load seed files
dbt build           # Build models
dbt test           # Run tests
dbt docs generate  # Generate documentation
dbt docs serve     # View documentation
```

## 📈 Expected Outcomes

By completing this bootcamp, you will:
- Understand dbt fundamentals and best practices
- Build a production-ready dimensional model
- Implement comprehensive testing and documentation
- Create business-ready analytical models
- Learn performance optimization techniques
- Gain hands-on experience with real-world data scenarios

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Olist for providing the public dataset
- dbt Labs for the amazing transformation framework
- Young Data Professionals community for continuous learning and sharing

---

**Ready to start your dbt journey? Let's transform some data! 🎉**
