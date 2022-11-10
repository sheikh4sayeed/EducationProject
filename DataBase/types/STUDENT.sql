CREATE OR REPLACE	TYPE STUDENT AS	OBJECT (
	user_id				NUMBER,
  name 					VARCHAR2(100),
  image 				VARCHAR2(1000),
  gender 				VARCHAR2(10),
  phone_number 	VARCHAR2(15),
  date_of_birth VARCHAR2(100),
	institution 	VARCHAR2(1024),
	version 			VARCHAR2(1024),
	class 				VARCHAR2(1024),
	address  			VARCHAR2(1024)
);
/
CREATE OR REPLACE TYPE STUDENT_ARRAY AS TABLE OF STUDENT;
/