CREATE TABLE Notifications (
	notification_id NUMBER PRIMARY KEY,
	type						VARCHAR2(100),
	action					VARCHAR2(100),
	user_id					NUMBER NOT NULL,
	sender_id				NUMBER NOT NULL,
	entity_id 			NUMBER NOT NULL,
	image 					VARCHAR2(1000) NOT NULL,
	text 						VARCHAR2(1024) NOT NULL,
	url							VARCHAR2(100),
	timestamp 			DATE DEFAULT SYSDATE,
	seen						VARCHAR2(10) DEFAULT ON NULL 'NO'
);
