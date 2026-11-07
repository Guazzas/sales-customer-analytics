-- Create a table to analyze customer purchases and classify customers.
CREATE OR REPLACE TABLE `aula-sql-476221.vendas.newtable3` AS

(
-- CTE 1: GERAL
-- Combine customer and order data to bring customer attributes
-- and purchase information into a single dataset.
WITH geral AS
(
    SELECT
        t1.id AS user_id,
        t2.order_id,

        -- Standardize purchase dates at monthly level.
        DATE_TRUNC(t2.created_at, MONTH) AS data_mes,

        t1.age,
        t1.traffic_source,
        t2.sale_price

    FROM `aula-sql-476221.vendas.Users` AS t1

    -- INNER JOIN: Include only records with matching customers and orders.
    INNER JOIN `aula-sql-476221.vendas.Order_items` AS t2
        ON t1.id = t2.user_id
),

-- CTE 2: AGREGACAO
-- Aggregate item values to calculate the total purchase value
-- for each customer and order.
agregacao AS (
    SELECT
        user_id,
        order_id,
        data_mes,
        age,
        traffic_source,
        SUM(sale_price) AS preco

    FROM geral

    GROUP BY 1, 2, 3, 4, 5
),

-- CTE 3: CLASSIFICACOES
-- Assign a purchase sequence to each customer and classify
-- customers into age groups.
classificacoes AS (
    SELECT
        *,

        -- ROW_NUMBER: Number purchases sequentially for each customer.
        ROW_NUMBER() OVER(
            PARTITION BY user_id
            ORDER BY data_mes ASC
        ) AS n_compras,

        -- CASE WHEN: Segment customers into age groups.
        CASE
            WHEN age BETWEEN 12 AND 18 THEN '12-18'
            WHEN age BETWEEN 19 AND 25 THEN '19-25'
            WHEN age BETWEEN 26 AND 32 THEN '26-32'
            WHEN age BETWEEN 33 AND 39 THEN '33-39'
            WHEN age BETWEEN 40 AND 46 THEN '40-46'
            WHEN age BETWEEN 47 AND 56 THEN '47-56'
            ELSE '57+'
        END AS faixa_idade

    FROM agregacao
)

-- Final classification:
-- Identify the first purchase as new customer activity
-- and subsequent purchases as returning customer activity.
SELECT
    *,
    CASE
        WHEN n_compras = 1 THEN 'novo'
        ELSE 'recorrente'
    END AS classificacao_cliente

FROM classificacoes
)
