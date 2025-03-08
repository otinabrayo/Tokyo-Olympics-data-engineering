/*
============   bronze.athletes QUALITY CHECKS   ===============
*/

--++++++ REMOVAL OF DUPLICATES +++++++++++--

SELECT 
*
FROM (
	SELECT DISTINCT person_name,
	COUNT(person_name) p
	FROM bronze.athletes
	GROUP BY person_name
)t
WHERE p > 1
ORDER BY p;  ---- person names appearing twice


SELECT
person_name,
country,
discipline
FROM bronze.athletes
WHERE person_name = 'ALVAREZ Jorge'; --- proof by single selecton


SELECT 
* 
FROM(
SELECT
ROW_NUMBER () OVER (PARTITION BY person_name, country, discipline ORDER BY person_name ) ranking,
person_name,
country,
discipline
FROM bronze.athletes) T
WHERE ranking = 1  ;         ---  selecting the first ranking showing 



  ----- name formatting correction 
GO
  
CREATE FUNCTION NameConverter(@name NVARCHAR(255))
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @result NVARCHAR(255) = '';
    DECLARE @i INT = 1;
    DECLARE @ch CHAR(1);
    DECLARE @prevCh CHAR(1) = ' ';

    WHILE @i <= LEN(@name)
    BEGIN
        SET @ch = SUBSTRING(@name, @i, 1);
        SET @result = @result + 
            CASE 
                WHEN @prevCh = ' ' THEN UPPER(@ch)
                ELSE LOWER(@ch)
            END;
        SET @prevCh = @ch;
        SET @i = @i + 1;
    END

    RETURN @result;
END;  ------- Function that will convert the names eg (AMAYA GAITAN Fabian to  Amaya Gaitan Fabian )

GO

-- Updating the bronze.athletes and bronze.coaches

UPDATE bronze.athletes
SET person_name = dbo.NameConverter(person_name);

UPDATE bronze.coaches
SET name_ = dbo.NameConverter(name_);



/*
============   bronze.coaches QUALITY CHECKS   ===============
*/


--++++++ REMOVAL OF DUPLICATES +++++++++++--

SELECT * FROM (
SELECT
ROW_NUMBER () OVER(PARTITION BY name_, country, discipline, event_ ORDER BY country) r,
name_,
country,
discipline,
event_
FROM bronze.coaches
)t
WHERE r != 1;   

SELECT 
* 
FROM bronze.coaches 
WHERE name_ = 'Guerrero Rolando'; -- reverse proof this was a duplicate


SELECT
name_,
CASE
	WHEN country LIKE '%voire%' THEN 'Ivory Coast'  -- removal of bad characters
	ELSE country
END country,
TRIM(discipline) discipline,
CASE
	WHEN event_ IS NULL THEN 'Unknown'  -- removal of bad characters
	ELSE event_
END event_
FROM bronze.coaches;


/*
============   bronze.gender QUALITY CHECKS   ===============
*/


SELECT
TRIM(discipline) discipline,
male,
female,
CASE 
	WHEN total != (male + female)  THEN  (male + female) 
	ELSE total
END total -- calculation confirmation of the total 
FROM bronze.gender;


/*
============  bronze.medals QUALITY CHECKS   ===============
*/


SELECT
rank_,
TRIM(team_country) team_country,
gold,
silver,
bronze,
CASE 
	WHEN total != (gold + silver + bronze)  THEN  (gold + silver + bronze)
	ELSE total
END total,       -- calculation confirmation of the total medals
RANK() OVER(ORDER BY total DESC) new_total_rank  --- new rank based on new total 
FROM bronze.medals;

/*
============  bronze.teams QUALITY CHECKS   ===============
*/

--++++++ REMOVAL OF DUPLICATES +++++++++++--

SELECT 
* 
FROM
(
SELECT 
ROW_NUMBER () OVER(PARTITION BY team_name, discipline, country, event_ ORDER BY country) R,
team_name,
discipline,
country,
event_
FROM bronze.teams
) t
WHERE R != 1;