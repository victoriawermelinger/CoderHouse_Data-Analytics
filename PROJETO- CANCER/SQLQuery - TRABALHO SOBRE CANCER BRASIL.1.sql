
ALTER TABLE [dbo].[taxas de carga de doenças por tipos de câncer MUNDIAL]
ADD coluna_relacional VARCHAR(max);

UPDATE[dbo].[taxas de carga de doenças por tipos de câncer MUNDIAL]
SET coluna_relacional = CONCAT(code,year);

select coluna_relacional from[dbo].[Câncer de mama-sobrevida-taxas-vs-PIB-per capita MUNDIAL]
select  coluna_relacional from[dbo].[mortes por câncer de pulmão-por-100000-por-sexo-1950-2002 MUNDIAL]
select  coluna_relacional from[dbo].[número de pessoas com câncer por idade]
select  coluna_relacional from[dbo].[número-de-pessoas-com-câncer-por-idade MUNDIAL]
select  coluna_relacional from[dbo].[parcela da população com câncer]
select  coluna_relacional from[dbo].[Parcela da população com câncer MUNDIAL]
select coluna_relacional from[dbo].[parcela da população com câncer por idade]
select coluna_relacional from[dbo].[Percentagem da população com câncer por idade MUNDIAL]
select coluna_relacional from[dbo].[taxa de sobrevida de cinco anos de câncer de fígado MUNDIAL]
select coluna_relacional from[dbo].[Taxa de sobrevida do câncer de pulmão vs. PIB MUNDIAL]
select coluna_relacional from[dbo].[taxas de carga de doenças por tipos de câncer MUNDIAL]
select coluna_relacional from[dbo].[taxas de carga de doenças provenientes de cânceres MUNDIAL]
select coluna_relacional from[dbo].[taxas de sobrevida de cinco anos de câncer de pulmão]
select coluna_relacional from[dbo].[taxas de sobrevida em cinco anos do câncer de mama]
select coluna_relacional from[dbo].[taxas de sobrevida em cinco anos por tipo de câncer MUNDIAL]
select coluna_relacional from [dbo].[taxas de sobrevivência de cinco anos por tipo de câncer]


select *
from[dbo].[taxas de carga de doenças por tipos de câncer MUNDIAL]