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

/*
===================================================
  LOADING SCRIPTS
===================================================
*/

-- Considering that the .csv files may be reloaded with new or updated info, I set a TRUNCATE statement before each loading script to avoid duplicate rows in that scenario. 
TRUNCATE crm_cust_info;
LOAD DATA INFILE '/tmp/mysql-files/cust_info.csv'
INTO TABLE crm_cust_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    @cst_id, 
    cst_key, 
    @firstname, 
    @lastname, 
    @marital_status, 
    cst_gndr, 
    @create_date
)
SET 
    cst_id = NULLIF(TRIM(@cst_id), ''),
    cst_firstname = TRIM(@firstname),
    cst_last_name = TRIM(@lastname),
    cst_marital_status = TRIM(@marital_status),
	cst_create_date = NULLIF(
		TRIM(
			REPLACE(REPLACE(@create_date, '\t', ''), '\r', '')
		), 
        ''
	);
    
TRUNCATE crm_prod_info;
LOAD DATA INFILE '/tmp/mysql-files/prd_info.csv'
INTO TABLE crm_prod_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	prd_id,
    @prd_key,
    prd_nm,
    @prd_cost,
    @prd_line,
    prd_start_dt,
    @prd_end_dt
)
SET
	prd_key = NULLIF(TRIM(@prd_key),''),
	prd_cost = NULLIF(TRIM(@prd_cost),''),
    prd_line = NULLIF(TRIM(@prd_line),''),
    prd_end_dt = NULLIF(
		TRIM(
			REPLACE(REPLACE(@prd_end_dt, '\t', ''), '\r', '')
		), 
        ''
	);
    
TRUNCATE crm_sales_details;
LOAD DATA INFILE '/tmp/mysql-files/sales_details.csv'
INTO TABLE crm_sales_details
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	@sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    @sls_sales,
    @sls_quantity,
    @sls_price
)
SET
	sls_ord_num = NULLIF(TRIM(@sls_ord_num),''),
    sls_sales = NULLIF(TRIM(@sls_sales),''),
    sls_quantity = NULLIF(TRIM(@sls_quantity),''),
    sls_price = NULLIF(
		TRIM(
            REPLACE(REPLACE(@sls_price, '\t', ''), '\r', '') 
        ), 
        ''
);

TRUNCATE erp_cust_az12;
LOAD DATA INFILE '/tmp/mysql-files/CUST_AZ12.csv'
INTO TABLE erp_cust_az12
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	cid,
    bdate,
    @gen
)
SET
	gen = IFNULL(TRIM(@gen),'')
;

TRUNCATE erp_loc_a101;
LOAD DATA INFILE '/tmp/mysql-files/LOC_A101.csv'
INTO TABLE erp_loc_a101
FIELDS TERMINATED BY ','
LINES TERMINATED BY'\n'
IGNORE 1 LINES
(
	cid,
    @cntry
)
SET
	cntry = IFNULL(TRIM(@cntry),'')
;

TRUNCATE erp_px_cat_g1v2;
LOAD DATA INFILE '/tmp/mysql-files/PX_CAT_G1V2.csv'
INTO TABLE erp_px_cat_g1v2
FIELDS TERMINATED BY ','
LINES TERMINATED BY'\n'
IGNORE 1 LINES
;
