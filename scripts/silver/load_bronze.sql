USE Tokyo_Olympics;

GO

CREATE OR ALTER PROCEDURE load_bronze AS

BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET @batch_start_time = GETDATE()
			SET @start_time = GETDATE()
				TRUNCATE TABLE silver.athletes

				INSERT INTO silver.athletes (
				person_name, 
				country, 
				discipline 
				)
				SELECT 
				person_name, 
				country, 
				discipline 
				FROM(
					SELECT
					ROW_NUMBER () OVER (PARTITION BY person_name, country, discipline ORDER BY person_name ) ranking,
					TRIM(person_name) person_name,
					TRIM(country) country,
					TRIM(discipline) discipline
					FROM bronze.athletes) T
					WHERE ranking = 1;

				PRINT'>>>>>>>>> TABLE silver.athletes INSERTED SUCCESSFULLY'

			SET @end_time = GETDATE()

			PRINT'silver.athletes INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds'

			SET @start_time = GETDATE()

				TRUNCATE TABLE silver.coaches

				INSERT INTO silver.coaches (
				name_, 
				country, 
				discipline,
				event_
				)
					SELECT 
					name_, 
					country, 
					discipline,
					event_
					FROM (
						SELECT
						ROW_NUMBER () OVER(PARTITION BY name_, country, discipline, event_ ORDER BY country) r,
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
						FROM bronze.coaches
						)t
						WHERE r = 1;   

				PRINT'>>>>>>>>> TABLE silver.coaches INSERTED SUCCESSFULLY'

			SET @end_time = GETDATE()

			PRINT'silver.coaches INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds'

			SET @start_time = GETDATE()

				TRUNCATE TABLE silver.gender

				INSERT INTO silver.gender (
				discipline,
				male,
				female,
				total
				)
					SELECT
					TRIM(discipline) discipline,
					male,
					female,
					CASE 
						WHEN total != (male + female)  THEN  (male + female) 
						ELSE total
					END total -- calculation confirmation of the total 
					FROM bronze.gender

				PRINT'>>>>>>>>> TABLE silver.gender INSERTED SUCCESSFULLY'

			SET @end_time = GETDATE()

			PRINT'silver.gender INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds'

			SET @start_time = GETDATE()


				TRUNCATE TABLE silver.medals

				INSERT INTO silver.medals (
				rank_,
				team_country,
				gold,
				silver,
				bronze,
				total,
				rank_by_total
				)
					SELECT
					rank_,
					TRIM(team_country) team_country,
					gold,
					silver,
					bronze,
					CASE 
						WHEN total != (gold + silver + bronze)  THEN  (gold + silver + bronze)
						ELSE total
					END total,      -- calculation confirmation of the total medals
					RANK() OVER(ORDER BY total DESC) new_total_rank  --- new rank based on new total 
					FROM bronze.medals;

				PRINT'>>>>>>>>> TABLE silver.medals INSERTED SUCCESSFULLY'

			SET @end_time = GETDATE()

			PRINT'silver.medals INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds'

			SET @start_time = GETDATE()


				TRUNCATE TABLE silver.teams

				INSERT INTO silver.teams (
				team_name,
				discipline,
				country,
				event_
				)
					SELECT 
					team_name,
					discipline,
					country,
					event_
					FROM
					(
					SELECT 
						ROW_NUMBER () OVER(PARTITION BY team_name, discipline, country, event_ ORDER BY country) ranks,
						team_name,
						discipline,
						country,
						event_
						FROM bronze.teams
						) ranks
						WHERE ranks = 1;

				PRINT'>>>>>>>>> TABLE silver.teams INSERTED SUCCESSFULLY'

			SET @end_time = GETDATE()

			PRINT'silver.teams INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds'

		SET @batch_end_time = GETDATE()

		PRINT'TOTAL SILVER LOAD TIME: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR)+ 'seconds';
	END TRY
	BEGIN CATCH
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR)
	END CATCH
END			