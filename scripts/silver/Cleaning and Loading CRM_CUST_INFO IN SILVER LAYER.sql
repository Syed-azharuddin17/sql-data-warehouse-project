
-- DATA CLEANING AND LOADING OF crm_cust_info

TRUNCATE TABLE Silver.crm_cust_info
PRINT('>>Silver.crm_cust_info TABLE TRUNCATED ')

INSERT INTO Silver.crm_cust_info (
       [cst_id]
      ,[cst_key]
      ,[cst_firstname]
      ,[cst_lastname]
      ,[cst_marital_status]
      ,[cst_gndr]
      ,[cst_create_date])

select cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
	 WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
	 ELSE 'n/a'
END cst_marital_status,
CASE WHEN UPPER(TRIM(cst_gndr))='M' THEN 'Male'
	 WHEN UPPER(TRIM(cst_gndr))='F' THEN 'Female'
	 ELSE 'n/a'
END cst_gndr,
cst_create_date from (
select 
*,
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC ) flag
from Bronze.crm_cust_info WHERE cst_id IS NOT NULL)t where flag=1

select * from Silver.crm_cust_info