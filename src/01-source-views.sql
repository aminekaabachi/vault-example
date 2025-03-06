-- Databricks notebook source
CREATE OR REPLACE VIEW ${prefix}_src_tpch.orders.raw_lineitem_vw
COMMENT "RAW LineItem View"
AS  SELECT
        sha1(concat(UPPER(TRIM(l_orderkey)),UPPER(TRIM(l_linenumber)))) as sha1_hub_lineitem,
        sha1(UPPER(TRIM(l_orderkey))) as sha1_hub_orderkey,
        current_timestamp as load_ts,
        "LineItem Source" as source,
        * 
    FROM ${prefix}_src_tpch.orders.raw_lineitem

-- COMMAND ----------

CREATE OR REPLACE VIEW ${prefix}_src_tpch.orders.raw_orders_vw
COMMENT "RAW Order Data View"
AS  SELECT
        sha1(UPPER(TRIM(o_orderkey))) as sha1_hub_orderkey,
        sha1(concat(UPPER(TRIM(o_orderkey)),UPPER(TRIM(o_custkey)))) as sha1_lnk_customer_order_key,
        sha1(UPPER(TRIM(o_custkey)))  as sha1_hub_custkey,
        sha1(concat(UPPER(TRIM(o_orderstatus)),UPPER(TRIM(o_totalprice)),UPPER(TRIM(o_orderpriority)),UPPER(TRIM(o_shippriority)))) as hash_diff,
        current_timestamp as load_ts,
        "Order Source" as source,
        * 
    FROM ${prefix}_src_tpch.orders.raw_orders

-- COMMAND ----------

CREATE OR REPLACE VIEW ${prefix}_src_tpch.customers.raw_customer_vw
COMMENT "RAW Customer Data View"
AS  SELECT
        sha1(UPPER(TRIM(c_custkey))) as sha1_hub_custkey,
        sha1(concat(UPPER(TRIM(c_name)),UPPER(TRIM(c_address)),UPPER(TRIM(c_phone)),UPPER(TRIM(c_mktsegment)))) as hash_diff,
        current_timestamp as load_ts,
        "Customer Source" as source,
        c_custkey,
        c_name,
        c_address,
        c_nationkey,
        c_phone,
        c_acctbal,
        c_mktsegment,
        c_comment
    FROM ${prefix}_src_tpch.customers.raw_customer

-- COMMAND ----------

