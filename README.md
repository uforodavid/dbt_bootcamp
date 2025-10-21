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
- `olist_customers` - Customer information and location
- `olist_orders` - Order status and timestamps
- `olist_order_items` - Items within orders
- `olist_order_payments` - Payment transactions
- `olist_order_reviews` - Customer reviews and ratings
- `olist_products` - Product catalog
- `olist_sellers` - Seller information

## 🚀 Getting Started

### Prerequisites
- DWH
- dbt Core or dbt Cloud
- Python 3.10+
- Git

### Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/uforodavid/dbt_bootcamp.git
cd dbt_bootcamp
```

2. **Install dbt**
```bash
pip install dbt-(your-database-adapter-name
```

3. **Configure profiles.yml**
```bash
dbt debug
```
to check connection status

5. **Load raw data into Snowflake**
```bash
dbt seed
```
to load datasets into your datawarehouse


## 📈 Expected Outcomes

By completing this bootcamp, you will:
- Understand dbt fundamentals and best practices
- Build a production-ready dimensional model
- Implement comprehensive testing and documentation
- Create business-ready analytical models
- Learn performance optimization techniques
- Gain hands-on experience with real-world data scenarios


## 📚 Bootcamp Curriculum Structure

## 🗓️ Day 1: dbt Fundamentals (2 hours)
**Level:** Beginner  
**Goal:** Understand dbt basics and build your first models

### Module 1.1: Welcome to dbt Fundamentals (15 min)
- What is dbt and why use it?
- Analytics engineering workflow
- Introduction to the Brazilian E-Commerce dataset
- Bootcamp overview and learning objectives

### Module 1.2: Analytics Development Lifecycle (20 min)
- The modern data stack
- Understanding the ADLC (Analyze → Design → Load → Clean → Test)
- How dbt fits in the data workflow
- Version control with Git basics

### Module 1.3: Set Up dbt (25 min)
**Hands-on Lab:**
- Install dbt Core or set up dbt Cloud
- Configure `profiles.yml`
- Initialize your dbt project
- Understand project structure (`dbt_project.yml`, folders)
- Run your first `dbt debug` and `dbt run`

### Module 1.4: Sources (25 min)
**Hands-on Lab:**
- Defining sources in `_sources.yml`
- Using `{{ source('schema', 'table') }}`
- Source freshness checks
- Building complete staging layer for all 8 tables
- Understanding staging best practices

### Module 1.5: Models (35 min)
**Hands-on Lab:**
- What are models and materializations?
- Building your first staging model: `stg_olist__customers.sql`
- Using CTEs and SELECT statements
- Naming conventions and folder structure
- Building `stg_olist__orders.sql` and `stg_olist__order_items.sql`
- Understanding refs: `{{ ref('model_name') }}`
- Run models with `dbt run` and `dbt run --select model_name`

**Day 1 Deliverable:** Complete staging layer with 8 staging models

---

## 🗓️ Day 2: Testing, Documentation & Modeling (2 hours)
**Level:** Beginner to Intermediate  
**Goal:** Ensure data quality and build intermediate models

### Module 2.1: Data Tests (35 min)
**Hands-on Lab:**
- Introduction to data testing philosophy
- Schema tests: unique, not_null, accepted_values, relationships
- Writing tests in `.yml` files
- Running tests with `dbt test`
- Building custom data tests (e.g., `assert_positive_order_value.sql`)
- Installing and using dbt_utils package
- Advanced tests: `expression_is_true`, `recency`

### Module 2.2: Documentation (30 min)
**Hands-on Lab:**
- Why documentation matters
- Documenting models and columns in `.yml` files
- Adding descriptions and metadata
- Generating docs: `dbt docs generate`
- Viewing docs: `dbt docs serve`
- Understanding the DAG (Directed Acyclic Graph)
- Using doc blocks for rich documentation

### Module 2.3: Intermediate Models (30 min)
**Hands-on Lab:**
- Building `int_olist__order_enriched.sql` (joining orders + items + payments)
- Using window functions for customer metrics
- Aggregating data at different grains
- Creating reusable intermediate models
- Best practices for the intermediate layer

### Module 2.4: Dimensional Modeling Basics (25 min)
- Introduction to star schema
- Fact vs dimension tables
- Slowly changing dimensions (SCD) concepts
- Planning our marts layer structure

**Day 2 Deliverable:** Tested and documented staging layer + 3 intermediate models

---

## 🗓️ Day 3: Advanced Modeling & Deployment (2 hours)
**Level:** Intermediate to Advanced  
**Goal:** Build production-ready marts and understand deployment

### Module 3.1: Building Fact Tables (35 min)
**Hands-on Lab:**
- Designing `fct_orders.sql` 
- Choosing the right grain (one row per order)
- Adding calculated fields (delivery days, on-time flags)
- Implementing business logic
- Testing fact table integrity
- Custom target schemas with macros

### Module 3.2: Building Dimension Tables (35 min)
**Hands-on Lab:**
- Creating `dim_customers.sql` with aggregated metrics
- Building `dim_products.sql` and `dim_sellers.sql`
- Creating `dim_geography.sql` for location analysis
- Implementing slowly changing dimensions (SCD Type 2) - theory and basic implementation

### Module 3.3: Analyses and Seeds (15 min)
**Hands-on Lab:**
- Understanding the analyses folder
- Ad-hoc analysis queries
- Using seeds for reference data
- Loading `payment_type_mapping.csv` and `state_regions.csv`
- Referencing seeds in models

### Module 3.4: Deployment Fundamentals (35 min)
**Hands-on Lab:**
- Understanding environments (dev vs prod)
- Configuring target schemas
- Using environment variables
- Introduction to dbt Cloud jobs (or dbt Cloud alternative with CLI)
- Running production jobs
- Scheduling basics

**Day 3 Deliverable:** Complete dimensional model (1 fact + 4 dimensions) ready for production

---

## 🗓️ Day 4: Advanced Concepts & Production Practices (2 hours)
**Level:** Advanced  
**Goal:** Master advanced dbt features for production environments

### Module 4.1: Jinja, Macros, Exposures, and Packages (40 min)
**Hands-on Lab:**
- Introduction to Jinja templating
- Using variables and conditionals
- Writing your first macro: `calculate_rfm_score()`
- Creating reusable macros for business logic
- Using dbt packages (dbt_utils, dbt_expectations)
- Package management with `packages.yml`
- Defining downstream dependencies
- Documenting BI dashboards

### Module 4.2: Incremental Models (35 min)
**Hands-on Lab:**
- Why incremental models matter
- Converting `fct_orders` to incremental
- Understanding `unique_key` and `on_schema_change`
- Using `is_incremental()` macro
- Strategies: append, merge, delete+insert
- Testing incremental models
- Backfilling data

### Module 4.3: Snapshots (20 min)
**Hands-on Lab:**
- Understanding slowly changing dimensions with snapshots
- Creating a snapshot for product prices or order status
- Snapshot strategies: timestamp vs check
- Running snapshots
- Querying snapshot tables
- Use cases for snapshots

### Module 4.4: Advanced Testing & Orchestration (15 min)
- Custom schema tests
- Test configurations and severity
- Understanding orchestration concepts
- Job scheduling strategies
- CI/CD basics with GitHub Actions
- Monitoring and alerting
- Setting up webhooks in dbt Cloud
- Triggering downstream workflows

### Module 4.5: Materialization Fundamentals (10 min)
- Understanding materializations: table, view, incremental, ephemeral
- When to use each materialization
- Performance considerations
- Cost optimization strategies

**Day 4 Deliverable:** Production-ready dbt project with incremental models, snapshots, and custom macros

---

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
