-- QUERY TAREFA --

-- 1-SOMA DE CARTÕES DOS JOGADORES --
SELECT
    a.pretty_name AS 'NOME DOS JOGADORES',
    SUM(b.yellow_cards) AS 'SOMA DE CARTOES AMARELOS',
    SUM(b.red_cards) AS 'SOMA DE CARTÕES VERMELHOS',
    SUM(b.yellow_cards + b.red_cards) AS 'SOMA TOTAL DE CARTÕES'
FROM
    jogadores AS a
    LEFT JOIN aparicoes AS b ON a.player_id = b.player_id
WHERE
    yellow_cards IS NOT NULL
GROUP BY
    a.pretty_name
ORDER BY
    'SOMA TOTAL DE CARTÕES' DESC

-- 2-JOGADORES BRASILEIROS QUE MAIS MARCARAM GOLS NO CAMP. ENGLAND -- 

SELECT 
	TOP 3 
	a.player_id AS 'ID DE JOGADOR',
	j.pretty_name AS 'NOME DO JOGADOR',
	SUM(a.goals) as 'GOLS'
FROM 
	aparicoes A
	left join jogadores J on
	A.player_id = J.player_id
	left join competicoes C on
	A.competition_id = C.competition_id
WHERE
	J.country_of_birth = 'Brazil' and
	C.country_name = 'England'
GROUP BY
	A.player_id , J.pretty_name
ORDER BY
	3 DESC

-- 3-QUAIS OS 10 CLUBES QUE TIVERAM MAIS PUBLICO NOS JOGOS EM CASA EM 2019? -- 

SELECT 
	TOP 10 
	C.pretty_name,
	SUM(J.attendance) AS 'Publico Total'
FROM 
	jogos_tratados J
	left join clubes C ON
	J.club_id = C.club_id
WHERE
	J.played_in = 'home' and
	YEAR(J.date) = 2019 and
	C.club_id is not NULL
GROUP BY
	C.pretty_name
ORDER BY
	2 DESC

-- EXEMPLO DO ALEX SOBRE INNER JOIN --
	select top 50 * from jogos_tratados

	select c.club_id as 'ID DO CLUBE', c.pretty_name as 'NOME DO CLUBE', j.stadium as 'ESTADIO'
	from clubes as c inner join jogos_tratados as j on
	c.club_id = j.club_id

-- 4-Quais os 10 campeonatos que tiveram mais empates em 2013 --
SELECT TOP 10
	C.name,
	C.country_name,
	COUNT(J.game_id) AS 'Quantidade de Empates'
FROM jogos_tratados J
LEFT JOIN competicoes C ON
	J.competition_code = C.competition_id
WHERE
	YEAR(J.date) = '2013' AND
	J.goals = J.foe_goals
GROUP BY
	C.name,
	C.country_name
ORDER BY
	3 DESC

-- 5-Os top 3 jogadores com maior tempo de jogos.
SELECT TOP 3
    a.stadium,
    a.attendance,
    SUM(b.minutes_played) AS total_minutes_played
FROM jogos_tratados AS a
LEFT JOIN aparicoes AS b ON a.game_id = b.game_id
WHERE a.attendance IS NOT NULL
GROUP BY a.stadium, a.attendance
ORDER BY total_minutes_played DESC

