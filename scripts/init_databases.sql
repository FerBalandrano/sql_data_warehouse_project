/*
===================================================
Creation of the Databases
===================================================
Script purpose:

This script creates the 3 main schemas we will be using for our Medallion Data Warehouse architecture: bronze 🥉, silver 🥈 and gold 🥇.
In MySQL, a schema and a database are essentially the same, so it is not necessary to create a "main" database to contain the bronze, silver and gold schemas, instead, we will only need to create 3 databases, one for each layer 🥉🥈🥇.
*/

CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;

-- I'll start creating the bronze layer, creating each table inside this layer and creating the loading scripts for each table 🚀
USE bronze;

CREATE TABLE crm_cust_info(
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_last_name VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date DATE
);

-- Upon reviewing the .csv file for the crm_cust_info table I realized that our primary key (cst_id) has null values, which were not accepted by MySQL, so in order to handle them, I add this modification to the data type to still be INT but also accept Null values.
ALTER TABLE crm_cust_info MODIFY cst_id INT NULL;


CREATE TABLE crm_prod_info(
    prd_id INT,
    prd_key	VARCHAR(50),
    prd_nm	VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);

CREATE TABLE crm_sales_details(
    sls_ord_num VARCHAR(59),
    sls_prd_key VARCHAR(59),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT NULL
);

ALTER TABLE crm_sales_details MODIFY sls_price DECIMAL(10,2) NULL;

CREATE TABLE erp_cust_az12(
    cid	VARCHAR(50),
    bdate DATE,
    gen VARCHAR(50)
);

CREATE TABLE erp_loc_a101(
    cid VARCHAR(50),
    cntry VARCHAR(50)
);

CREATE TABLE erp_px_cat_g1v2(
    id VARCHAR(50),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50)
);
ALTER TABLE crm_cust_info MODIFY cst_id INT NULL;

