CREATE TABLE Materials (
	material_id 		NUMBER PRIMARY KEY,
	material_type 	VARCHAR2(100),
	description			VARCHAR2(1024),
	link        		VARCHAR2(100) NOT NULL,
	tutor_id				NUMBER REFERENCES Tutors(user_id)
									ON DELETE CASCADE,
	timestamp 			DATE DEFAULT SYSDATE
);