-- Databricks notebook source
CREATE OR REFRESH STREAMING TABLE ${prefix}_src_tpch.customers.raw_customer
COMMENT "RAW Customer Data" AS
SELECT
  *
FROM
  cloud_files(
    "/Volumes/dev_bu_xx_yy_landing/tpch/data/customer",
    "csv",
    map(
      "schema",
      " 
          c_custkey     bigint,
          c_name        string,
          c_address     string,
          c_nationkey   bigint,
          c_phone       string,
          c_acctbal     decimal(18,2),
          c_mktsegment  string,
          c_comment     string
          ",
      "delimiter",
      "|"
    )
  )

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_src_tpch.orders.raw_orders COMMENT "RAW Orders Data"
AS
SELECT
  *
FROM
  cloud_files(
    "/Volumes/dev_bu_xx_yy_landing/tpch/data/orders",
    "csv",
    map(
      "schema",
      " 
          o_orderkey       bigint,
          o_custkey        bigint,
          o_orderstatus    string,
          o_totalprice     decimal(18,2),
          o_orderdate      date,
          o_orderpriority  string,
          o_clerk          string,
          o_shippriority   int,
          o_comment        string
          ",
      "delimiter",
      "|"
    )
  )

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_src_tpch.orders.raw_lineitem
COMMENT "RAW LineItem Data" AS
SELECT
  *
FROM
  cloud_files(
    "/Volumes/dev_bu_xx_yy_landing/tpch/data/lineitem",
    "csv",
    map(
      "schema",
      " 
          l_orderkey      bigint,
          l_partkey       bigint,
          l_suppkey       bigint,
          l_linenumber    int,
          l_quantity      decimal(18,2),
          l_extendedprice decimal(18,2),
          l_discount      decimal(18,2),
          l_tax           decimal(18,2),
          l_returnflag    string,
          l_linestatus    string,
          l_shipdate      date,
          l_commitdate    date,
          l_receiptdate   date,
          l_shipinstructs string,
          l_shipmode      string,
          l_comment       string
          ",
      "delimiter",
      "|"
    )
  )

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_src_tpch.products.raw_part COMMENT "RAW Parts Data"
AS
SELECT
  *
FROM
  cloud_files(
    "/Volumes/dev_bu_xx_yy_landing/tpch/data/part",
    "csv",
    map(
      "schema",
      " 
          p_partkey      bigint,
          p_name         string,
          p_mfgr         string,
          p_brand        string,
          p_type         string,
          p_size         int,
          p_container    string,
          p_retailprice  decimal(18,2),
          p_comment      string
          ",
      "delimiter",
      "|"
    )
  )

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_src_tpch.suppliers.raw_supplier
COMMENT "RAW Supplier Data" AS
SELECT
  *
FROM
  cloud_files(
    "/Volumes/dev_bu_xx_yy_landing/tpch/data/supplier",
    "csv",
    map(
      "schema",
      " 
          s_suppkey      bigint,
          s_name         string,
          s_address      string,
          s_nationkey    bigint,
          s_phone        string,
          s_acctbal      decimal(18,2),
          s_comment      string
          ",
      "delimiter",
      "|"
    )
  )

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_src_tpch.geography.raw_region
COMMENT "RAW Region Data" AS
SELECT
  *
FROM
  cloud_files(
    "/Volumes/dev_bu_xx_yy_landing/tpch/data/region",
    "csv",
    map(
      "schema",
      " 
          r_regionkey     bigint,
          r_name          string,
          r_comment       string
          ",
      "delimiter",
      "|"
    )
  )

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_src_tpch.geography.raw_nation
COMMENT "RAW Nation Data" AS
SELECT
  *
FROM
  cloud_files(
    "/Volumes/dev_bu_xx_yy_landing/tpch/data/nation",
    "csv",
    map(
      "schema",
      " 
          n_nationkey     bigint,
          n_name          string,
          n_regionkey     bigint,
          n_comment       string
          ",
      "delimiter",
      "|"
    )
  )