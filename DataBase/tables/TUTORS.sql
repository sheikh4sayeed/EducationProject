CREATE TABLE Tutors (
	user_id 						NUMBER 	REFERENCES Users(user_id)
											ON DELETE CASCADE
											PRIMARY KEY,
	expertise						VARCHAR2(1024),
	availability 				VARCHAR2(100),
	years_of_experience NUMBER,
	preffered_salary 		NUMBER
);