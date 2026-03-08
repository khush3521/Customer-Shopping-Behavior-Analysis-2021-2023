# 🛍️ Customer Shopping Behavior Analysis (2021–2023)

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-025E8C?style=for-the-badge&logo=postgresql&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-005C84?style=for-the-badge)
![Power Query](https://img.shields.io/badge/Power%20Query-217346?style=for-the-badge&logo=microsoft&logoColor=white)
![Status](https://img.shields.io/badge/Project-Completed-success?style=for-the-badge)

> 🏬 Multiple shopping malls | 👥 Multi-demographic analysis | 📅 3 years of transactional data (2021–2023)

---

## 📊 End-to-End Analytics Pipeline

```
Raw Transactional Data → SQL (Exploration & Validation) → Power Query (Cleaning) → DAX (KPIs) → Power BI (5-Page Dashboard) → Business Insights
```

---

## 📌 Project Overview

Retail businesses across multiple malls were struggling to answer a core question: **who is buying what, when, and how** — and what should the business do about it?

This project analyzes **3 years of customer transactional data (2021–2023)** across multiple shopping malls to uncover demographic spending patterns, category performance, payment behavior, and seasonal trends. The output is a **5-page interactive Power BI report** designed for retail decision-makers.

---

## 🎯 Business Problem

Retail managers face these questions every quarter:

- Which customer segments drive the most revenue?
- Which product categories are underperforming in which malls?
- Do payment methods signal customer value?
- When are the seasonal dips — and how do we respond?

This project answers all of them with data.

---

## 📷 Dashboard Preview

### 📌 Page 1 — Executive Overview
[![Executive Overview](01_Executive%20Overview.png)](https://github.com/khush3521/Customer-Shopping-Behavior-Analysis-2021-2023-/blob/main/01_Executive%20Overview.png)

### 📌 Page 2 — Gender Analysis
[![Gender Analysis](02_GENDER%20ANALYSIS.png)](https://github.com/khush3521/Customer-Shopping-Behavior-Analysis-2021-2023-/blob/main/02_GENDER%20ANALYSIS.png)

### 📌 Page 3 — Age Group Analysis
[![Age Analysis](03_Age%20analysis.png)](https://github.com/khush3521/Customer-Shopping-Behavior-Analysis-2021-2023-/blob/main/03_Age%20analysis.png)

### 📌 Page 4 — Category & Mall Analysis
[![Category & Mall](04_Category%20%26%20Mall%20Analysis.png)](https://github.com/khush3521/Customer-Shopping-Behavior-Analysis-2021-2023-/blob/main/04_Category%20%26%20Mall%20Analysis.png)

### 📌 Page 5 — Payment Method Analysis
[![Payment Analysis](05_Payment%20Method%20Analysis.png)](https://github.com/khush3521/Customer-Shopping-Behavior-Analysis-2021-2023-/blob/main/05_Payment%20Method%20Analysis.png)

---

## 📈 Key Insights & Business Impact

| Finding | Business Implication |
|---|---|
| **Credit card transactions have higher avg order value** | Incentivize card payments to increase revenue per transaction |
| **Cash dominates volume but drives lower spend** | Digital payment promotions could significantly lift revenue |
| **Clear seasonal dips in specific months** | Front-load campaigns in low-revenue months to smooth the curve |
| **Small number of categories drive majority of revenue** | Focus inventory and shelf space on high-performing categories |
| **Shopping behavior varies significantly by age group** | Age-targeted marketing will outperform generic campaigns |
| **Mall performance varies by category mix** | Each mall needs a tailored product-mix strategy |

---

## 📊 Dashboard Pages

### 🔹 Page 1 — Executive Overview
High-level business summary for senior stakeholders — Total Revenue, Transactions, Products Sold, Average Order Value, revenue trends, and payment method distribution.

### 🔹 Page 2 — Gender Analysis
Shopping distribution by gender, products sold and revenue by gender, category preference breakdown — answers "who is buying what?"

### 🔹 Page 3 — Age Group Analysis
Revenue and purchase volume across age segments, category preferences by age group — answers "which generation spends most and on what?"

### 🔹 Page 4 — Category & Mall Analysis
Overall category performance, mall-wise category revenue, demographic-driven category behavior — answers "which products work where?"

### 🔹 Page 5 — Payment Method Analysis
Payment type distribution, revenue by payment method, relationship between payment method, age group, and category — answers "how payment behavior signals customer value."

---

## 🧠 DAX Measures

```DAX
-- Total Revenue
Total Revenue = SUMX(shopping_data, shopping_data[Price] * shopping_data[Quantity])

-- Total Transactions
Total Transactions = COUNTROWS(shopping_data)

-- Average Order Value
Avg Order Value = DIVIDE([Total Revenue], [Total Transactions])

-- Total Products Sold
Total Products Sold = SUM(shopping_data[Quantity])

-- Revenue by Gender
Revenue Female = 
CALCULATE([Total Revenue], shopping_data[Gender] = "Female")

Revenue Male = 
CALCULATE([Total Revenue], shopping_data[Gender] = "Male")

-- Credit Card Revenue Share
Credit Card Revenue % =
DIVIDE(
    CALCULATE([Total Revenue], shopping_data[PaymentMethod] = "Credit Card"),
    [Total Revenue]
)

-- YoY Revenue Growth
YoY Growth % =
VAR CurrentYear = CALCULATE([Total Revenue], YEAR(shopping_data[InvoiceDate]) = YEAR(TODAY()))
VAR PriorYear = CALCULATE([Total Revenue], YEAR(shopping_data[InvoiceDate]) = YEAR(TODAY()) - 1)
RETURN DIVIDE(CurrentYear - PriorYear, PriorYear)
```

---

## 🗄️ SQL Analysis

```sql
-- Revenue by gender
SELECT Gender,
       COUNT(*) AS Transactions,
       SUM(Price * Quantity) AS Total_Revenue,
       ROUND(AVG(Price * Quantity), 2) AS Avg_Order_Value
FROM shopping_data
GROUP BY Gender
ORDER BY Total_Revenue DESC;

-- Revenue by age group
SELECT 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 40 THEN '25–40'
        WHEN Age BETWEEN 41 AND 55 THEN '41–55'
        ELSE '55+' 
    END AS Age_Group,
    SUM(Price * Quantity) AS Total_Revenue,
    COUNT(*) AS Transactions
FROM shopping_data
GROUP BY Age_Group
ORDER BY Total_Revenue DESC;

-- Top categories by revenue
SELECT Category,
       SUM(Price * Quantity) AS Revenue,
       COUNT(*) AS Transactions,
       ROUND(AVG(Price * Quantity), 2) AS Avg_Spend
FROM shopping_data
GROUP BY Category
ORDER BY Revenue DESC;

-- Payment method vs average order value
SELECT PaymentMethod,
       COUNT(*) AS Transactions,
       ROUND(AVG(Price * Quantity), 2) AS Avg_Order_Value,
       SUM(Price * Quantity) AS Total_Revenue
FROM shopping_data
GROUP BY PaymentMethod
ORDER BY Avg_Order_Value DESC;

-- Monthly revenue trend (seasonal analysis)
SELECT 
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    SUM(Price * Quantity) AS Monthly_Revenue
FROM shopping_data
GROUP BY Year, Month
ORDER BY Year, Month;
```

---

## 🛠 Tools & Technologies

| Tool | Purpose |
|------|---------|
| Power BI Desktop | 5-page interactive dashboard |
| DAX | KPI calculations & business measures |
| SQL | Data exploration, segmentation & validation |
| Power Query | Data cleaning, feature engineering, type correction |

---

## 📂 Dataset Attributes

| Column | Description |
|---|---|
| Invoice Number | Unique transaction ID |
| Customer ID | Unique customer identifier |
| Gender | Male / Female |
| Age | Customer age (used to create age groups) |
| Category | Product category purchased |
| Quantity | Number of items bought |
| Price | Price per unit |
| Payment Method | Cash / Credit Card / Debit Card |
| Invoice Date | Transaction date (2021–2023) |
| Shopping Mall | Mall where purchase was made |

---

## 🔮 Future Improvements

- Add **RFM segmentation** (Recency, Frequency, Monetary) for customer scoring
- Build **predictive churn model** using Python + scikit-learn
- Add **drill-through pages** per mall for deeper operational insights
- Publish to **Power BI Service** for live web sharing
- Integrate with **live POS data feed** for real-time dashboard

---

## 📂 Repository Structure

```
Customer-Shopping-Behavior-Analysis-2021-2023/
│
├── data/
│   └── shopping_data.csv
│
├── powerbi/
│   └── Customer_Shopping_Analysis.pbix
│
├── sql/
│   └── shopping_analysis.sql
│
├── 01_Executive Overview.png
├── 02_GENDER ANALYSIS.png
├── 03_Age analysis.png
├── 04_Category & Mall Analysis.png
├── 05_Payment Method Analysis.png
└── README.md
```

---

## 👨‍💻 Author

**Khush Panchal** — Data Analyst
Specializing in retail analytics, customer segmentation & business intelligence

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/khush-panchal-96b557352)
[![GitHub](https://img.shields.io/badge/GitHub-Portfolio-black?style=flat&logo=github)](https://github.com/khush3521)

---

⭐ If you found this project valuable, please consider starring this repository!
