CREATE TABLE Coachings(
	coaching_id    	NUMBER PRIMARY KEY,
	image          	VARCHAR2(100) DEFAULT ON NULL 'coaching.png',
	name           	VARCHAR2(100) NOT NULL,
	address					VARCHAR2(1024) NOT NULL,
	phone_number 		VARCHAR2(15) NOT NULL
);
