
-- FILTERING OUT FOR CURRENT PRODUCT ROWS (-- prd_end_dt IS NULL)
CREATE VIEW gold.dim_products AS (
SELECT
ROW_NUMBER() OVER(ORDER BY prd_id) product_key,
pi.prd_key product_number,
pi.cat_id category_id,
pc.cat product_category,
pc.subcat product_subcategory,
pi.prd_id product_id,
pi.prd_line product_line,
pi.prd_nm product_name,
pi.prd_cost product_cost,
pi.prd_start_dt product_start_date,
pi.prd_end_dt product_end_date,
pc.maintenance product_maintenance
FROM Silver.crm_prd_info pi
LEFT JOIN Silver.erp_px_cat_g1v2 pc ON pi.cat_id=pc.id where pi.prd_end_dt IS NULL 
)