CREATE OR REPLACE TABLE `aula-sql-476221.vendas.newtable1`AS 
(
WITH tab AS (

    SELECT
        t1.order_id,
        t1.status,
        CAST(t1.created_at AS DATE) AS data_pedido,
        CAST(t1.shipped_at AS DATE) AS data_envio,
        CAST(t1.delivered_at AS DATE) AS data_entrega,
        t1.sale_price,
        t2.cost,
        (t1.sale_price - t2.cost) AS lucro

    FROM `aula-sql-476221.vendas.Order_items` AS t1

    LEFT JOIN `aula-sql-476221.vendas.Products` AS t2
        ON t1.product_id = t2.id

)

SELECT
    order_id,
    status,
    data_pedido,
    data_envio,
    data_entrega,
    SUM(sale_price) AS receita,
    SUM(cost) AS cost,
    SUM(lucro) AS lucro

FROM tab

GROUP BY 1, 2, 3, 4, 5
)
