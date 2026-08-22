
-- QUERIES TO CHECK DATA CORRECTNESS

----------------------------- FOR crm_cust_info------------------------------------------------------- 
-- MUST RETURN NO ROWS
select cst_id, COUNT(*) FROM Silver.crm_cust_info GROUP BY cst_id HAVING COUNT(*)>1 OR cst_id IS NULL

-- MUST RETURN NOW ROWS
select cst_firstname from Silver.crm_cust_info where cst_firstname ! = TRIM(cst_firstname)

-- MUST RETURN VALUES Male,Female,n/a
select DISTINCT cst_gndr from Silver.crm_cust_info


------------------------------FOR prd_info--------------------------------------------------------

select  * from Bronze.crm_prd_info

select prd_id , COUNT(*) FROM Silver.crm_prd_info GROUP BY prd_id HAVING COUNT(*)>1 OR prd_id IS NULL

select * from Silver.crm_prd_info where prd_start_dt>prd_end_dt -- (start date should be less than end date otherwise error)

select prd_id,prd_key,prd_nm,prd_cost,prd_line,prd_start_dt,
LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 prd_end_dt  from Silver.crm_prd_info 



---------------------------for sales details -----------------------------------------------------

select NULLIF(sls_order_dt,0) sls_order_dt from Bronze.crm_sales_details where sls_order_dt<=0 OR LEN(sls_order_dt)!=8

--CHECK FOR INVALID DATE ORDERS

SELECT * FROM Bronze.crm_sales_details WHERE sls_order_dt>sls_ship_dt OR sls_order_dt>sls_due_dt 

-- checking data quality between sales, quantity and price
-- >> Sales = Quantity*Price
-- >> Values must not be negative,zero or NULL

-- >> Rules for our example : 
-- 1. if sales is zero,negative or null , derive it from quantity and price 
-- 2. if price is zero,negative or null , derive it from sales and price 
-- 3. if price is negative, convert it to positive

select DISTINCT 
 CASE WHEN sls_sales IS NULL OR sls_sales<=0 OR sls_sales != sls_quantity * ABS(sls_price) THEN sls_quantity * ABS(sls_price)
				ELSE sls_sales
				END AS sls_sales,

sls_quantity,

CASE WHEN sls_price IS NULL OR sls_price<=0 THEN  sls_sales/NULLIF(sls_quantity,0)
				ELSE sls_price
				END sls_price

from Bronze.crm_sales_details where sls_sales!=sls_quantity*sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales<=0 OR sls_quantity<=0 OR sls_price <=0 ORDER BY sls_sales

-------------------- FOR ERP CUST AZ12-------------------------------------------

--- CHECK GENDERS MAPPING 
select DISTINCT gen,

CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
	 ELSE 'n/a'

END gender

from Bronze.erp_cust_az12