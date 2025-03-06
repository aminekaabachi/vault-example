# Databricks notebook source
dbutils.widgets.text("prefix", "", "Prefix")
prefix = dbutils.widgets.get("prefix")

catalogs = [f"{prefix}_landing", f"{prefix}_src_tpch", f"{prefix}_dwh_tpch"]
for catalog in catalogs:
  spark.sql(f"DROP CATALOG IF EXISTS {catalog} CASCADE")
  spark.sql(f"CREATE CATALOG {catalog}")
  # spark.sql(f"DROP SCHEMA IF EXISTS {catalog}.default")

# COMMAND ----------

spark.sql(f"CREATE SCHEMA IF NOT EXISTS {prefix}_landing.tpch")
spark.sql(f"CREATE VOLUME IF NOT EXISTS {prefix}_landing.tpch.data")

# COMMAND ----------

spark.sql(f"CREATE SCHEMA IF NOT EXISTS {prefix}_src_tpch.customers")
spark.sql(f"CREATE SCHEMA IF NOT EXISTS {prefix}_src_tpch.orders")
spark.sql(f"CREATE SCHEMA IF NOT EXISTS {prefix}_src_tpch.products")
spark.sql(f"CREATE SCHEMA IF NOT EXISTS {prefix}_src_tpch.suppliers")
spark.sql(f"CREATE SCHEMA IF NOT EXISTS {prefix}_src_tpch.geography")

# COMMAND ----------

spark.sql(f"CREATE SCHEMA IF NOT EXISTS {prefix}_dwh_tpch.staging")
spark.sql(f"CREATE SCHEMA IF NOT EXISTS {prefix}_dwh_tpch.core")
spark.sql(f"CREATE SCHEMA IF NOT EXISTS {prefix}_dwh_tpch.customer_orders")

# COMMAND ----------

dbutils.fs.cp('/databricks-datasets/tpch/data-001', f'/Volumes/{prefix}_landing/tpch/data', True)

# COMMAND ----------

display(dbutils.fs.ls(f'/Volumes/{prefix}_landing/tpch/data'))

# COMMAND ----------

