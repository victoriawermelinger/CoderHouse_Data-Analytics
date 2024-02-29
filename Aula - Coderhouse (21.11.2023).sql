-- 21/11/2023 Aula --

create database Turma_50470
create database CoderHouse_50470

select *
from jogos_tratados

select * 
from clubes

select game_id
, stadium
from jogos_tratados

select club_id
, pretty_name
, foreigners_number 
from clubes 

-- 23/11/2023 Aula --

select * from clubes
select * from jogadores
-- pegando duas letras do lado esquerdo
select left(pretty_name,2) from jogadores 

-- pegando duas letras do lado direito 
select right(pretty_name,2) from jogadores

select pretty_name
, left(pretty_name,2) 
, right(pretty_name,2) 
from jogadores

-- vamos perfuramr com a função AS
select pretty_name
, left(pretty_name,2) as esquerda
, right(pretty_name,2) as direita 
from jogadores

-- vamos ver outra funçao de concatenar 
select * from jogadores

select concat(pretty_name,position) 
from jogadores

select concat (pretty_name,'--', position) 
from jogadores -- o que colocar '', encara com espaço.

select concat(pretty_name, ' | ',position) as 'Nome e Posição'
from jogadores

-- Funções com Data 
select * from valores_de_jogadores

select year(date) as ANO
from valores_de_jogadores

select month(date) as mês
from valores_de_jogadores

select day(date) as dia 
from valores_de_jogadores

select year(date) as ano
, month(date) as mês
, day(date) as dia 
from valores_de_jogadores

-- Funcao muito utilizada, mas utilizada demias da conta - funcao TOP
/*obs: é uma amostra aleatória*/

select top 20 * from aparicoes

-- Select distinct 
select distinct country_of_birth from jogadores

-- Funcao mais importante da aula HOJE 
/* Estrutura padrao de SQL
selecionamos algo, de algum lugar e que alguma coisa acontece

Alguma coisa acontece = where
queremos um jogador especifico, o 51053
para isso:
*/

select * from valores_de_jogadores
where player_id = 51053

select player_id
, market_value
from valores_de_jogadores
where player_id = 51053


select *
from jogadores
where country_of_birth = 'France'

-- OBS: para textos/varchar/nvarchar necessitamos da aspas simples
-- para numeros nao
-- para datas precisa 

select * from valores_de_jogadores
where date = '2013'

-- Funcao AND

select *
from jogadores
where country_of_birth = 'France' and 
position = 'defender' and
foot = 'left'
 
 -- 28/11/2023 Aula--
 --função or / and --
 select * from jogadores
 where country_of_birth = 'fance' or 
 country_of_birth = 'germany'

 select date from valores_de_jogadores 
 where date = '2013-06-17'

 -- Operador de diferente (<>, !=)
 select * from jogadores
 where country_of_birth != 'france'

  select * from jogadores
 where country_of_birth <> 'france'

 -- Outros operadores (>, >, >=, <=) operadores logicos numericos
 -- tambem seve para datas 
select * from valores_de_jogadores
where market_value > 1000000

select distinct last_season from jogadores
where last_season = 2013 or 
last_season = 2014 or 
last_season = 2017

-- alternativos para query anterior 
select distinct last_season from jogadores
where last_season in (2013,2014,2017)

-- Negando a query anterior 
select distinct last_season from jogadores
where last_season NOT in (2013,2014,2017)

-- Exemplo para aplicar com a tabela jogadores sobre NOT BETWEEN
select * 
from jogadores
where last_season not between 2014 and 2017;

-- Operadores NULL / is null/ is not null 
select * from jogadores
where market_value_in_gbp is null 

-- negando a query anterior 
select * from jogadores
where market_value_in_gbp is null 

-- Função Order by (ordernar por alguma variavel)
-- crescente 
select top 50 * 
from valores_de_jogadores
order by market_value

-- decrescente 
select top 50 * 
from valores_de_jogadores
order by market_value desc

select top 10* from jogadores
order by pretty_name

-- OBS, nulo e sempre o menor "valor" 
select top 10* from jogadores
where market_value_in_gbp is not null 
order by market_value_in_gbp

select distinct top 10* from jogadores
where market_value_in_gbp is not null 
order by market_value_in_gbp


-- funçoes bem utilizadas
--- count (conta quantas linhas/valores não nulas)
select COUNT (*) from clubes -- 400
select count(*) from aparicoes -- 1041799
select count(*) from jogadores -- 23666
select count (market_value_in_gbp) from jogadores -- 16806 (por que tem valores nulo)

select count(distinct(position)) from jogadores

-- funçao soma (sum) nao posse somar textos 
select sum(market_value) from valores_de_jogadores
--775987580999

select sum(market_value) from valores_de_jogadores 
where player_id = 51053 -- 11260000

-- TIRAR A MÉDIA 
select sum(market_value)/ count(*) from valores_de_jogadores
-- MAS PODEMOS TIRAR COM AVG
select avg(market_value) from valores_de_jogadores
/*
MIN - MINIMUM
MAX - MAXIMUM 
SUM - SOMA
AVG - AVERAGE
*/

select avg(market_value) as media
, max(market_value) as maximo
, min(market_value) as minimo
from valores_de_jogadores
where player_id = 51053

select player_id
, sum(market_value)
from valores_de_jogadores
group by player_id


-- aula de JOINS 
SELECT player_id
, market_value 
FROM valores_de_jogadores
order by market_value desc

select jogadores.player_id, 
jogadores.pretty_name , 
jogadores.country_of_birth,
valores_de_jogadores.market_value                                                
from jogadores left join valores_de_jogadores on jogadores.player_id = valores_de_jogadores.player_id
order by market_value desc

