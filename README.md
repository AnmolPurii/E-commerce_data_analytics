# E-Commerce Data Analytics System for Operational Insights

## Overview

This project, **E-Commerce Data Analytics System for Operational Insights**, focuses on designing a scalable relational database for an e-commerce platform and performing business analysis using **SQL** and **Tableau** to derive actionable insights. The system helps understand customer behavior, product sales trends, and seller performance to support data-driven decision-making.

---

## Project Objectives

- Design a **normalized relational database** for an e-commerce platform.
- Perform **data extraction and analysis** using **SQL**.
- Develop **interactive dashboards** in **Tableau** to communicate findings.
- Provide **operational insights** to assist in decision-making for e-commerce operations.

---

## Tools & Technologies Used

- **SQL**
- **Tableau**
- **Microsoft Excel**

---

## Scope of the Project

1. **Database Design & Normalization**
   - Entity-Relationship (ER) modeling
   - Creation of relational tables with constraints and foreign keys
   - Normalization for data integrity

2. **Data Extraction & Analytics Using SQL**
   - KPI tracking (revenue, customer value, product performance)
   - Writing stored procedures, triggers, and functions for automation

3. **Data Visualization Using Tableau**
   - Dashboards for:
     - Sales trends
     - Top-selling products & categories
     - High-value customers
     - Revenue comparisons

4. **Insight Generation**
   - Data interpretation for strategic business decisions
   - Pattern and anomaly detection

---

## Entity-Relationship Diagram (ERD)

The system models key entities including:
- **Customers**
- **Sellers**
- **Products**
- **Orders**
- **Order Items**
- **Payments**
- **Reviews**
- **Carts**
- **Categories**

The database ensures referential integrity with the use of foreign keys and normalization up to the required level.

---

## Sample SQL Analytics

### 1. Top 5 Best-Selling Products
```sql
SELECT P.ProductName, SUM(OI.Quantity) AS TotalSold
FROM OrderItem OI
JOIN Product P ON OI.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalSold DESC
LIMIT 5;

