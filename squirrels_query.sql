USE squirrel_nyc;
CREATE TABLE nyc_squirrels(
	X FLOAT,
	Y FLOAT,
	`Unique Squirrel ID` VARCHAR(15) PRIMARY KEY,
	Hectare VARCHAR(3),
	Shift VARCHAR(2),
	`Date` INT,
	`Hectare Squirrel Number` INT,
	`Age` VARCHAR(10),
	`Primary Fur Color` VARCHAR(15),
	`Highlight Fur Color` VARCHAR(15),
	`Combination of Primary and Highlight Color` VARCHAR(50),
	`Color notes` VARCHAR(70),
	Location VARCHAR(70),
	`Above Ground Sighter Measurement` VARCHAR(10),
	`Specific Location` VARCHAR(70),
	Running VARCHAR(5), 
	Chasing VARCHAR(5), 
	Climbing VARCHAR(5), 
	Eating VARCHAR(5), 
	Foraging VARCHAR(5), 
	`Other Activities` VARCHAR(50),
	Kuks VARCHAR(5), 
	Quaas VARCHAR(5), 
	Moans VARCHAR(5), 
	`Tail flags` VARCHAR(5), 
	`Tail twitches` VARCHAR(5), 
	Approaches VARCHAR(5), 
	Indifferent VARCHAR(5), 
	`Runs from` VARCHAR(5), 
	`Other Interactions` VARCHAR(50),
	`Lat/Long` VARCHAR(50),
	`Zip Codes` INT,
	`Community Districts` INT,
	`Borough Boundaries` INT, 
	`City Council Districts` INT, 
	`Police Precincts` INT);

LOAD DATA LOCAL INFILE '<INSERT DIRECTORY>/2018_Central_Park_Squirrel_Census_-_Squirrel_Data.tsv' 
	INTO TABLE nyc_squirrels
	FIELDS TERMINATED BY '\t' 
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

CREATE TABLE col_behaviour AS
	SELECT `Unique Squirrel ID`, `Primary Fur Color`, `Highlight Fur Color`, Running, Chasing, Climbing, Eating, Foraging, Kuks, Quaas, Moans, `Tail flags`, `Tail twitches`, Approaches, Indifferent, `Runs from`,
		CASE WHEN (Running = 'false') THEN 0 ELSE 1 END AS Running_num,
		CASE WHEN (Chasing = 'false') THEN 0 ELSE 1 END AS Chasing_num,
		CASE WHEN (Climbing = 'false') THEN 0 ELSE 1 END AS Climbing_num,
		CASE WHEN (Eating = 'false') THEN 0 ELSE 1 END AS Eating_num,
		CASE WHEN (Foraging = 'false') THEN 0 ELSE 1 END AS Foraging_num,
		CASE WHEN (Kuks = 'false') THEN 0 ELSE 1 END AS Kuks_num,
		CASE WHEN (Quaas = 'false') THEN 0 ELSE 1 END AS Quaas_num,
		CASE WHEN (Moans = 'false') THEN 0 ELSE 1 END AS Moans_num,
		CASE WHEN (`Tail flags` = 'false') THEN 0 ELSE 1 END AS `Tail flags_num`,
		CASE WHEN (`Tail twitches` = 'false') THEN 0 ELSE 1 END AS `Tail twitches_num`,
		CASE WHEN (Approaches = 'false') THEN 0 ELSE 1 END AS Approaches_num,
		CASE WHEN (Indifferent = 'false') THEN 0 ELSE 1 END AS Indifferent_num,
		CASE WHEN (`Runs from` = 'false') THEN 0 ELSE 1 END AS `Runs from_num`
		FROM nyc_squirrels;

ALTER TABLE col_behaviour
	DROP COLUMN Running, 
	DROP COLUMN Chasing,
	DROP COLUMN Climbing,
	DROP COLUMN Eating,
	DROP COLUMN Foraging,
	DROP COLUMN Kuks,
	DROP COLUMN Quaas,
	DROP COLUMN Moans,
	DROP COLUMN `Tail flags`,
	DROP COLUMN `Tail twitches`,
	DROP COLUMN Approaches,
	DROP COLUMN Indifferent, 
	DROP COLUMN `Runs from`;
    
CREATE TABLE primary_col_behaviour_prop AS
SELECT 
	`Primary Fur Color`,
	SUM(Running_num)/COUNT(*) AS Runners, 
	SUM(Chasing_num)/COUNT(*) AS Chasers, 
    SUM(Climbing_num)/COUNT(*) AS Climbers,
    SUM(Eating_num)/COUNT(*) AS Eaters,
    SUM(Foraging_num)/COUNT(*) AS Foragers,
    SUM(Kuks_num)/COUNT(*) AS Kukkers,
    SUM(Quaas_num)/COUNT(*) AS Quaasers,
    SUM(Moans_num)/COUNT(*) AS Moaners,
    SUM(`Tail flags_num`)/COUNT(*) AS Tail_flaggers,
    SUM(`Tail twitches_num`)/COUNT(*) AS Tail_twitchers,
	SUM(Approaches_num)/COUNT(*) AS Approachers,
	SUM(Indifferent_num)/COUNT(*) AS Indifferent,
	SUM(`Runs from_num`)/COUNT(*) AS Fleers
	FROM col_behaviour
    GROUP BY `Primary Fur Color`;
    
CREATE TABLE secondary_col_behaviour_prop AS
SELECT 
	`Highlight Fur Color`,
	SUM(Running_num)/COUNT(*) AS Runners, 
	SUM(Chasing_num)/COUNT(*) AS Chasers, 
    SUM(Climbing_num)/COUNT(*) AS Climbers,
    SUM(Eating_num)/COUNT(*) AS Eaters,
    SUM(Foraging_num)/COUNT(*) AS Foragers,
    SUM(Kuks_num)/COUNT(*) AS Kukkers,
    SUM(Quaas_num)/COUNT(*) AS Quaasers,
    SUM(Moans_num)/COUNT(*) AS Moaners,
    SUM(`Tail flags_num`)/COUNT(*) AS Tail_flaggers,
    SUM(`Tail twitches_num`)/COUNT(*) AS Tail_twitchers,
	SUM(Approaches_num)/COUNT(*) AS Approachers,
	SUM(Indifferent_num)/COUNT(*) AS Indifferent,
	SUM(`Runs from_num`)/COUNT(*) AS Fleers
	FROM col_behaviour
    GROUP BY `Highlight Fur Color`;
    
SELECT * 
	FROM primary_col_behaviour_prop;
    
SELECT * 
	FROM secondary_col_behaviour_prop;