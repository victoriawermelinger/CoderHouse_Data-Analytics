Use CoderHouse_50470

select * from [dbo].[olist_products_dataset]

--1. quantas coluna
s temos de produtos 

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


-- 1. Quais os 5 produtos/sellers que mais contribuíram para a queda/aumento da receita média mensal de 2017 para 2018?
-- 2. Qual a evolução do review_score anual médio por seller?
-- 3. Qual a evolução do faturamento mensal por categoria/seller?
-- 4. Produtos com mais fotos vendem mais que os outros?
-- 5. Qual o ticket médio por categoria?
-- 6. Qual o OTIF?
-- 7. Qual a o tempo médio de aprovação de um pedido?


-- 1. Quais os 5 sellers que mais contribuíram para a aumento da receita média mensal de 2017 para 2018?

SELECT TOP 5
	DB_AJ.seller_id,
	SUM(DB_AJ.VALOR_2017) AS TOTAL_2017,
	SUM(DB_AJ.VALOR_2018) AS TOTAL_2018,
	SUM(DB_AJ.VALOR_2018 - DB_AJ.VALOR_2017) AS DELTA
FROM
	(SELECT
		OI.seller_id,
		SUM(OP.payment_value)/12 AS VALOR_2017,
		SUM(0) AS VALOR_2018
	FROM olist_order_payments_dataset OP
	LEFT JOIN olist_orders_dataset O
		ON OP.order_id = O.order_id
	LEFT JOIN olist_order_items_dataset OI
		ON OP.order_id = OI.order_id
	WHERE YEAR(O.order_delivered_customer_date) = 2017
	GROUP BY
		OI.seller_id
	UNION ALL
	SELECT
		OI.seller_id,
		SUM(0) AS VALOR_2017,
		SUM(OP.payment_value)/10 AS VALOR_2018
	FROM olist_order_payments_dataset OP
	LEFT JOIN olist_orders_dataset O
		ON OP.order_id = O.order_id
	LEFT JOIN olist_order_items_dataset OI
		ON OP.order_id = OI.order_id
	WHERE YEAR(O.order_delivered_customer_date) = 2018
	GROUP BY
		OI.seller_id) AS DB_AJ
GROUP BY
	DB_AJ.seller_id
ORDER BY 4 ASC


-- 2. Qual o review_score médio por seller em 2018?

--DROP TABLE #TEMP_SCORE

SELECT
	I.seller_id,
	COUNT(DISTINCT I.order_id) AS QTD_ORDENS
INTO #TEMP_SCORE
FROM  olist_order_items_dataset I
GROUP BY I.seller_id

SELECT
	I.seller_id,
	ROUND(AVG(CONVERT(FLOAT, R.review_score)),1) AS AVG_SCORE
FROM olist_orders_dataset O
LEFT JOIN olist_order_items_dataset I
	ON O.order_id = I.order_id
LEFT JOIN #TEMP_SCORE T
	ON I.seller_id = T.seller_id
LEFT JOIN olist_order_reviews_dataset R
	ON O.order_id = R.order_id
WHERE
	YEAR(O.order_purchase_timestamp) = 2018 AND
	I.seller_id IS NOT NULL AND
	R.review_score IS NOT NULL AND
	T.QTD_ORDENS > 3
GROUP BY
	I.seller_id
ORDER BY 2 DESC


-- 3. Qual a evolução do faturamento mensal em 2018 da categoria com maior faturamento?

--DROP TABLE #TEMP_FAT

SELECT TOP 1
	P.product_category_name,
	SUM(PAY.payment_value) as VLR_FATURADO
INTO #TEMP_FAT
FROM olist_orders_dataset O
LEFT JOIN olist_order_items_dataset I
	ON O.order_id = I.order_id
LEFT JOIN olist_products_dataset P
	ON I.product_id = P.product_id
LEFT JOIN olist_order_payments_dataset PAY
	ON O.order_id = PAY.order_id
WHERE
	O.order_delivered_customer_date IS NOT NULL AND
	YEAR(O.order_delivered_customer_date) = 2018
GROUP BY P.product_category_name
ORDER BY 2 DESC

SELECT
	P.product_category_name AS CATEGORIA,
	MONTH(O.order_delivered_customer_date) AS MES,
	ROUND(SUM(PAY.payment_value)/1000000,2) as VLR_FATURADO_MILHOES
FROM olist_orders_dataset O
LEFT JOIN olist_order_items_dataset I
	ON O.order_id = I.order_id
LEFT JOIN olist_products_dataset P
	ON I.product_id = P.product_id
LEFT JOIN olist_order_payments_dataset PAY
	ON O.order_id = PAY.order_id
INNER JOIN #TEMP_FAT T
	ON P.product_category_name = T.product_category_name
WHERE
	O.order_delivered_customer_date IS NOT NULL AND
	YEAR(O.order_delivered_customer_date) = 2018
GROUP BY
	P.product_category_name,
	MONTH(O.order_delivered_customer_date)
ORDER BY MES ASC


-- 4. Produtos com mais fotos vendem mais que os outros? >> NÃO UTILIZAR!!!!!!!!

SELECT DISTINCT
	P.product_photos_qty AS #_FOTOS,
	ROUND(SUM(PAY.payment_value)/1000000,2) AS VALOR
FROM olist_orders_dataset O
LEFT JOIN olist_order_items_dataset I
	ON O.order_id = I.order_id
LEFT JOIN olist_products_dataset P
	ON I.product_id = P.product_id
LEFT JOIN olist_order_payments_dataset PAY
	ON O.order_id = PAY.order_id
WHERE
	P.product_photos_qty IS NOT NULL
GROUP BY
	P.product_photos_qty
ORDER BY 1


-- 5. Qual o ticket médio por categoria?

SELECT
	P.product_category_name,
	ROUND(SUM(PAY.payment_value)/COUNT(DISTINCT O.order_id)/1000, 2) AS TICKET_MEDIO_MILHARES
FROM olist_orders_dataset O
LEFT JOIN olist_order_items_dataset I
	ON O.order_id = I.order_id
LEFT JOIN olist_products_dataset P
	ON I.product_id = P.product_id
LEFT JOIN olist_order_payments_dataset PAY
	ON O.order_id = PAY.order_id
WHERE
	PAY.payment_value IS NOT NULL AND
	P.product_category_name IS NOT NULL
GROUP BY P.product_category_name


-- 6. Qual o OTIF?

SELECT
	SUM(BASE_AJ.VALOR_TTL) / 1000000 AS VALOR_TTL_MILHOES,
	SUM(BASE_AJ.VALOR_OTIF) / 1000000 AS VALOR_OTIF_MILHOES,
	ROUND( SUM(BASE_AJ.VALOR_OTIF) / SUM(BASE_AJ.VALOR_TTL) * 100 , 2 ) AS OTIF
FROM (
	SELECT
		SUM(P.payment_value) AS VALOR_TTL,
		CONVERT(FLOAT, 0) AS VALOR_OTIF
	FROM olist_orders_dataset O
	LEFT JOIN olist_order_payments_dataset P
		ON O.order_id = P.order_id
	WHERE
		O.order_estimated_delivery_date IS NOT NULL AND
		O.order_delivered_customer_date IS NOT NULL
	UNION ALL
	SELECT
		CONVERT(FLOAT, 0) AS VALOR_TTL,
		SUM(P.payment_value) AS VALOR_OTIF
	FROM olist_orders_dataset O
	LEFT JOIN olist_order_payments_dataset P
		ON O.order_id = P.order_id
	WHERE
		O.order_estimated_delivery_date IS NOT NULL AND
		O.order_delivered_customer_date IS NOT NULL AND
		O.order_delivered_customer_date <= O.order_estimated_delivery_date ) AS BASE_AJ


-- 7. Qual a o tempo médio de aprovação de um pedido?
SELECT
	AVG(O.order_approved_at - O.order_purchase_timestamp) AS TEMPO_MEDIO
FROM olist_orders_dataset O
WHERE
	O.order_purchase_timestamp IS NOT NULL AND
	O.order_approved_at IS NOT NULL
