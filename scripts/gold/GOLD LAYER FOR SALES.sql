-- Here instead of showing original complex product and customer_keys we are showing surrogate keys from dimension tables
CREATE VIEW Gold.facts_sales AS (

select 
cd.sls_ord_num,
gp.product_key,
gc.customer_key,
cd.sls_cust_id,
cd.sls_order_dt,
cd.sls_ship_dt,
cd.sls_due_dt,
cd.sls_sales,
cd.sls_quantity,
cd.sls_price
from Silver.crm_sales_details cd
LEFT JOIN Gold.dim_customers gc ON cd.sls_cust_id = gc.customer_id
LEFT JOIN Gold.dim_products gp ON cd.sls_prd_key = gp.product_number

)

