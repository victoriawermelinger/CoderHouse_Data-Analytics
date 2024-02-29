Use CoderHouse_50470

select * from [dbo].[olist_products_dataset]

--1. quantas colunas temos de produtos 

select count(distinct(product_category_name)) FROM [dbo].[olist_products_dataset]


--2. coluna com a quantidade de produto

SELECT COUNT(product_category_name) AS distinct_category_count
, product_category_name
FROM olist_products_dataset 
WHERE product_category_name IS NOT NULL
GROUP BY product_category_name

--3. quantas cidades entregas por estado 

select* from[dbo].[olist_geolocation_dataset]
select* from[dbo].[olist_sellers_dataset]

SELECT COUNT(DISTINCT geo.geolocation_city) AS total_cidades
,    seller.seller_state
FROM [dbo].[olist_geolocation_dataset] AS geo
INNER JOIN [dbo].[olist_sellers_dataset] AS seller
ON geo.geolocation_city = seller.seller_city
WHERE geo.geolocation_city IS NOT NULL
GROUP BY seller.seller_state
ORDER BY total_cidades DESC

-- 4- comentarios de clientes 
select * from[dbo].[olist_order_reviews_dataset]

select count (review_comment_message) as comentarios
, review_comment_message
from olist_order_reviews_dataset
where review_comment_message is not null
group by review_comment_message

-- 5 quantidade de vendas por estado

SELECT COUNT(geo.geolocation_city) AS total_cidades
,    seller.seller_state
FROM [dbo].[olist_geolocation_dataset] AS geo
INNER JOIN [dbo].[olist_sellers_dataset] AS seller
ON geo.geolocation_city = seller.seller_city
WHERE geo.geolocation_city IS NOT NULL
GROUP BY seller.seller_state
ORDER BY total_cidades DESC



select * from [dbo].[olist_geolocation_dataset]
select * from[dbo].[olist_customers_dataset]
select * from[dbo].[olist_order_items_dataset]
select * from[dbo].[olist_order_payments_dataset]
select * from[dbo].[olist_order_reviews_dataset]
select * from[dbo].[olist_orders_dataset]
select * from[dbo].[olist_products_dataset]
select * from[dbo].[olist_sellers_dataset]
select * from[dbo].[product_category_name_translation]

select * from [dbo].[olist_geolocation_dataset] 