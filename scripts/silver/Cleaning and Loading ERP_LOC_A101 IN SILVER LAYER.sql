TRUNCATE TABLE Silver.erp_loc_A101
PRINT('>> Silver.erp_loc_A101 TRUNCATED')

INSERT INTO Silver.erp_loc_A101(cid,cntry)

SELECT 
REPLACE(cid,'-','') cid,

CASE WHEN UPPER(TRIM(cntry))='DE' THEN 'Germany'
	 WHEN UPPER(TRIM(cntry)) IN ('US','USA') THEN 'United States'
	 WHEN UPPER(TRIM(cntry)) IS NULL OR UPPER(TRIM(cntry))='' THEN 'n/a'
	 ELSE TRIM(cntry)

END cntry
FROM Bronze.erp_loc_A101



