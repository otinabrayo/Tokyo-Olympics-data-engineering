USE Tokyo_Olympics;

IF OBJECT_ID('silver.athletes', 'U') IS NOT NULL
	DROP TABLE silver.athletes

CREATE TABLE silver.athletes(
	person_name NVARCHAR(50),
	country NVARCHAR(50),
	discipline NVARCHAR(50)
);

PRINT'>>>>>>>>> TABLE silver.athletes SUCCESSFULLY CREATED '

IF OBJECT_ID('silver.coaches', 'U') IS NOT NULL
	DROP TABLE silver.coaches

CREATE TABLE silver.coaches(
	name_ NVARCHAR(50),
	country NVARCHAR(50),
	discipline NVARCHAR(50),
	event_ NVARCHAR(50)
);

PRINT'>>>>>>>>> TABLE silver.coaches SUCCESSFULLY CREATED'

IF OBJECT_ID('silver.gender', 'U') IS NOT NULL
	DROP TABLE silver.gender

CREATE TABLE silver.gender(
	discipline NVARCHAR(50),
	male INT,
	female INT,
	total INT
);

PRINT'>>>>>>>>> TABLE silver.gender SUCCESSFULLY CREATED'

IF OBJECT_ID('silver.medals', 'U') IS NOT NULL
	DROP TABLE silver.medals

CREATE TABLE silver.medals(
	rank_ INT,
	team_country NVARCHAR(50),
	gold INT,
	silver INT,
	bronze INT,
	total INT,
	rank_by_total INT
);

PRINT'>>>>>>>>> TABLE silver.medals SUCCESSFULLY CREATED'

IF OBJECT_ID('silver.teams', 'U') IS NOT NULL
	DROP TABLE silver.teams

CREATE TABLE silver.teams(
	team_name NVARCHAR(50),
	discipline NVARCHAR(50),
	country NVARCHAR(50),
	event_ NVARCHAR(50)
);

PRINT'>>>>>>>>> TABLE silver.teams SUCCESSFULLY CREATED'
