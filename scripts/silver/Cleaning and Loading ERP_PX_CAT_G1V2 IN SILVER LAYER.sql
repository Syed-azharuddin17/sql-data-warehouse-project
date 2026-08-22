
---IMPORTANT: SIMILAR TO HOW WE CREATED A PROCEDURE FOR BRONZE, DO THE SAME FOR SILVER AS WELL
-- I.E TAKE ALL THE CLEANING FILES IN SILVER AND PUT THEM TOGETHER IN ONE FILE TO CREATE PROCEDURE

-- inserting whole bronze.erp_px_cat_g1v2 because data quality is good

TRUNCATE TABLE Silver.erp_px_cat_g1v2
PRINT('>>Silver.erp_px_cat_g1v2 TABLE TRUNCATED ')

INSERT INTO Silver.erp_px_cat_g1v2(id,cat,subcat,maintenance)
SELECT  id,cat,subcat,maintenance FROM Bronze.erp_px_cat_g1v2

