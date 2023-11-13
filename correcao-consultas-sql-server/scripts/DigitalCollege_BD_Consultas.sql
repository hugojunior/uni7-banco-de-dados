-- PostgreSQL
-- https://www.postgresql.org/docs/15/sql-select.html

-- ******
-- SELECT
-- ******

SELECT * FROM tbven;
-- Lendo o comando: Seleciona todas as colunas da tabela: tbven e seus respectivos registros (linhas)

SELECT * FROM tbven_item;
-- Lendo o comando: Seleciona todas as colunas da tabela: tbven_item e seus respectivos registros (linhas)

SELECT * FROM tbpro;
-- Lendo o comando: Seleciona todas as colunas da tabela: tbpro e seus respectivos registros (linhas)

SELECT * FROM tbvdd;
-- Lendo o comando: Seleciona todas as colunas da tabela: tbvdd e seus respectivos registros (linhas)

SELECT * FROM tbdep;
-- Lendo o comando: Seleciona todas as colunas da tabela: tbdep e seus respectivos registros (linhas)

-- -------------------------------------------------------------------------------------------------------
-- Warning: Evite o uso do *, seja específico, adicione apenas as colunas que irá precisar na sua análise.
-- Exemplo:

SELECT estcli AS Estado,
       cidcli AS Cidade
  FROM tbven;
-- Lendo o comando: Seleciona as colunas: estcli (Alias: Estado) e cidcli (Alias: Cidade) da tabela: tbven

-----------------------------------------------------------
-- https://www.w3schools.com/sql/sql_comments.asp

-- Neste momento já percebeu que o (--) indica comentários.
/* Assim como este
trecho também é um comentário, 
mas só que de múltiplas linhas */

-- *****
-- WHERE
-- *****
-- https://www.w3schools.com/sql/sql_where.asp

SELECT estcli AS Estado,
       cidcli AS Cidade
  FROM tbven
 WHERE cdcli = 16;

/* Lendo o comando
   Seleciona as colunas: estcli (Alias: Estado) e cidcli (Alias: Cidade) da tabela: tbven, quando o cdcli for igual a 16
*/

-- ********
-- DISTINCT
-- ********
SELECT DISTINCT
       estcli AS Estado,
       cidcli AS Cidade
  FROM tbven
 WHERE cdcli = 16;
 
-- Lendo o comando: Seleciona distintamente as colunas: estcli (Alias: Estado) e cidcli (Alias: Cidade) da tabela: tbven, 
-- quando o cdcli for igual a 16

-- ************
-- LIMIT ou TOP
-- ************
SELECT *
  FROM tbven
 LIMIT 10;
-- Lendo o comando: Seleciona as 10 primeiras vendas (tbven)

-- **************
-- AND | OR | NOT
-- **************
-- Exemplo de AND

SELECT cdven  AS CodigoVenda,
	   cdcli  AS CodigoCliente,
       estcli AS Estado,
       cidcli AS Cidade,
	   dtven  AS DataVenda
  FROM tbven
 WHERE cdcli = 16
   AND dtven > '20230301';

-- Exemplo de OR
SELECT cdven  AS CodigoVenda,
	   cdcli  AS CodigoCliente,
       estcli AS Estado,
       cidcli AS Cidade,
	   dtven  AS DataVenda
  FROM tbven
 WHERE (cdcli = 16 or cdcli = 8);

-- Exemplo de NOT
SELECT cdven  AS CodigoVenda,
	   cdcli  AS CodigoCliente,
       estcli AS Estado,
       cidcli AS Cidade,
	   dtven  AS DataVenda
  FROM tbven
 WHERE NOT cdcli = 16
   AND dtven > '20230301';

-- ********************************************************
-- Funções de agregação (SUM, AVG, MAX, MIN, COUNT e ROUND)
-- ********************************************************
-- https://www.w3schools.com/sql/sql_count_avg_sum.asp
-- https://www.w3schools.com/sql/sql_min_max.asp

-- ----------------------------------------------------
-- Somatório da quantidade de produtos vendidos (qtven)
-- ----------------------------------------------------
SELECT *
  FROM tbven_item;

SELECT SUM(qtven) AS quantidade_venda
  FROM tbven_item;

-- ------------------------------------------------
-- Média da quantidade de produtos vendidos (qtven)
-- ------------------------------------------------
SELECT AVG(qtven) AS media_quantidade_venda
  FROM tbven_item;

-- ---------------------------------------------
-- Maior quantidade de produtos vendidos (qtven)
-- ---------------------------------------------
SELECT MAX(qtven) AS maior_quantidade_venda
  FROM tbven_item;

-- ---------------------------------------------
-- Menor quantidade de produtos vendidos (qtven)
-- ---------------------------------------------
SELECT MIN(qtven) AS menor_quantidade_venda
  FROM tbven_item;

-- ------------------------------------------------------------
-- Contagem de produtos (quantos produtos temos na nossa base?)
-- ------------------------------------------------------------
SELECT *
  FROM tbpro;

SELECT count(cdpro) as qtd_produtos
  FROM tbpro;

-- *****
-- UNION
-- *****
SELECT * FROM tbven;

-- Tenho 2 consultas, uma que mostra os clientes que compraram em Salvador e outras com vendas de Gramado, quero unir essas consultas

SELECT cdcli, nmcli FROM tbven WHERE cidcli = 'Salvador';

SELECT cdcli, nmcli FROM tbven WHERE cidcli = 'Gramado';
 
-- Union all
SELECT cdcli, nmcli FROM tbven WHERE cidcli = 'Salvador'
UNION ALL
SELECT cdcli, nmcli FROM tbven WHERE cidcli = 'Gramado';
 
-- Union
SELECT cdcli, nmcli FROM tbven WHERE cidcli = 'Salvador'
UNION
SELECT cdcli, nmcli FROM tbven WHERE cidcli = 'Gramado';

------------
-- Extra* --
------------
-- Union e criando uma coluna auxiliar
SELECT SUM(qtven)   AS qtd, 'Quantidade de Venda - Somatório' AS descricao FROM tbven_item
UNION
SELECT AVG(qtven)   AS qtd, 'Quantidade de Venda - Média'     AS descricao FROM tbven_item
UNION
SELECT MAX(qtven)   AS qtd, 'Quantidade de Venda - Máxima'    AS descricao FROM tbven_item
UNION
SELECT MIN(qtven)   AS qtd, 'Quantidade de Venda - Minima'    AS descricao FROM tbven_item
UNION
SELECT count(cdpro) AS qtd, 'Quantidade de Produtos - Count'  AS descricao FROM tbpro;

-- **********************
-- ORDER BY — Ordenar por
-- **********************
-- https://www.w3schools.com/sql/sql_ref_order_by.asp

SELECT *
  FROM tbven_item
 ORDER BY qtven DESC; -- Ordena de forma decrescente (ASC - Crescente)

/* Lendo o comando: 
   Seleciona todos os registros relacionados a vendas (tabela: tbven_item), ORDENADOS das maiores quantidades (qtven) para as menores.
   
   Aqui vou começar a utilizar outras tabelas e mais campos.
   Lembre-se sempre, se puder ser o mais especifíco em relação as colunas que vai utilizar, melhor.
*/

-- ********
-- GROUP BY
-- ********

-- Quantidade comprada de um determinado produto
SELECT cdpro      AS Produto 
     , SUM(qtven) AS Qtd
  FROM tbven_item
 GROUP BY cdpro
 ORDER BY SUM(qtven);
 
-- Top 5 produtos mais vendidos?
SELECT cdpro      AS Produto 
     , SUM(qtven) AS Qtd
  FROM tbven_item
 GROUP BY cdpro
 ORDER BY SUM(qtven) DESC
 LIMIT 5;
 
 
------------
-- Extra* --
------------
/* Necessidade: Seu cliente precisa de uma relação de quantidade de clientes por Estado
   Lendo o comando: Mostra o Estado e a quantidade de clientes naquele Estado, agrupando por Estado.
*/

SELECT * FROM tbven;
  
SELECT estcli                AS Estado
     , count(DISTINCT cdcli) AS qtd_clientes
  FROM tbven
 GROUP BY estcli                      -- Agrupa por estado do cliente
 ORDER BY count(DISTINCT cdcli) DESC; -- Ordena de forma decrescente

-- ******************************************
-- HAVING — Condições em Agrupamento de dados
-- ******************************************
-- https://www.w3schools.com/sql/sql_having.asp

SELECT * FROM tbven_item;

-- Quantidade comprada de um determinado produto (Quantidade maiores de 10.000)
SELECT cdpro      AS Produto 
     , SUM(qtven) AS Qtd
  FROM tbven_item
 GROUP BY cdpro
HAVING SUM(qtven) > 10000;

/* Lendo o comando: Mostra o Estado e a quantidade de clientes naquele Estado, agrupando por Estado, se a contagem de cliente for maior que 1.
*/

-- ************
-- IN | BETWEEN
-- ************
-- https://www.w3schools.com/sql/sql_in.asp
-- https://www.w3schools.com/sql/sql_between.asp

-- Exemplo de IN e BETWEEN
-- Moste o código da venda e o código do produto, quanto o produto for 2 ou 3 e o código de venda estiver entre 1 e 9.
SELECT cdven AS CodigoVenda,
       cdpro AS CodigoProduto
  FROM tbven_item
 WHERE cdpro IN (2,3)
   AND cdven BETWEEN 1 AND 9;

-- outro exemplo usando texto
SELECT *
  FROM tbpro
 WHERE nmpro IN ('Produto C', 'Produto A');

-- ****
-- LIKE
-- ****
-- https://www.w3schools.com/sql/sql_ref_like.asp
-- https://www.w3schools.com/sql/sql_wildcards.asp

SELECT *
  FROM tbpro
 WHERE nmpro LIKE '% C%';

-- outro exemplo
SELECT * 
  FROM tbpro
 WHERE nmpro LIKE ('%A');

-- ****
-- NULL
-- ****
-- https://www.w3schools.com/sql/sql_ref_is_null.asp

-- Código e Nome do Produto que tenha nulo...
SELECT cdpro,
       nmpro
  FROM tbpro
 WHERE slpro is null;
 
-- não tem saldo nulo
SELECT cdpro,
       nmpro
  FROM tbpro
 WHERE slpro is not null;

-- *******************************************************************
-- TRIM | REPLACE | LPAD | REPLICATE | SUBSTRING | UPPER | LOWER | LEN
-- *******************************************************************

SELECT * FROM tbpro;

SELECT p.cdpro, -- Informação original (CodigoProduto)
       p.nmpro, -- Informação original (NomeProduto)
       TRIM(p.nmpro)                        AS TRIM, -- removendo espaços da coluna NomeProduto (o AS é dando um Alias, ou seja, um apelido para a coluna)
       REPLACE(p.nmpro, 'A', 'AA')          AS REPLACE, -- Substituido onde tiver A por AA no Tipo de Produto
       lpad(cast(p.cdpro as varchar),4,'0') AS LPAD,  -- Adiciona zeros a esquerda no código do produto até completar 9 dígitos - LPAD
       SUBSTRING(p.nmpro, 1, 3)             AS SUBSTRING, -- Pega os primeiros 3 caracteres da coluna de Nome do Produto 
       UPPER(p.nmpro)                       AS UPPER, -- Nome de Produto em maiúsculo
       LOWER(p.nmpro)                       AS LOWER, -- Nome de Produto em minúsculo
       INITCAP(p.nmpro)                     AS INICIAR_MAISCULO,
       LENGTH(p.nmpro)                      AS LENGTH -- Quantos caracteres tem o campo NomeProduto
  FROM tbpro AS p; -- o AS aqui, também é Alias, um apelido aqui no caso para Tabelas

/* Lendo o comando: 
   Aqui vou começar a utilizar outras tabelas e mais campos. Além de mais alguns recursos, como Alias (apelidos)
   Lembre-se sempre, se puder ser o mais especifíco em relação as colunas que vai utilizar, melhor.
*/

-- *********************************
-- DATE — Operações envolvendo datas
-- *********************************
-- https://www.w3schools.com/sql/sql_ref_sqlserver.asp

SELECT v.dtven                                as Data
     , date_part('day',v.dtven)               as Dia
     , date_part('month',v.dtven)             as Mes
     , date_part('year',v.dtven)              as Ano
     , to_char(dtven, 'DD-MM-YYYY')           as "Mes-Dia-Ano"
     , to_char(dtven, 'YYYY-MM-DD')           as "Ano-Mes-Dia"
     , to_char(dtven, 'YYYYMMDD')             as "AnoMesDia"
     , current_timestamp                      as hora_atual
     , extract(hour from current_timestamp)   as Hora
     , extract(minute from current_timestamp) as Minuto
  FROM tbven v;

-- *****************************************************************************************************************************
-- JOIN — Relacionamento entre tabelas — Operação que permite buscar informações de duas ou mais tabelas que estão relacionadas.
-- *****************************************************************************************************************************
-- https://blogdozouza.wordpress.com/2011/11/29/entendendo-os-tipos-de-joins/
-- https://www.w3schools.com/sql/sql_join.asp

-- -------------
-- Inner Join --
-- -------------
-- https://www.w3schools.com/sql/sql_join_inner.asp

-- O Inner Join é o método de junção mais conhecido e retorna os registros que são comuns às duas tabelas.
SELECT * FROM tbven_item;
SELECT * FROM tbpro;

-- Relacionando a tabela de vendas com a de produtos
SELECT *
  FROM      tbven_item ven
 INNER JOIN tbpro      pro ON pro.cdpro = ven.cdpro;

-- Boa prática (ser específico)
SELECT ven.cdven  as CodigoVenda
     , ven.qtven  as Quantidade
     , ven.vrtven as ValorTotal
     , pro.nmpro  as Produto
  FROM      tbven_item ven
 INNER JOIN tbpro      pro ON pro.cdpro = ven.cdpro;

-- -------------
-- Left Join --
-- -------------
-- https://www.w3schools.com/sql/sql_join_left.asp

-- O Left Join tem como resultado todos os registros que estão na tabela A (mesmo que não estejam na tabela B) 
-- e os registros da tabela B que são comuns à tabela A.
SELECT *
  FROM      tbven_item ven
  LEFT JOIN tbpro      pro ON pro.cdpro = ven.cdpro;

-- Exemplo com Vendedor e Dependente -- *
SELECT *
  FROM      tbvdd vdd
  LEFT JOIN tbdep dep ON dep.cdvdd = vdd.cdvdd;

SELECT *
  FROM      tbvdd vdd
  LEFT JOIN tbdep dep ON dep.cdvdd = vdd.cdvdd;

-- -------------
-- Right Join --
-- -------------
-- https://www.w3schools.com/sql/sql_join_right.asp

-- Usando o Right Join teremos como resultado todos os registros que estão na tabela B (mesmo que não estejam na tabela A) 
-- e os registros da tabela A que são comuns à tabela B.

SELECT *
  FROM      tbven_item ven
 RIGHT JOIN tbpro      pro ON pro.cdpro = ven.cdpro;

------------
-- Extra* --
------------

-- -------------
-- Outer Join --
-- -------------
-- https://www.w3schools.com/sql/sql_join_full.asp

-- O Outer Join (também conhecido por Full Outer Join ou Full Join) tem como resultado todos os registros que estão na tabela A e todos os registros da tabela B.
SELECT *
  FROM      tbven_item ven
  FULL JOIN tbpro      pro ON pro.cdpro = ven.cdpro;
  

------------
-- Extra* --
------------
-- Remover acentuação
CREATE EXTENSION IF NOT EXISTS unaccent;
SELECT unaccent('TÊXTÔ ÂCCÊNTÚÂDÔ');

-- Exemplo de como gerar um código sequencial para uma coluna
SELECT ROW_NUMBER() OVER (ORDER BY nmpro) AS codigo,
       nmpro                              AS NomeProduto
 FROM public.tbpro
GROUP BY nmpro;

-- ****************************************************
-- CAST | CONVERT — Convertem um tipo de dados em outro
-- ****************************************************
-- https://www.w3schools.com/sql/sql_ref_sqlserver.asp

SELECT DISTINCT 
       c.cdcli,
       concat('Código - ', CAST(c.cdcli AS CHAR)) AS CodigoCliente_Texto
  FROM tbven c;
  
/* Lendo o comando: 
   Neste caso, o cliente precisava adicionar a palavra "Código - ", antes do código do Cliente
   Concatenamos (Comando CONCAT) a palavra solicitada com o código do cliente, 
   para concatenarmos, colocamos o código como texto usando o CAST (comando para converter tipos de dados)
*/