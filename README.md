# Sales & Customer Analytics

## Project Overview

This project focuses on sales and customer data analysis using SQL and Google BigQuery, with data visualization developed in Looker Studio.

The objective is to transform raw e-commerce data into structured datasets and develop analyses that support business performance monitoring and customer understanding.

<img width="1085" height="803" alt="aba1" src="https://github.com/user-attachments/assets/6617ff61-edec-4b5e-ae99-2898084eff3d" />

<img width="1085" height="808" alt="Aba 2" src="https://github.com/user-attachments/assets/ad896f58-0bb2-4340-ab65-184bcee3741c" />


## Tools & Technologies

- **SQL (GoogleSQL):** Data transformation, aggregation, and analytical queries.
- **Google BigQuery:** Data processing and storage.
- **Looker Studio:** Dashboard development and data visualization.
- **GitHub:** SQL version control and project documentation.

## SQL Concepts & Functions Used

The project applies the following SQL concepts and functions:

| Category | Commands / Functions |
|---|---|
| Data manipulation | `SELECT`, `CREATE OR REPLACE TABLE` |
| Data relationships | `INNER JOIN`, `LEFT JOIN`, `ON` |
| Data transformation | `CAST`, `DATE_TRUNC` |
| Aggregation | `SUM`, `GROUP BY` |
| Common Table Expressions | `WITH`, CTEs |
| Window functions | `LAG()`, `ROW_NUMBER()`, `OVER()`, `PARTITION BY` |
| Sorting | `ORDER BY` |
| Conditional logic | `CASE WHEN`, `BETWEEN`, `ELSE`, `END` |

## Data Transformation & Analysis

### 1. Order Data Transformation
- Joined order items with product information.
- Converted timestamp fields into date fields.
- Aggregated sales revenue, product costs, and profit by order-related dimensions.

### 2. Monthly Revenue Growth
- Aggregated revenue by month.
- Used the `LAG()` window function to retrieve previous month's revenue.
- Calculated month-over-month (MoM) revenue growth.

### 3. Customer Purchase Analysis
- Joined customer and order data.
- Aggregated purchase values by customer and order.
- Used `ROW_NUMBER()` to sequence customer purchases.
- Segmented customers by age group.
- Classified customers as new or returning based on purchase sequence.

## Repository Structure

```text
sales-customer-analytics/
│
├── sql/
│   ├── 01_order_data_transformation.sql
│   ├── 02_monthly_revenue_mom.sql
│   └── 03_customer_purchase_analysis.sql
│
└── README.md
```

## Dashboard

[View Interactive Dashboard]
https://datastudio.google.com/reporting/9a26b927-df93-46a9-ae08-4e63d699b60f

## Project Status

**Version 1.0** — Initial data transformation, customer analysis, and dashboard development.

Further improvements and additional analytical approaches may be incorporated in future versions.
