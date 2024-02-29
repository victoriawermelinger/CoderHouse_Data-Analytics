use Turma_50470
/*
1- Qual a quatidade de jogadores que temos no dataset? 
2- Qual a quantidade de jogadores distintos que temos no dataset?
3- Qual é o maior valor de jogador encontrado? e o menor?
4- Quantos países distintos temos no dataset?(países de nascimento dos jogadores)
5- Quantos jogadores nasceram em cada país identificado no item anterior ? Coloque em ordem decrescente 
6- Quantos jogadores possuem valor de mercado maior do que 1000000? 
7- Quantos jogadores possuem valor de mercado maior do que 2000000 e menor do que 4000000? 
8- Quantos jogadores nasceram no ano de 1992? 
9- QUEM são os jogadores que nasceram entre 01-01-1992 e 31-12-1995?
10- Qual o estádio com maior capacidade de público?

--Perguntas utilizando Joins

11- Qual o país de nascimento do jogador mais jovem?
12- Em que posiçao o jogador de maior valor de mercado joga? 
13- Em que posição, o jogador mais velho joga e quem é ele ? 
14- Quantos jogos cada juiz apitou? O juiz 
15- Qual o nome dos jogadores que mais tomaram cartões vermelhos ? (top 10)
16- Quais os times que mais marcaram gols?

DESAFIO TREINO 

Total de minutos jogados dos 3 jogadores mais valiosos? crie uma query
*/

--1-Qual a quatidade de jogadores que temos no dataset? 
select count(player_id) from jogadores

--2-Qual a quantidade de jogadores distintos que temos no dataset?
select count(column1) from jogadores 

--3- Qual é o maior valor de jogador encontrado? e o menor?
select* from valores_de_jogadores
select max(market_value) as valor_maximo from valores_de_jogadores 
select min(market_value) as valor_minimo from valores_de_jogadores 

--4- Quantos países distintos temos no dataset?(países de nascimento dos jogadores)
select* from jogadores
select country_of_birth as pais_de_nascimento,
count(country_of_birth) as jogadores_de_cada_pais
from jogadores
group by country_of_birth -- 174 

--5- Quantos jogadores nasceram em cada país identificado no item anterior ? Coloque em ordem decrescente 
select* from jogadores
select  country_of_birth,
count(country_of_birth) as jogadores_de_cada_pais from jogadores
group by country_of_birth
order by country_of_birth desc

--6-Quantos jogadores possuem valor de mercado maior do que 1000000 ? 
select * from valores_de_jogadores
select count(*) as NumeroDeJogadores
from valores_de_jogadores
where market_value > 1000000

--7- Quantos jogadores possuem valor de mercado maior do que 2000000 e menor do que 4000000? 
select * from valores_de_jogadores
select count(*)
from valores_de_jogadores
where market_value > 2000000 and market_value < 2000000

--8- Quantos jogadores nasceram no ano de 1992? 
select * from jogadores
select count(*) as NumeroDeJogadores
from jogadores
where year(date_of_birth) = 1992

--9- QUEM são os jogadores que nasceram entre 01-01-1992 e 31-12-1995?
select name
, date_of_birth
from jogadores
WHERE date_of_birth BETWEEN '1992-01-01' AND '1995-12-31'
order by date_of_birth

--10- Qual o estádio com maior capacidade de público?
select * from clubes
select top 1 stadium_name
, stadium_seats
from clubes
order by stadium_seats desc

-----------------------------------------------JOINS-----------------------------------------
--11- Qual o país de nascimento do jogador mais jovem?
select * from jogadores
SELECT top 1 year(date_of_birth) AS ano_de_nascimento
, country_of_birth As Pais_de_nascimento
FROM jogadores
WHERE date_of_birth IS NOT NULL AND country_of_birth IS NOT NULL
ORDER BY date_of_birth desc

--12- Em que posiçao o jogador de maior valor de mercado joga? 
SELECT TOP 1
	V.player_id,
	J.pretty_name,
	J.position
FROM valores_de_jogadores V
LEFT JOIN jogadores J
	ON V.player_id = J.player_id
ORDER BY V.market_value DESC

--13- Em que posição, o jogador mais velho joga e quem é ele ? 
SELECT TOP 1
    J.player_id,
    J.pretty_name,
    J.position,
    year(J.date_of_birth) AS ano_de_nascimento
FROM valores_de_jogadores V
LEFT JOIN jogadores J ON V.player_id = J.player_id
where J.date_of_birth is not null
ORDER BY J.date_of_birth ASC

--14- Quantos jogos cada juiz apitou? O juiz 
SELECT
	JT.referee AS Juiz,
	COUNT(JT.game_id)/2 AS JogosApitados
FROM jogos_tratados JT
WHERE JT.referee IS NOT NULL
GROUP BY JT.referee
ORDER BY 2 DESC

--15- Qual o nome dos jogadores que mais tomaram cartões vermelhos ? (top 10)
SELECT top 10
    SUM(A.red_cards) AS total_red_cards,
    J.pretty_name
FROM
    aparicoes A
LEFT JOIN
    jogadores J ON A.player_id = J.player_id
WHERE A.red_cards IS NOT NULL
GROUP BY J.pretty_name
ORDER By total_red_cards DESC

-- 16- Quais os times que mais marcaram gols?
SELECT TOP 10
    SUM(A.goals) AS total_de_gols,
    C.pretty_name
FROM
    aparicoes A
LEFT JOIN
    clubes C ON A.player_id = C.club_id
WHERE
    A.goals IS NOT NULL AND C.pretty_name IS NOT NULL
GROUP BY
    C.pretty_name
ORDER BY
    SUM(A.goals) DESC

--DESAFIO TREINO 
--Total de minutos jogados dos 3 jogadores mais valiosos? crie uma query

select * from jogadores
select * from valores_de_jogadores
select * from aparicoes
SELECT TOP 3
    J.pretty_name,
    V.market_value,
    A.minutes_played
FROM jogadores J
LEFT JOIN ( SELECT player_id,
        MAX(market_value) AS market_value
FROM valores_de_jogadores
GROUP BY player_id
) V ON J.player_id = V.player_id
LEFT JOIN (SELECT player_id,
        SUM(minutes_played) AS minutes_played
FROM aparicoes
WHERE minutes_played IS NOT NULL
GROUP BY player_id
) A ON J.player_id = A.player_id
WHERE A.minutes_played IS NOT NULL
ORDER BY V.market_value DESC;

SELECT TOP 3
	J.player_id,
	J.pretty_name,
	J.market_value_in_gbp,
	sum(A.minutes_played) AS MinutosJogados
FROM jogadores J
LEFT JOIN aparicoes A
	ON J.player_id = A.player_id
GROUP BY
	J.player_id,
	J.pretty_name,
	J.market_value_in_gbp
ORDER BY 3 DESC