-- Databricks notebook source
CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.core.hub_customer
COMMENT " HUb CUSTOMER TABLE"
AS SELECT
      *
   FROM
      ${prefix}_dwh_tpch.staging.hub_customer;

CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.core.sat_customer
COMMENT " SAT CUSTOMER TABLE"
AS SELECT
      *
   FROM
      ${prefix}_dwh_tpch.staging.sat_customer;

CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.core.hub_orders
COMMENT " HUb ORDERS TABLE"
AS SELECT
      *
   FROM
      ${prefix}_dwh_tpch.staging.hub_orders;

-- CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.core.sat_orders
-- COMMENT " SAT ORDERS TABLE"
-- AS SELECT
--       *
--    FROM
--       ${prefix}_dwh_tpch.staging.sat_orders;

CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.core.lnk_customer_orders
COMMENT " LNK CUSTOMER ORDERS TABLE "
AS SELECT
      *
   FROM
      ${prefix}_dwh_tpch.staging.lnk_customer_orders;

CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.core.hub_lineitem
COMMENT " HUb LINEITEM TABLE"
AS SELECT
      *
   FROM
      ${prefix}_dwh_tpch.staging.hub_lineitem;
      
CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.core.sat_lineitem
COMMENT " SAT LINEITEM TABLE"
AS SELECT
      *
   FROM
      ${prefix}_dwh_tpch.staging.sat_lineitem;

CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.core.ref_region
COMMENT " ref region TABLE"
AS SELECT
      *
   FROM
      ${prefix}_dwh_tpch.staging.ref_region;

CREATE OR REPLACE VIEW ${prefix}_dwh_tpch.core.ref_nation
COMMENT " ref nation TABLE"
AS SELECT
      *
   FROM
      ${prefix}_dwh_tpch.staging.ref_nation;   