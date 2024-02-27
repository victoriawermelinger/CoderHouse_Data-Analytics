SELECT * FROM[dbo].[mortes por câncer por idade]
SELECT * FROM [dbo].[número de pessoas com câncer por idade]
SELECT * FROM [dbo].[parcela da população com câncer]
SELECT * FROM [dbo].[parcela da população com câncer por idade]
SELECT * FROM [dbo].[proporção de mortes por câncer atribuídas a fatores de risco]
SELECT * FROM [dbo].[taxas de sobrevivência de cinco anos por tipo de câncer]


-- DELETANDO (LIMPANDO OS DADOS)

DELETE FROM [mortes por câncer por idade]
WHERE 
    Year NOT IN (2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 
	2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019) OR
    Entity <> 'Brazil';

-- INCLUINDO COLUNA RELACIONAL 

ALTER TABLE [dbo].[proporção de mortes por câncer atribuídas a fatores de risco]
ADD coluna_relacional VARCHAR(max);

UPDATE [dbo].[proporção de mortes por câncer atribuídas a fatores de risco]
SET coluna_relacional = CONCAT(code,year);


drop table [proporção de mortes por câncer atribuídas a fatores de risco]

-------------------------------------------------------------------------------------------------------

ALTER TABLE [dbo].[Parcela da população com câncer MUNDIAL]
ADD coluna_relacional VARCHAR(max);

UPDATE [dbo].[Parcela da população com câncer MUNDIAL]
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

------------------------------------------------------------------------------------------------------------------


----  Media de mortes por idade: 
SELECT 
    Year,
	avg(Deaths_Neoplasms_sex_both_age_under_5_number) AS ate_4_anos,
	avg(Deaths_Neoplasms_sex_both_age_5_14_years_number) AS entre_5_e_14_anos,
	avg(Deaths_Neoplasms_sex_both_age_15_49_years_number) AS entre_15_e_49_anos,
	avg(Deaths_Neoplasms_sex_both_age_50_69_years_number) AS entre_50_e_69_anos,
	avg(Deaths_Neoplasms_sex_both_age_70_years_number) AS mais_70_anos
FROM 
    [mortes por câncer por idade]
GROUP BY 
    Year
ORDER BY 
	YEAR DESC

-- Parcela da população com câncer  
	SELECT 
    Year,
    CONCAT(
        CAST(
            (SUM(CAST(Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent AS DECIMAL(18, 2))) /
             SUM(SUM(CAST(Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent AS DECIMAL(18, 2)))) OVER ()) * 100 
            AS DECIMAL(18, 2)
        ), 
        '%'
    ) AS percentual_cancer 
FROM 
    [parcela da população com câncer]

GROUP BY 
    Year
ORDER BY 
    Year DESC;
	
-- QUANTIDADE DE MORTES POR IDADE COM PORCENTAGEM DA DOENCA POR ANO 

Select * from [mortes por câncer por idade]
select * from [dbo].[parcela da população com câncer]

select a.Year 
,a.Deaths_Neoplasms_Sex_Both_Age_Under_5_Number as Morte_ate_5anos
,a.Deaths_Neoplasms_Sex_Both_Age_5_14_years_Number as Morte_5_14anos
,a.Deaths_Neoplasms_Sex_Both_Age_15_49_years_Number as Morte_15_49anos
,a.Deaths_Neoplasms_Sex_Both_Age_50_69_years_Number as Morte_50_69anos
,a.Deaths_Neoplasms_Sex_Both_Age_70_years_Number as Morte_70_mais
, CONCAT(CAST((SUM(CAST(b.Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent AS DECIMAL(18, 2))) /
            SUM(SUM(CAST(Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent AS DECIMAL(18, 2)))) OVER ()) * 100 
            AS DECIMAL(18, 2) ), '%') AS parcela_percentual_cancer 
from [mortes por câncer por idade] a
inner join [parcela da população com câncer] b on a.Year = b. Year
group by a.Year
, a.Deaths_Neoplasms_Sex_Both_Age_Under_5_Number
,a.Deaths_Neoplasms_Sex_Both_Age_5_14_years_Number
,a.Deaths_Neoplasms_Sex_Both_Age_15_49_years_Number
,a.Deaths_Neoplasms_Sex_Both_Age_50_69_years_Number
,a.Deaths_Neoplasms_Sex_Both_Age_70_years_Number
order by year desc


-- PORCENTAGEM DE OBITOS 
    a.Year as ANO,
    SUM(A.Deaths_Neoplasms_Sex_Both_Age_Under_5_Number 
        + A.Deaths_Neoplasms_Sex_Both_Age_5_14_years_Number 
        + A.Deaths_Neoplasms_Sex_Both_Age_15_49_years_Number 
        + A.Deaths_Neoplasms_Sex_Both_Age_50_69_years_Number 
        + A.Deaths_Neoplasms_Sex_Both_Age_70_years_Number) AS SOMA_DE_OBITOS,
    B.Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent AS TOTAL_DE_PESSOAS_COM_CANCER,
    CONCAT(
        CAST(
            (SUM(A.Deaths_Neoplasms_Sex_Both_Age_Under_5_Number 
                + A.Deaths_Neoplasms_Sex_Both_Age_5_14_years_Number 
                + A.Deaths_Neoplasms_Sex_Both_Age_15_49_years_Number 
                + A.Deaths_Neoplasms_Sex_Both_Age_50_69_years_Number 
                + A.Deaths_Neoplasms_Sex_Both_Age_70_years_Number) / B.Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent) * 100 
            AS DECIMAL(10, 10)), '%' ) AS OBITOS_PORCENTAGEM
FROM 
    [mortes por câncer por idade] a
INNER JOIN 
    [parcela da população com câncer] b ON a.coluna_relacional = b.coluna_relacional
GROUP BY 
    a.Year, B.Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent