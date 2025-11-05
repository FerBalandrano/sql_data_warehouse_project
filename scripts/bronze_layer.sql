/*
===================================================
  LOADING SCRIPT FOR THE BRONZE LAYER (RAW DATA)
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
