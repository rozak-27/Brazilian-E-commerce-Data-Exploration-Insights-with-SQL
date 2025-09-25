# Brazilian E-commerce Data Exploration & Insights with SQL

This project analyses **100,000+ Target orders from Brazil** to uncover operational trends and actionable insights across orders, payments, freight, delivery performance, product attributes and customer reviews.

## 📊 Dataset

Public e-commerce dataset from Brazil (Olist/Target), containing:
- Customers (location & demographics)
- Orders (timestamps, status)
- Order items (products, price, freight)
- Payments (type, value, installments)
- Reviews (ratings, comments)

## 🎯 Objectives

As a data analyst at “Target”, the goal was to:
- Explore the structure and characteristics of the dataset
- Identify trends in orders over time and by geography
- Analyse payments, freight and delivery performance
- Derive insights on customer behaviour and operational efficiency

## 📝 Key Analyses Performed

- **Exploratory analysis**  
  – Checked column data types  
  – Calculated order time ranges  
  – Counted unique customer cities and states  

- **Order trends & seasonality**  
  – Yearly and monthly trends in order counts  
  – Time-of-day analysis (Dawn, Morning, Afternoon, Night)

- **Geographical distribution**  
  – Month-on-month orders per state  
  – Customer distribution across states  

- **Economic impact**  
  – % increase in order cost from 2017 to 2018 (Jan–Aug)  
  – Total & average order price per state  
  – Total & average freight value per state  

- **Logistics & delivery performance**  
  – Calculated actual delivery time and difference vs. estimated delivery  
  – Identified top states by highest/lowest average freight and delivery times  
  – Highlighted states with fastest deliveries relative to estimates  

- **Payments analysis**  
  – Month-on-month orders by payment type  
  – Orders by number of installments  

## 🛠️ Tools & Skills

- SQL (BigQuery syntax)
- Window functions, CTEs, aggregations and joins
- E-commerce analytics and KPI calculation

## 📂 Repository Contents

- `Brazilian E-commerce Data Exploration & Insights with SQL.sql` – SQL scripts answering all the above business questions

## 🚀 How to Use

1. Import the dataset into your SQL environment (BigQuery or similar).
2. Run the queries from the `.sql` file sequentially to reproduce the analysis.
3. Modify the queries for your own dataset or business needs.

## 📈 Outcomes

The analysis provides clear insights into customer ordering behaviour, regional trends, delivery performance and payment patterns, supporting data-driven decision making for operations and marketing.

