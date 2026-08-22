--- CREATING CUSTOMERS(crm_cust_info,erp_cust_az12.erp_locA101) GOLD LAYER

CREATE VIEW gold.dim_customers AS(
SELECT 
ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS customer_key,
ci.cst_id AS customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS customer_firstname,
ci.cst_lastname AS customer_lastname,
CASE WHEN TRIM(ci.cst_gndr)!=TRIM(ca.gen) THEN ci.cst_gndr
		  ELSE COALESCE(ca.gen,'n/a')
		  END gender,
cl.cntry AS customer_country,
ca.bdate AS birth_date,
cst_create_date FROM Silver.crm_cust_info ci
LEFT JOIN  Silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
LEFT JOIN Silver.erp_loc_A101 cl ON ci.cst_key = cl.cid
)


