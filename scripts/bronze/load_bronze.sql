USE Tokyo_Olympics;

GO 

CREATE OR ALTER PROCEDURE load_bronze AS

BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET @batch_start_time = GETDATE()
			SET @start_time = GETDATE()
				TRUNCATE TABLE bronze.athletes

				BULK INSERT bronze.athletes
				FROM 'C:\Users\brian\Downloads\SQL\TokyoOlympic\datasets\Athletes.csv'
				WITH (
					FORMAT='CSV',
					FIRSTROW = 2,
					CODEPAGE = '65001',
					FIELDTERMINATOR = ',', 
					ROWTERMINATOR = '\n', 
					TABLOCK
				);
				PRINT'>>>>>>>>> TABLE bronze.athletes INSERTION SUCCESSFULLY!!'

			SET @end_time = GETDATE()

			PRINT'bronze.athletes INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds'

			SET @start_time = GETDATE()

				TRUNCATE TABLE  bronze.coaches

				BULK INSERT bronze.coaches
				FROM 'C:\Users\brian\Downloads\SQL\TokyoOlympic\datasets\Coaches.csv'
				WITH(
					FORMAT='CSV',
					FIRSTROW = 2,
					CODEPAGE = '65001',
					FIELDTERMINATOR = ',', 
					ROWTERMINATOR = '\n', 
					TABLOCK
				);
				PRINT'>>>>>>>>> TABLE bronze.coaches INSERTION SUCCESSFULLY!!'

			
			SET @end_time = GETDATE()

			PRINT'bronze.coaches INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds'

			SET @start_time = GETDATE()

				TRUNCATE TABLE  bronze.gender

				BULK INSERT bronze.gender
				FROM 'C:\Users\brian\Downloads\SQL\TokyoOlympic\datasets\Gender.csv'
				WITH(
					FORMAT='CSV',
					FIRSTROW = 2,
					CODEPAGE = '65001',
					FIELDTERMINATOR = ',', 
					ROWTERMINATOR = '\n', 
					TABLOCK
				);
				PRINT'>>>>>>>>> TABLE bronze.gender INSERTION SUCCESSFULLY!!'

			SET @end_time = GETDATE()

			PRINT'bronze.gender INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds'

			SET @start_time = GETDATE()

				TRUNCATE TABLE  bronze.medals

				BULK INSERT bronze.medals
				FROM 'C:\Users\brian\Downloads\SQL\TokyoOlympic\datasets\Medals.csv'
				WITH(
					FORMAT='CSV',
					FIRSTROW = 2,
					CODEPAGE = '65001',
					FIELDTERMINATOR = ',', 
					ROWTERMINATOR = '\n', 
					TABLOCK
				);
				PRINT'>>>>>>>>> TABLE bronze.medals INSERTION SUCCESSFULLY!!'

			SET @end_time = GETDATE()

			PRINT'bronze.medals INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds'

			SET @start_time = GETDATE()

				TRUNCATE TABLE  bronze.teams

				BULK INSERT bronze.teams
				FROM 'C:\Users\brian\Downloads\SQL\TokyoOlympic\datasets\Teams.csv'
				WITH(
					FORMAT='CSV',
					FIRSTROW = 2,
					CODEPAGE = '65001',
					FIELDTERMINATOR = ',', 
					ROWTERMINATOR = '\n', 
					TABLOCK
				);
				PRINT'>>>>>>>>> TABLE bronze.teams INSERTION SUCCESSFULLY!!'

			SET @end_time = GETDATE()

			PRINT'bronze.teams INSERTION LOAD TIME: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)+ 'seconds';

		SET @batch_end_time = GETDATE()

		PRINT'TOTAL BRONZE LOAD TIME: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR)+ 'seconds';
	END TRY
	BEGIN CATCH
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR)
	END CATCH
END