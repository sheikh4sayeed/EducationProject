CREATE OR REPLACE TYPE TUTION_POST AS OBJECT (
  gender 								VARCHAR2(10),
	version 							VARCHAR2(1024),
	class 								VARCHAR2(1024),
	address  							VARCHAR2(1024),
	post_id 							NUMBER,
	desired_tutor_gender 	VARCHAR2(20),
	subjects 							VARCHAR2(1024),
	salary 								NUMBER,
	days_per_week 				NUMBER,
	type 									VARCHAR2(100),
	timestamp 						VARCHAR2(100),
	applicant_count				NUMBER,
	booking_status 				VARCHAR2(100),
	selected_tutor				NUMBER
);
/
CREATE OR REPLACE TYPE TUTION_POST_ARRAY AS TABLE OF TUTION_POST;
/