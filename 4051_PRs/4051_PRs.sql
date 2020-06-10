CREATE SCHEMA `4051_PRs` ;
USE `4051_PRs`;
CREATE TABLE interactive_viz(
	pr_number INT,
	pr_creator VARCHAR(20),
	pr_created_ts VARCHAR(25),
	pr_title VARCHAR(20),
	pr_message VARCHAR(50));

CREATE TABLE social_network_analysis(
	pr_number INT,
	pr_creator VARCHAR(20),
	pr_created_ts VARCHAR(25),
	pr_title VARCHAR(20),
	pr_message VARCHAR(50));

LOAD DATA LOCAL INFILE 'C:/Users/timlx/Google Drive/TC Stuff/Analytics/HUDK 5053 - Feature Engineering Studio/HUDK5053-SQL-projects/4051_PRs/interactive_viz.csv' 
	INTO TABLE interactive_viz
	FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
LOAD DATA LOCAL INFILE 'C:/Users/timlx/Google Drive/TC Stuff/Analytics/HUDK 5053 - Feature Engineering Studio/HUDK5053-SQL-projects/4051_PRs/social_network_analysis.csv' 
	INTO TABLE social_network_analysis
	FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
DELETE FROM social_network_analysis
WHERE pr_number = 0;

DELETE FROM interactive_viz
WHERE pr_number = 0;

SELECT iv.pr_number, iv.pr_creator AS iv_pr_creator, iv.pr_created_ts AS iv_pr_created_ts, sna.pr_creator AS sna_pr_creator, sna.pr_created_ts AS sna_pr_created_ts
FROM interactive_viz AS iv
INNER JOIN social_network_analysis AS sna
ON iv.pr_number = sna.pr_number;