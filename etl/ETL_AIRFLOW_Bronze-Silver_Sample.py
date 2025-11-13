from datetime import datetime
from airflow.decorators import dag
from airflow.operators.python import PythonOperator
from sqlalchemy import create_engine
import pandas as pd


# -----------------------------
# Database connection strings
# -----------------------------
connection_string_source = (
    "mssql+pyodbc://Mohamed:sql1234@host.docker.internal:1433/AirtravelBronze?"
    "driver=ODBC+Driver+18+for+SQL+Server&TrustServerCertificate=yes&Encrypt=yes"
)

connection_string_destination = (
    "mssql+pyodbc://Mohamed:sql1234@host.docker.internal:1433/AirtravelSilver?"
    "driver=ODBC+Driver+18+for+SQL+Server&TrustServerCertificate=yes&Encrypt=yes"
)

# -----------------------------
# Queries
# -----------------------------
query_FARES_DETAILS = "SELECT * FROM v_FARES_DETAILS"  # Adjust table/view name as needed


# -----------------------------
# ETL Functions
# -----------------------------
def extract_data(**context):
    """Extract data from source DB"""
    engine_source = create_engine(connection_string_source)
    with engine_source.connect() as conn:
        df = pd.read_sql(query_FARES_DETAILS, conn)
    print(f"✅ Extracted {len(df)} rows from source.")
    return df  # returned to XCom


def load_data(**context):
    """Load data into destination DB"""
    ti = context["ti"]
    df = ti.xcom_pull(task_ids="extract_task")
    engine_dest = create_engine(connection_string_destination)
    with engine_dest.connect() as conn:
        df.to_sql("v_FARES_DETAILS", conn, if_exists="replace", index=False)
    print(f"✅ Loaded {len(df)} rows into destination.")


# -----------------------------
# DAG definition
# -----------------------------
@dag(
    dag_id="etl_fares_bronze_to_silver",
    start_date=datetime(2025, 11, 1),
    schedule="@daily",
    catchup=False,
    tags=["ETL_Silver", "Airflow"],
)
def etl_fares_dag():
    extract_task = PythonOperator(
        task_id="extract_task",
        python_callable=extract_data,
        provide_context=True,
    )

    load_task = PythonOperator(
        task_id="load_task",
        python_callable=load_data,
        provide_context=True,
    )

    extract_task >> load_task


etl_fares_dag_instance = etl_fares_dag()
