CREATE TABLE Students (
	user_id 		NUMBER 	REFERENCES Users(user_id)
							ON DELETE CASCADE
							PRIMARY KEY,
	institution VARCHAR2(1024),
	version 		VARCHAR2(1024),
	class 			VARCHAR2(1024),
	address  		VARCHAR2(1024)
);