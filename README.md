# 🛫 Air Travel Data Warehouse – USA  

**Authors:** Quentin Grégoire & Mohamed Hassan  
**Date:** November 2025  

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python)
![SQL](https://img.shields.io/badge/SQL-Server-CC2927?logo=microsoftsqlserver&logoColor=white)
![Airflow](https://img.shields.io/badge/Apache-Airflow-017CEE?logo=apache-airflow)
![SSIS](https://img.shields.io/badge/ETL-SSIS-green)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## 🧭 Project Overview  
This project designs and implements a **Data Warehouse (DWH)** for **U.S. air travel analytics**, integrating multiple public datasets from the **U.S. Department of Transportation – Bureau of Transportation Statistics**.

The objective is to provide a **unified analytical environment** for:  
✈️ Performance and trend analysis  
📈 Demand forecasting & route optimization  
💰 Profitability & traffic insights  

---

## 🧱 Architecture  
The DWH follows a **Medallion Architecture** (Bronze–Silver–Gold) ensuring clean, scalable, and analytics-ready data.  

```
Raw Data → Bronze → Silver → Gold → Business Analytics
```

### 🟤 Bronze Layer  
Raw data ingestion & minimal preprocessing.  
Technologies: **Python, Pandas, SQL Server**

### ⚪ Silver Layer  
Data cleaning, transformation & dimensional modeling.  
Technologies: **SSIS, SQL Server**

### 🟡 Gold Layer  
Aggregation, KPI computation & reporting.  
Technologies: **SSIS, Airflow**

---

## ⚙️ Tech Stack  

| Component | Technology |
|------------|-------------|
| **Programming** | Python, Pandas |
| **Database** | Microsoft SQL Server |
| **Orchestration** | Apache Airflow |
| **ETL** | SSIS Pipelines |
| **Automation** | SQL Server Agent |
| **Version Control** | Git / GitHub |

---

## 📊 Data Sources  
- **Monthly Air Travel Data:** Flights & passenger volume  
- **Quarterly Fare Data:** Pricing & historical fare trends  
- **Airports & Carriers:** Geographical and operational details  
- **Aircraft Inventory:** Model specifications & carrier fleet details  

_Source: U.S. Department of Transportation – Bureau of Transportation Statistics_

---

## 📈 Performance Summary  
- Processed **78M+ rows** from raw CSV datasets  
- Achieved **75% performance gain** through indexing & optimized ETL design  
- Created **Flights Master Table (106 columns)** for analytical reporting  
- **Total ETL runtime:** ~2 hours (Bronze → Gold)  

---

## 🚀 Key Takeaways  
- Efficient handling of **large-scale datasets**  
- Integration of **automated ETL pipelines** using Airflow  
- Implementation of **dimension modeling** for analytical readiness  
- **Optimized SQL performance** and workflow orchestration  

---

## 🔮 Future Enhancements  
- Migration to **cloud data warehouse (Azure / AWS)**  
- **Automated performance reporting**  
- **Data enrichment** with predictive features  

---

## 🪪 License  
This project is licensed under the **MIT License** – see the [LICENSE](./LICENSE) file for details.

---

> _“Transforming raw air travel data into actionable insights through a structured, scalable data architecture.”_
