CREATE TABLE Educations (
	eq_id 					NUMBER PRIMARY KEY,
	tutor_id 				NUMBER 	REFERENCES Tutors(user_id)
									ON DELETE CASCADE,
	institute 			VARCHAR2(100),
	field_of_study 	VARCHAR2(100),
	degree					VARCHAR2(100),
	passing_year		NUMBER
);