

-- product yang ditawarkan di thelook ecommerce itu apa aja dan berapa harganya ?

SELECT 
  name, category , brand , retail_price
FROM bigquery-public-data.thelook_ecommerce.products
LIMIT 20


-- product apa saja yang ada MP yang berkategori premium ( retail price > 100 )?


SELECT
  name, category , brand , retail_price

FROM bigquery-public-data.thelook_ecommerce.products

WHERE retail_price > 100
ORDER BY retail_price DESC


-- berapa banyak item pada tiap kategory yang di thelook ecommerce ?


SELECT 
  category,
  COUNT(*) AS total_items
FROM bigquery-public-data.thelook_ecommerce.products
GROUP BY category
ORDER BY total_items DESC


-- select *
-- from bigquery-public-data.thelook_ecommerce.orders
-- limit 10

-- dari order yang ada detail customernya siapa dan dari mana saja?


SELECT 
  o.order_id,
  o.status,
  o.created_at,
  u.first_name,
  u.last_name
FROM bigquery-public-data.thelook_ecommerce.orders as o
LEFT JOIN bigquery-public-data.thelook_ecommerce.users as u
  ON o.user_id = u.id


-- bagaimana penjualan per kategori dari product yang tersedia di thelook ecommerce ?


SELECT
  p.category,
  SUM(oi.sale_price) AS total_sales,
  COUNT(oi.id) AS total_items_sold
FROM `bigquery-public-data.thelook_ecommerce.orders` AS o
INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  ON o.order_id = oi.order_id
INNER JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
GROUP BY p.category
ORDER BY total_sales DESC

