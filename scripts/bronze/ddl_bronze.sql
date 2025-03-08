USE Tokyo_Olympics;

IF OBJECT_ID('bronze.athletes', 'U') IS NOT NULL
	DROP TABLE bronze.athletes

CREATE TABLE bronze.athletes(
	person_name NVARCHAR(50),
	country NVARCHAR(50),
	discipline NVARCHAR(50)
);

PRINT'>>>>>>>>> TABLE bronze.athletes SUCCESSFULLY CREATED '

IF OBJECT_ID('bronze.coaches', 'U') IS NOT NULL
	DROP TABLE bronze.coaches

CREATE TABLE bronze.coaches(
	name_ NVARCHAR(50),
	country NVARCHAR(50),
	discipline NVARCHAR(50),
	event_ NVARCHAR(50)
);

PRINT'>>>>>>>>> TABLE bronze.coaches SUCCESSFULLY CREATED'

IF OBJECT_ID('bronze.gender', 'U') IS NOT NULL
	DROP TABLE bronze.gender

CREATE TABLE bronze.gender(
	discipline NVARCHAR(50),
	male INT,
	female INT,
	total INT
);

PRINT'>>>>>>>>> TABLE bronze.gender SUCCESSFULLY CREATED'

IF OBJECT_ID('bronze.medals', 'U') IS NOT NULL
	DROP TABLE bronze.medals

CREATE TABLE bronze.medals(
	rank_ INT,
	team_country NVARCHAR(50),
	gold INT,
	silver INT,
	bronze INT,
	total INT,
	rank_by_total INT
);

PRINT'>>>>>>>>> TABLE bronze.medals SUCCESSFULLY CREATED'

IF OBJECT_ID('bronze.teams', 'U') IS NOT NULL
	DROP TABLE bronze.teams

CREATE TABLE bronze.teams(
	team_name NVARCHAR(50),
	discipline NVARCHAR(50),
	country NVARCHAR(50),
	event_ NVARCHAR(50)
);

PRINT'>>>>>>>>> TABLE bronze.teams SUCCESSFULLY CREATED'
