CREATE OR REPLACE TYPE SCHEDULE AS OBJECT (
	start_date 		VARCHAR2(100),
	class_days    VARCHAR2(100),
	start_time 		VARCHAR2(100),
	end_time			VARCHAR2(100),
	entity_id 		NUMBER,
	name					VARCHAR2(100),
	image 				VARCHAR2(100),
	subjects 			VARCHAR2(100)
);
/
 
CREATE OR REPLACE TYPE SCHEDULE_ARRAY AS TABLE OF SCHEDULE; -- Problem
/ 