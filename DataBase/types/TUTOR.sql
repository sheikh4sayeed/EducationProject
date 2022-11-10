CREATE OR REPLACE	TYPE TUTOR AS	OBJECT (
	user_id							NUMBER,
  name 								VARCHAR2(100),
  image 							VARCHAR2(1000),
  gender 							VARCHAR2(10),
  phone_number 				VARCHAR2(15),
  date_of_birth 			VARCHAR2(100),
	expertise						VARCHAR2(1024),
	availability 				VARCHAR2(100),
	years_of_experience NUMBER,
	preffered_salary 		NUMBER,
	rating							NUMBER
);
/
CREATE OR REPLACE TYPE TUTOR_ARRAY AS TABLE OF TUTOR;
/
