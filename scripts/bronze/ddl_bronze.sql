/*
===============================================================================
DDL Script: Create Bronze Tables (MySQL)
===============================================================================
Script Purpose:
    This script creates the Bronze (raw) layer tables in the
    'data_warehouse' database.

    Since MySQL does not support schemas separately, the Bronze layer
    is implemented using table naming conventions (bronze_*).

    Existing tables are dropped before creation to allow
    repeatable and clean DDL execution.

    Bronze tables store raw, unvalidated data directly from source systems.
===============================================================================
*/

-- Drop the database if it already exists
DROP DATABASE IF EXISTS data_warehouse;

-- Recreate the database
CREATE DATABASE data_warehouse;

-- Use the database
USE data_warehouse;


DROP TABLE IF EXISTS bronze_crm_prd_info;

CREATE TABLE bronze_crm_prd_info (
    prd_id        INT,
    prd_key       VARCHAR(50),
    prd_nm        VARCHAR(50),
    prd_cost      DECIMAL(10,2),
    prd_line      VARCHAR(50),
    prd_start_dt  DATETIME,
    prd_end_dt    DATETIME
);


DROP TABLE IF EXISTS bronze_crm_sales_details;

CREATE TABLE bronze_crm_sales_details (
    sls_ord_num   VARCHAR(50),
    sls_prd_key   VARCHAR(50),
    sls_cust_id   INT,
    sls_order_dt  INT,   
    sls_ship_dt   INT,   
    sls_due_dt    INT,   
    sls_sales     DECIMAL(10,2),
    sls_quantity  INT,
    sls_price     DECIMAL(10,2)
);


DROP TABLE IF EXISTS bronze_erp_loc_a101;

CREATE TABLE bronze_erp_loc_a101 (
    cid    VARCHAR(50),
    cntry  VARCHAR(50)
);


DROP TABLE IF EXISTS bronze_erp_cust_az12;

CREATE TABLE bronze_erp_cust_az12 (
    cid    VARCHAR(50),
    bdate  DATE,
    gen    VARCHAR(50)
);

DROP TABLE IF EXISTS bronze_erp_px_cat_g1v2;

CREATE TABLE bronze_erp_px_cat_g1v2 (
    id           VARCHAR(50),
    cat          VARCHAR(50),
    subcat       VARCHAR(50),
    maintenance  VARCHAR(50)
);
