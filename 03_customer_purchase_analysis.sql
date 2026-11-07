create or replace table `aula-sql-476221.vendas.newtable3` as
(
with geral as
(
SELECT
    t1.id AS user_id,
    t2.order_id,
    date_trunc(t2.created_at,month) as data_mes,
    t1.age,
    t1.traffic_source,
  t2.sale_price
   FROM `aula-sql-476221.vendas.Users` AS t1
INNER JOIN `aula-sql-476221.vendas.Order_items` AS t2
ON t1.id = t2.user_id
),

agregacao as(
select 
user_id,
order_id,
data_mes,
age,
traffic_source,
sum(sale_price) as preco
from geral
group by 1,2,3,4,5
),
classificacoes as(
select *,
row_number () over(partition by user_id order by data_mes asc) n_compras,
case
WHEN age BETWEEN 12 AND 18 THEN '12-18'
    WHEN age BETWEEN 19 AND 25 THEN '19-25'
    WHEN age BETWEEN 26 AND 32 THEN '26-32'
    WHEN age BETWEEN 33 AND 39 THEN '33-39'
    WHEN age BETWEEN 40 AND 46 THEN '40-46'
    WHEN age BETWEEN 47 AND 56 THEN '47-56'
    ELSE '57+'
END AS faixa_idade
from agregacao
)

select *,
case
when n_compras = 1 then 'novo'
else 'recorrente'
end as classificacao_cliente
from classificacoes
)
