-- Databricks notebook source
CREATE OR REFRESH MATERIALIZED VIEW ${prefix}_dwh_tpch.core.sat_orders_bv
(
  sha1_hub_orderkey         STRING     NOT NULL ,  
  o_orderstatus             STRING ,
  o_totalprice              decimal(18,2) ,
  o_orderdate               DATE,
  o_orderpriority           STRING,
  o_clerk                   STRING,
  o_shippriority            INT,
  order_priority_tier       STRING,
  source                    STRING    NOT NULL
  
)
COMMENT " SAT Order Business Vault TABLE "
AS SELECT
          sha1_hub_orderkey     AS sha1_hub_orderkey,
          o_orderstatus         AS o_orderstatus,
		  o_totalprice          AS o_totalprice,
          o_orderdate           AS o_orderdate,
          o_orderpriority       AS o_orderpriority,
		  o_clerk               AS o_clerk,
          o_shippriority        AS o_shippriority,
		  CASE WHEN o_orderpriority IN ('2-HIGH', '1-URGENT') AND o_totalprice >= 225000 THEN 'Tier-1'
               WHEN o_orderpriority IN ('3-MEDIUM', '2-HIGH', '1-URGENT') AND o_totalprice BETWEEN 120000 AND 225000 THEN 'Tier-2'   
			   ELSE 'Tier-3'
		  END order_priority_tier,
          source
   FROM
       ${prefix}_dwh_tpch.staging.sat_orders