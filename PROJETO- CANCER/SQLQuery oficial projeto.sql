--- Dados mundiais:
-- A média de mortes por tipo de cancer de 2010 - 2016 em ordem. 

SELECT 
    Year,
    avg(Bladder_cancer_deaths) AS bexiga,
	avg(Brain_and_nervous_system_cancer_deaths) AS cerebro_e_sistema_nervoso,
	avg(Breast_cancer_deaths) AS Mama,
	avg(Cervical_cancer_deaths) AS Cervical,
	avg(colon_and_rectum_cancer_deaths) AS colon_e_reto, 
	avg(Esophageal_cancer_deaths) AS esofagico,
	avg(Gallbladder_cancer_deaths) AS vesicula_biliar,
	avg(Kidney_cancer_deaths) AS rim,
	avg(Larynx_cancer_deaths) AS laringe,
	avg(Leukemia_deaths) AS leucemia,
	avg(Lip_and_oral_cavity_cancer_deaths) AS labial_e_oral,
	avg(Liver_cancer_deaths) AS figado,
	avg(Non_Hodgkin_lymphoma_deaths) AS linfoma_não_hodgkin,
	avg(Ovarian_cancer_deaths) AS ovario,
	avg(pancreatic_cancer_deaths) AS pancreatico,
	avg(Prostate_cancer_deaths) AS prostata,
	avg(Stomach_cancer_deaths) AS estomago, 
	avg(Tracheal_bronchus_and_lung_cancer_deaths) AS Traqueia
FROM 
    [mortes por câncer por tipo agrupadas]
WHERE 
    Year IN (2010, 2011, 2012, 2013, 2014, 2015, 2016)
GROUP BY 
    Year
ORDER BY 
	YEAR DESC

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
WHERE 
    Year IN (2010, 2011, 2012, 2013, 2014, 2015, 2016)
GROUP BY 
    Year
ORDER BY 
	YEAR DESC

--- Parcela da população com câncer  2010 - 2016:

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
    [parcela da população com câncer2]
WHERE 
    Year IN (2010, 2011, 2012, 2013, 2014, 2015, 2016)
GROUP BY 
    Year
ORDER BY 
    Year DESC;


----- Taxa de sobrevivencia de 5 anos: (pendente)

-- Dados no Brasil: Os tipos de câncer e a média de mortes no país:

SELECT Entity, Year,
avg(Bladder_cancer_deaths) AS bexiga,
avg(Brain_and_nervous_system_cancer_deaths) AS cerebro_e_sistema_nervoso,
avg(Breast_cancer_deaths) AS Mama,
avg(Cervical_cancer_deaths) AS Cervical,
avg(colon_and_rectum_cancer_deaths) AS colon_e_reto, 
avg(Esophageal_cancer_deaths) AS esofagico,
avg(Gallbladder_cancer_deaths) AS vesicula_biliar,
avg(Kidney_cancer_deaths) AS rim,
avg(Larynx_cancer_deaths) AS laringe,
avg(Leukemia_deaths) AS leucemia,
avg(Lip_and_oral_cavity_cancer_deaths) AS labial_e_oral,
avg(Liver_cancer_deaths) AS figado,
avg(Non_Hodgkin_lymphoma_deaths) AS linfoma_não_hodgkin,
avg(Ovarian_cancer_deaths) AS ovario,
avg(pancreatic_cancer_deaths) AS pancreatico,
avg(Prostate_cancer_deaths) AS prostata,
avg(Stomach_cancer_deaths) AS estomago, 
avg(Tracheal_bronchus_and_lung_cancer_deaths) AS Traqueia
FROM [mortes por câncer por tipo agrupadas]
WHERE Year IN (2010, 2011, 2012, 2013, 2014, 2015, 2016) and 
Entity = 'Brazil'
GROUP BY Entity, Year
ORDER BY YEAR DESC

-- percentual da população com cancer no brasil (soma dos anos):

SELECT 
    Entity,
    CONCAT(
        CAST(
            SUM(CAST(Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent AS DECIMAL(18, 2)))
            AS DECIMAL(18, 2)
        ),
        '%'
    ) AS percentual_cancer
FROM 
    [parcela da população com câncer2]
WHERE 
    Year IN (2010, 2011, 2012, 2013, 2014, 2015, 2016)
    AND Entity = 'Brazil'
GROUP BY 
    Entity;




-- numero de mortes por cancer por idade:

SELECT 
    Year,
	avg(Deaths_Neoplasms_sex_both_age_under_5_number) AS ate_4_anos,
	avg(Deaths_Neoplasms_sex_both_age_5_14_years_number) AS entre_5_e_14_anos,
	avg(Deaths_Neoplasms_sex_both_age_15_49_years_number) AS entre_15_e_49_anos,
	avg(Deaths_Neoplasms_sex_both_age_50_69_years_number) AS entre_50_e_69_anos,
	avg(Deaths_Neoplasms_sex_both_age_70_years_number) AS mais_70_anos
FROM 
    [mortes por câncer por idade]
WHERE 
    Year IN (2010, 2011, 2012, 2013, 2014, 2015, 2016)
	and Entity = 'Brazil'
GROUP BY 
    Year
ORDER BY 
	YEAR DESC

	-- 

SELECT AVG(Deaths_Neoplasms_sex_both_age_5_14_years_number) AS AverageDeaths
FROM  [mortes por câncer por idade2]
WHERE Year IN (2010, 2011, 2012, 2013, 2014, 2015, 2016)
  AND Deaths_Neoplasms_sex_both_age_5_14_years_number IS NOT NULL
  AND Deaths_Neoplasms_sex_both_age_5_14_years_number BETWEEN 5 AND 14;


--- Concatenação para uma nova coluna

select * from [mortes por câncer por idade]
select * from [mortes por câncer por tipo agrupadas]
select * from [número de pessoas com câncer por idade]
select * from [parcela da população com câncer2]
select * from [parcela da população com câncer por idade]
select * from [taxas de mortalidade por câncer por idade]
select * from [taxas de sobrevivência de cinco anos por tipo de câncer2]


SELECT Entity, Year, CONCAT(MAX(code), MAX(year)) AS coluna_relacional,
       MAX(Deaths_Neoplasms_Sex_Both_Age_Under_5_Number) AS ate_4_anos,
       MAX(Deaths_Neoplasms_Sex_Both_Age_5_14_years_Number) AS entre_5_e_14_anos,
       MAX(Deaths_Neoplasms_Sex_Both_Age_15_49_years_Number) AS entre_15_e_49_anos,
       MAX(Deaths_Neoplasms_Sex_Both_Age_50_69_years_Number) AS entre_50_e_69_anos,
       MAX(Deaths_Neoplasms_Sex_Both_Age_70_years_Number) AS mais_70_anos
FROM [mortes por câncer por idade]
WHERE Year IN (2010, 2011, 2012, 2013, 2014, 2015, 2016) AND Entity = 'Brazil'
GROUP BY Entity, Year


-- criaçao da coluna para relacionar os dados:

ALTER TABLE [número de pessoas com câncer por idade]
ADD coluna_relacional VARCHAR(50);

UPDATE [número de pessoas com câncer por idade]
SET coluna_relacional = CONCAT(code,year);

ALTER TABLE [número de pessoas com câncer por idade]
DROP COLUMN coluna_relacional;

ALTER TABLE [mortes por câncer por idade]
ADD coluna_relacional VARCHAR(50);

UPDATE [mortes por câncer por idade]
SET coluna_relacional = CONCAT(code,year);


ALTER TABLE [mortes por câncer por tipo agrupadas]
ADD coluna_relacional VARCHAR(50);

UPDATE [mortes por câncer por tipo agrupadas]
SET coluna_relacional = CONCAT(code,year);


ALTER TABLE [parcela da população com câncer]
ADD coluna_relacional VARCHAR(50);

UPDATE [parcela da população com câncer]
SET coluna_relacional = CONCAT(code,year);


ALTER TABLE  [parcela da população com câncer por idade]
ADD coluna_relacional VARCHAR(50);

UPDATE  [parcela da população com câncer por idade]
SET coluna_relacional = CONCAT(code,year);

ALTER TABLE [taxas de mortalidade por câncer por idade]
ADD coluna_relacional VARCHAR(50);

UPDATE  [taxas de mortalidade por câncer por idade]
SET coluna_relacional = CONCAT(code,year);

ALTER TABLE [taxas de sobrevivência de cinco anos por tipo de câncer]
ADD coluna_relacional VARCHAR(50);

UPDATE  [taxas de sobrevivência de cinco anos por tipo de câncer]
SET coluna_relacional = CONCAT(code,year);



-- Atualize os valores nas novas colunas com base nas condições especificadas

DELETE FROM [número de pessoas com câncer por idade]
WHERE 
    Year NOT IN (2010, 2011, 2012, 2013, 2014, 2015, 2016) OR
    Entity <> 'Brazil';

DELETE FROM [mortes por câncer por idade]
WHERE 
    Year NOT IN (2010, 2011, 2012, 2013, 2014, 2015, 2016) OR
    Entity <> 'Brazil';

DELETE FROM [mortes por câncer por tipo agrupadas]
WHERE 
    Year NOT IN (2010, 2011, 2012, 2013, 2014, 2015, 2016) OR
    Entity <> 'Brazil';

DELETE FROM [parcela da população com câncer por idade]
WHERE 
    Year NOT IN (2010, 2011, 2012, 2013, 2014, 2015, 2016) OR
    Entity <> 'Brazil';

DELETE FROM [taxas de mortalidade por câncer por idade]
WHERE 
    Year NOT IN (2010, 2011, 2012, 2013, 2014, 2015, 2016) OR
    Entity <> 'Brazil';


DELETE FROM [taxas de sobrevivência de cinco anos por tipo de câncer]
WHERE 
    Year NOT IN (2010, 2011, 2012, 2013, 2014, 2015, 2016) OR
    Entity <> 'Brazil';

---------
SELECT
    t.Entity,
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS CONTAGEM
FROM
    [parcela da população com câncer2] as t
GROUP BY
    t.Entity, t.Code;


ALTER TABLE [parcela da população com câncer2]
ADD coluna_relacional VARCHAR(50);

SET SESSION sql_mode = '';
SET @row_number = 0;

WITH ContagemLinhas AS (
    SELECT 
        code,
        year,
        ROW_NUMBER() OVER (ORDER BY code, year) AS row_num
    FROM [parcela da população com câncer2]
)
UPDATE p
SET coluna_relacional = CONCAT(p.code, CAST(p.year AS CHAR), CAST(cl.row_num AS CHAR))
FROM [parcela da população com câncer2] p
JOIN ContagemLinhas cl ON p.code = cl.code AND p.year = cl.year;


----

select * from [mortes por câncer por idade2]

ALTER TABLE [mortes por câncer por idade2]
ADD coluna_relacional VARCHAR(50);

WITH ContagemLinhas AS (
    SELECT 
        code,
        year,
        ROW_NUMBER() OVER (ORDER BY code, year) AS row_num
    FROM [mortes por câncer por idade2]
)
UPDATE p
SET coluna_relacional = CONCAT(p.code, CAST(p.year AS CHAR), CAST(cl.row_num AS CHAR))
FROM [mortes por câncer por idade2] p
JOIN ContagemLinhas cl ON p.code = cl.code AND p.year = cl.year;

DELETE FROM [taxas de sobrevivência de cinco anos por tipo de câncer2]
WHERE 
    Year NOT IN (2010, 2011, 2012, 2013, 2014, 2015, 2016)


SELECT 
    Year,
    CONCAT(
        CAST(
            (SUM(COALESCE(CAST(Breast AS DECIMAL(18, 2)), 0)) +
             SUM(COALESCE(CAST(Cervix AS DECIMAL(18, 2)), 0)) +
             SUM(COALESCE(CAST(Colon AS DECIMAL(18, 2)), 0)) +
             SUM(COALESCE(CAST(Leukaemia AS DECIMAL(18, 2)), 0)) +
             SUM(COALESCE(CAST(Liver AS DECIMAL(18, 2)), 0)) +
             SUM(COALESCE(CAST(Lung AS DECIMAL(18, 2)), 0)) +
             SUM(COALESCE(CAST(Ovary AS DECIMAL(18, 2)), 0)) +
             SUM(COALESCE(CAST(Prostate AS DECIMAL(18, 2)), 0)) +
             SUM(COALESCE(CAST(Rectum AS DECIMAL(18, 2)), 0)) +
             SUM(COALESCE(CAST(Stomach AS DECIMAL(18, 2)), 0))) 
        AS DECIMAL(18, 2)),
        '%'
    )
FROM 
    [taxas de sobrevivência de cinco anos por tipo de câncer2]
WHERE 
    Year IN (2010, 2011, 2012, 2013, 2014, 2015, 2016)
GROUP BY 
    Year
ORDER BY 
    Year DESC;

UPDATE  [taxas de sobrevivência de cinco anos por tipo de câncer2]
SET
Breast = CONCAT(CAST((COALESCE(CAST(Breast AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Breast AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')

UPDATE  [taxas de sobrevivência de cinco anos por tipo de câncer2]
SET Cervix = CONCAT(CAST((COALESCE(CAST(Cervix AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Cervix AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')

UPDATE  [taxas de sobrevivência de cinco anos por tipo de câncer2]
SET
Colon = CONCAT(CAST((COALESCE(CAST(Colon AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Colon AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')

UPDATE  [taxas de sobrevivência de cinco anos por tipo de câncer2]
SET
Leukaemia = CONCAT(CAST((COALESCE(CAST(Leukaemia AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Leukaemia AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')

UPDATE  [taxas de sobrevivência de cinco anos por tipo de câncer2]
SET
Liver = CONCAT(CAST((COALESCE(CAST(Liver AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Liver AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')

Lung = CONCAT(CAST((COALESCE(CAST(Lung AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Lung AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')

Ovary = CONCAT(CAST((COALESCE(CAST(Ovary AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Ovary AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')

Prostate = CONCAT(CAST((COALESCE(CAST(Prostate AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Prostate AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')

Rectum = CONCAT(CAST((COALESCE(CAST(Rectum AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Rectum AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')

Stomach = CONCAT(CAST((COALESCE(CAST(Stomach AS DECIMAL(18, 2)), 0) / NULLIF(SUM(COALESCE(CAST(Stomach AS DECIMAL(18, 2)), 0)), 0)) * 100 AS DECIMAL(18, 2)), '%')


UPDATE [taxas de sobrevivência de cinco anos por tipo de câncer2]
SET
    Colon = CONCAT(
        CAST(
            (COALESCE(CAST(Colon AS DECIMAL(18, 2)), 0) / NULLIF(
                (SELECT SUM(COALESCE(CAST(Colon AS DECIMAL(18, 2)), 0)) FROM [taxas de sobrevivência de cinco anos por tipo de câncer2]), 
                0
            )) * 100 
        AS DECIMAL(18, 2)), '%'
    );


UPDATE [parcela da população com câncer2]
SET Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent = CONCAT(CAST(Prevalence_Neoplasms_Sex_Both_Age_Age_standardized_Percent AS DECIMAL(18, 2)), '%');




    Stomach = CONCAT(
        CAST(
            (COALESCE(CAST(Stomach AS DECIMAL(18, 2)), 0) / NULLIF(
                (SELECT SUM(COALESCE(CAST(Stomach AS DECIMAL(18, 2)), 0)) FROM [taxas de sobrevivência de cinco anos por tipo de câncer2]), 
                0
            )) * 100 
        AS DECIMAL(18, 2)), '%'
    );

-------------

select * from [mortes por câncer por idade] as a
left join [parcela da população com câncer por idade] as b
on a.coluna_relacional = b.coluna_relacional
