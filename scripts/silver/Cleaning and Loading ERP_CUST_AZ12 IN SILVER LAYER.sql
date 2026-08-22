TRUNCATE TABLE Silver.erp_cust_az12
PRINT('>> Silver.erp_cust_az12 TRUNCATED')


INSERT INTO Silver.erp_cust_az12
(
	   cid
      ,bdate
      ,gen

)

select 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
	 ELSE cid

END cid,

CASE WHEN bdate>GETDATE() THEN NULL
	 ELSE bdate
END bdate,

CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
	 ELSE 'n/a'

END gen 

from Bronze.erp_cust_az12 






 
