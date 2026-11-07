CREATE OR REPLACE TABLE `aula-sql-476221.vendas.Tabela_Crescimento_MoM` AS

WITH tab AS (

    SELECT
        DATE_TRUNC(data_pedido, MONTH) AS mes,
        SUM(receita) AS receita_total

    FROM `aula-sql-476221.vendas.newtable1`

    GROUP BY 1

)

SELECT
    mes,
    receita_total,

    (
        receita_total -
        LAG(receita_total) OVER (ORDER BY mes ASC)
    ) / LAG(receita_total) OVER (ORDER BY mes ASC) AS MoM

FROM tab

ORDER BY 1 ASC;
