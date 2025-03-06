-- Databricks notebook source
CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.customer_orders.dim_customer AS
SELECT
  sat.sha1_hub_custkey AS dim_customer_key,
  sat.source AS source,
  sat.c_name AS c_name,
  sat.c_address AS c_address,
  sat.c_phone AS c_phone,
  sat.c_acctbal AS c_acctbal,
  sat.c_mktsegment AS c_mktsegment,
  sat.c_nationkey AS c_nationkey,
  sat.load_ts AS c_effective_ts,
  -- derived
  nation.n_name AS nation_name,
  region.r_name AS region_name
FROM
  ${prefix}_dwh_tpch.core.hub_customer hub
    INNER JOIN ${prefix}_dwh_tpch.core.sat_customer sat
      ON hub.sha1_hub_custkey = sat.sha1_hub_custkey
    LEFT OUTER JOIN ${prefix}_dwh_tpch.core.ref_nation nation
      ON (sat.c_nationkey = nation.n_nationkey)
    LEFT OUTER JOIN ${prefix}_dwh_tpch.core.ref_region region
      ON (nation.n_regionkey = region.r_regionkey)

-- COMMAND ----------

CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.customer_orders.dim_orders AS
SELECT
  hub.sha1_hub_orderkey AS dim_order_key,
  sat.*
FROM
  ${prefix}_dwh_tpch.core.hub_orders hub INNER JOIN ${prefix}_dwh_tpch.core.sat_orders_bv sat
WHERE
  hub.sha1_hub_orderkey = sat.sha1_hub_orderkey

-- COMMAND ----------

CREATE OR REPLACE TABLE ${prefix}_dwh_tpch.customer_orders.fact_customer_orders AS
SELECT
  dim_customer.dim_customer_key,
  dim_orders.dim_order_key,
  nation.n_nationkey AS dim_nation_key,
  region.r_regionkey AS dim_region_key,
  dim_orders.o_totalprice AS total_price,
  dim_orders.o_orderdate AS order_date
FROM
  ${prefix}_dwh_tpch.core.lnk_customer_orders lnk
    INNER JOIN ${prefix}_dwh_tpch.customer_orders.dim_orders dim_orders
      ON lnk.sha1_hub_orderkey = dim_orders.dim_order_key
    INNER JOIN ${prefix}_dwh_tpch.customer_orders.dim_customer dim_customer
      ON lnk.sha1_hub_custkey = dim_customer.dim_customer_key
    LEFT OUTER JOIN ${prefix}_dwh_tpch.core.ref_nation nation
      ON dim_customer.c_nationkey = nation.n_nationkey
    LEFT OUTER JOIN ${prefix}_dwh_tpch.core.ref_region region
      ON nation.n_regionkey = region.r_regionkey