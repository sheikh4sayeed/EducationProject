CREATE TABLE Notices (
	notice_id 			NUMBER PRIMARY KEY,
	admin_id				NUMBER NOT NULL,
	coaching_id			NUMBER NOT NULL,
	class        		VARCHAR2(100) NOT NULL,
	subject					VARCHAR2(100) NOT NULL,
	batch_id    		NUMBER NOT NULL,
	text 						VARCHAR2(1024) NOT NULL,
	timestamp 			DATE DEFAULT SYSDATE
);