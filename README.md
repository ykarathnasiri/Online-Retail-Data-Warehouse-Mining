# Online Retail Data Warehousing, Mining & Analysis using Google BigQuery

## Project Overview

This repository contains the code and documentation for a data warehousing and data mining project focused on the "Online Retail II" dataset from the UCI Machine Learning Repository. The primary goal is to demonstrate an end-to-end analytics workflow, including:

1.  **Data Warehousing:** Designing and implementing a Star Schema data warehouse in Google BigQuery.
2.  **ETL:** Extracting, transforming (cleaning), and loading data from the raw source into the structured warehouse using BigQuery SQL.
3.  **OLAP Analysis:** Simulating Online Analytical Processing (OLAP) operations (Roll-up, Drill-down, Slice, Dice) on the warehouse data.
4.  **Data Mining:** Applying clustering (K-Means, DBSCAN) for customer segmentation and association rule mining (Apriori) for market basket analysis using Python.
5.  **Visualization:** (External) Insights are visualized using a Google Looker Studio dashboard connected to the BigQuery warehouse.

## Core Components

### 1. Data Warehouse (Google BigQuery)
*   **Schema:** Star Schema with a central `FactSales` table and dimensions: `DimCustomer`, `DimDate`, `DimInvoice`, `DimProduct`.
*   **Design Rationale:** Chosen for simplicity, analytical query performance, and BI tool compatibility. Surrogate keys are used for dimension primary keys.
*   **Architecture:** Leverages BigQuery as a ROLAP system, utilizing its scalable, serverless infrastructure and columnar storage.

### 2. ETL Process (BigQuery SQL)
*   **Workflow:** Raw CSV data (staged in GCS) -> Load to BigQuery Raw Table -> **`etl_transformation.sql`** (Cleaning & Transformation) -> Cleaned `data` table -> **`schema_ddl/*.sql`** (Populate Star Schema).
*   **Key Transformations:** Handling cancellations, cleaning/standardizing `StockCode`, filtering NULLs/invalid numerics, calculating `TotalPrice`, standardizing data types.

### 3. OLAP Analysis (Python & BigQuery SQL)
*   **Notebook:** `OLAP_Cube_Analysis.ipynb`
*   **Methodology:** Simulates OLAP cube operations (Roll-up, Drill-down, Slice, Dice) by executing SQL queries against the BigQuery Star Schema via the Python client. Visualizations generated using Matplotlib/Seaborn.

### 4. Data Mining (Python)
*   **Notebook:** `Data_Mining_Reporting.ipynb`
*   **Clustering:**
    *   *Objective:* Customer segmentation based on `NumberOfPurchases` and `TotalSpent`.
    *   *Algorithms:* K-Means (with Elbow method for 'k' selection) and DBSCAN.
    *   *Preprocessing:* Data aggregated from BigQuery, features scaled using `StandardScaler`.
*   **Association Rule Mining:**
    *   *Objective:* Discover frequently co-purchased products (Market Basket Analysis).
    *   *Algorithm:* Apriori (using `mlxtend`).
    *   *Metrics:* Support, Confidence, Lift.
    *   *Data Prep:* Transaction data queried from BigQuery, transformed into a one-hot encoded basket matrix.

### 5. Dashboarding (Google Looker Studio)
*   **Tool:** Google Looker Studio (External to this repository).
*   **Connection:** Connects directly to the BigQuery data warehouse tables (`FactSales` and Dimensions).
*   **Purpose:** Visualize key performance indicators, trends, segments, and rules derived from the DWH and DM steps. *(A link to the dashboard should be included in the final report)*.

## Technology Stack

*   **Cloud Platform:** Google Cloud Platform (GCP)
*   **Data Storage/Staging:** Google Cloud Storage (GCS)
*   **Data Warehouse/Processing:** Google BigQuery
*   **Languages:** SQL (BigQuery Standard SQL), Python 3
*   **Python Libraries:**
    *   `google-cloud-bigquery`: Interacting with BigQuery
    *   `pandas`: Data manipulation and analysis
    *   `numpy`: Numerical operations
    *   `matplotlib`, `seaborn`: Data visualization
    *   `scikit-learn`: Clustering (KMeans, DBSCAN), Preprocessing (StandardScaler)
    *   `mlxtend`: Association Rule Mining (Apriori)
    *   `statsmodels`: Time Series Analysis (SARIMA, decomposition)
*   **BI/Reporting:** Google Looker Studio

## Setup & Installation

1.  **GCP Account & BigQuery:** Ensure you have a GCP project with BigQuery API enabled.
2.  **Service Account Key:** Create a Service Account in GCP with necessary permissions (BigQuery Data Editor/Viewer, BigQuery Job User) and download the JSON key file. **Rename it to `keyfile.json` and place it in the root directory (add `keyfile.json` to your `.gitignore` file to avoid committing credentials).**
3.  **Python Environment:** Python 3.8+ recommended. Create a virtual environment (optional but recommended).
4.  **Install Libraries:**
    ```bash
    pip install --upgrade google-cloud-bigquery pandas matplotlib seaborn scikit-learn mlxtend statsmodels google-auth google-auth-oauthlib jupyter
    ```
    *(Alternatively, create a `requirements.txt` file and use `pip install -r requirements.txt`)*
5.  **Update Project ID:** Modify the `project_id` variable in the Python notebooks and potentially within SQL scripts if not using default project settings. Update table paths (e.g., `your-project-id.your_dataset.your_table`) in SQL and Python code to match your BigQuery setup.

## Usage

1.  **Upload Data:** Upload the `Online Retail II.xlsx` (or converted CSV) file to a Google Cloud Storage bucket accessible by your BigQuery project. Create a BigQuery table pointing to this GCS file (e.g., `online-retail-dwdm-457717.online_retail.raw_data`).
2.  **ETL:** Execute the SQL script `etl_transformation.sql` in BigQuery to create the cleaned `data` table (`online-retail-dwdm-457717.online_retail.data`).
3.  **Create DWH Schema:** Execute the SQL DDL scripts in the `schema_ddl/` folder in BigQuery (in order: dimensions first, then `fact_sales.sql`) to create and populate the Star Schema tables.
4.  **Run Analysis Notebooks:**
    *   Execute the cells in `OLAP_Cube_Analysis.ipynb`.
    *   Execute the cells in `Data_Mining_Reporting.ipynb`. Ensure the `keyfile.json` path is correct.
5.  **Visualize:** Connect Google Looker Studio to the created tables in your BigQuery dataset (`DimCustomer`, `DimDate`, `DimInvoice`, `DimProduct`, `FactSales`) and build visualizations based on the analyses.

## Dataset Information

*   **Source:** Online Retail II UCI Dataset (Chen, 2019) - https://doi.org/10.24432/C5MW4B
*   **Accessed Via:** [Mention Kaggle link if used, e.g., Kaggle]
*   **Description:** Transactional data from a UK-based online giftware retailer (Dec 2009 - Dec 2011).
*   **Key Cleaning Steps:** Handled cancelled orders, missing CustomerIDs, non-product StockCodes, invalid quantities/prices.

## Results & Insights Summary

*   **OLAP:** Demonstrated ability to analyze sales trends across time and geography, revealing strong seasonality (Nov/Dec peaks) and UK market dominance.
*   **Clustering:** Identified distinct customer segments: a large base of casual buyers, a smaller group of loyal mid-range shoppers, and very small groups of high-value and ultra-high-value customers/outliers.
*   **Association Rules:** Uncovered strong co-purchase patterns, notably between different types of Herb Markers and between pink children's garden tools.

These insights provide actionable guidance for marketing, inventory, and merchandising strategies.

---
