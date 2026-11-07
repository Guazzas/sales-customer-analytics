-- Create a table to calculate monthly revenue and month-over-month growth.
CREATE OR REPLACE TABLE `aula-sql-476221.vendas.Tabela_Crescimento_MoM` AS

-- Aggregate revenue by month to prepare the monthly analysis.
WITH tab AS (

    SELECT
        -- DATE_TRUNC: Standardize order dates to the first day of each month.
        DATE_TRUNC(data_pedido, MONTH) AS mes,
        SUM(receita) AS receita_total

    FROM `aula-sql-476221.vendas.newtable1`

    -- Group orders by month to calculate total monthly revenue.
    GROUP BY 1

)

SELECT
    mes,
    receita_total,

    -- LAG: Retrieve the previous month's revenue.
    -- Calculate month-over-month growth as the percentage change
    -- relative to the previous month's revenue.
    (
        receita_total -
        LAG(receita_total) OVER (ORDER BY mes ASC)
    ) / LAG(receita_total) OVER (ORDER BY mes ASC) AS MoM

FROM tab

-- Sort results chronologically to display monthly revenue evolution.
ORDER BY 1 ASC;
