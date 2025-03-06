-- Databricks notebook source
CREATE OR REFRESH STREAMING TABLE ${prefix}_dwh_tpch.staging.hub_customer(
  sha1_hub_custkey        STRING     NOT NULL,
  c_custkey               BIGINT     NOT NULL,
  load_ts                 TIMESTAMP,
  source                  STRING
  CONSTRAINT valid_sha1_hub_custkey EXPECT (sha1_hub_custkey IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_custkey EXPECT (c_custkey IS NOT NULL) ON VIOLATION DROP ROW
)
COMMENT " HUb CUSTOMER TABLE"
AS SELECT
      sha1_hub_custkey,
      c_custkey,
      load_ts,
      source
   FROM
      STREAM(${prefix}_src_tpch.customers.raw_customer_vw);

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_dwh_tpch.staging.sat_customer(
  sha1_hub_custkey        STRING    NOT NULL,
  c_name                  STRING,
  c_address               STRING,
  c_nationkey             BIGINT,
  c_phone                 STRING,
  c_acctbal               DECIMAL(18,2),
  c_mktsegment            STRING,
  hash_diff               STRING    NOT NULL,
  load_ts                 TIMESTAMP,
  source                  STRING    NOT NULL
  CONSTRAINT valid_sha1_hub_custkey EXPECT (sha1_hub_custkey IS NOT NULL) ON VIOLATION DROP ROW
)
COMMENT " SAT CUSTOMER TABLE"
AS SELECT
      sha1_hub_custkey,
      c_name,
      c_address,
      c_nationkey,
      c_phone,
      c_acctbal,
      c_mktsegment,
      hash_diff,
      load_ts,
      source
   FROM
      STREAM(${prefix}_src_tpch.customers.raw_customer_vw)

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_dwh_tpch.staging.hub_orders(
  sha1_hub_orderkey       STRING     NOT NULL,
  o_orderkey              BIGINT     NOT NULL,
  load_ts                 TIMESTAMP,
  source                  STRING
)
COMMENT " HUb CUSTOMER TABLE"
AS SELECT
      sha1_hub_orderkey ,
      o_orderkey,
      load_ts,
      source
   FROM
      STREAM(${prefix}_src_tpch.orders.raw_orders_vw)


-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_dwh_tpch.staging.sat_orders(
  sha1_hub_orderkey         STRING    NOT NULL,
  o_orderstatus             STRING,
  o_totalprice              decimal(18,2),
  o_orderdate               DATE,
  o_orderpriority           STRING,
  o_clerk                   STRING,
  o_shippriority            INT,
  load_ts                   TIMESTAMP,
  source                    STRING    NOT NULL
)
COMMENT " SAT CUSTOMER TABLE"

AS SELECT
      sha1_hub_orderkey,
      o_orderstatus,
      o_totalprice,
      o_orderdate,
      o_orderpriority,
      o_clerk,
      o_shippriority,
      load_ts,
      source
   FROM
      STREAM(${prefix}_src_tpch.orders.raw_orders_vw)

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_dwh_tpch.staging.lnk_customer_orders
(
  sha1_lnk_customer_order_key     STRING     NOT NULL ,  
  sha1_hub_orderkey               STRING ,
  sha1_hub_custkey                STRING ,
  load_ts                         TIMESTAMP  NOT NULL,
  source                          STRING     NOT NULL 
)
COMMENT " LNK CUSTOMER ORDERS TABLE "
AS SELECT
      sha1_lnk_customer_order_key,
      sha1_hub_orderkey,
      sha1_hub_custkey,
      load_ts,
      source
   FROM
       STREAM(${prefix}_src_tpch.orders.raw_orders_vw)

-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_dwh_tpch.staging.hub_lineitem(
  sha1_hub_lineitem        STRING     NOT NULL,
  sha1_hub_orderkey        STRING     NOT NULL,
  l_linenumber             int,
  load_ts                  TIMESTAMP,
  source                   STRING
)
COMMENT " HUb LINEITEM TABLE"
AS SELECT
      sha1_hub_lineitem,
      sha1_hub_orderkey,
      l_linenumber,
      load_ts,
      source
   FROM
      STREAM(${prefix}_src_tpch.orders.raw_lineitem_vw)


-- COMMAND ----------

CREATE OR REFRESH STREAMING TABLE ${prefix}_dwh_tpch.staging.sat_lineitem(
          sha1_hub_lineitem        STRING     NOT NULL,
          l_quantity               decimal(18,2),
          l_extendedprice          decimal(18,2),
          l_discount               decimal(18,2),
          l_tax                    decimal(18,2),
          l_returnflag             string,
          l_linestatus             string,
          l_shipdate               date,
          l_commitdate             date,
          l_receiptdate            date,
          l_shipinstructs          string,
          l_shipmode               string,
          load_ts                  TIMESTAMP,
          source                   STRING
)
COMMENT " SAT LINEITEM TABLE"
AS SELECT
          sha1_hub_lineitem,
          l_quantity,
          l_extendedprice,
          l_discount,
          l_tax,
          l_returnflag,
          l_linestatus,
          l_shipdate,
          l_commitdate,
          l_receiptdate,
          l_shipinstructs,
          l_shipmode,
          load_ts,
          source
   FROM
      STREAM(${prefix}_src_tpch.orders.raw_lineitem_vw)

-- COMMAND ----------

CREATE OR REFRESH MATERIALIZED VIEW ${prefix}_dwh_tpch.staging.ref_region(
  r_regionkey        bigint     NOT NULL,
  r_name             STRING ,
  load_ts            TIMESTAMP,
  source             STRING
)
COMMENT " Ref Region Table"
AS SELECT
        r_regionkey,
        r_name,
        current_timestamp AS load_ts,
        "Region Source"   AS source
   FROM
        ${prefix}_src_tpch.geography.raw_region


-- COMMAND ----------

CREATE OR REFRESH MATERIALIZED VIEW ${prefix}_dwh_tpch.staging.ref_nation(
  n_nationkey        bigint     NOT NULL,
  n_name             STRING ,
  n_regionkey        bigint,
  load_ts            TIMESTAMP,
  source             STRING
)
COMMENT " Ref Nation Table"
AS SELECT
        n_nationkey,
        n_name,
        n_regionkey,
        current_timestamp AS load_ts,
        "Nation Source"   AS source
   FROM
        ${prefix}_src_tpch.geography.raw_nation