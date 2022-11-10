-- BEGIN
-- 	EXECUTE IMMEDIATE 'DROP TABLE Rates';
-- EXCEPTION
-- 	WHEN others THEN
-- 		DBMS_OUTPUT.PUT_LINE('No such table');
-- END;
-- /
-- DROP TABLE Notices;
DROP TABLE RESET_PASS;
DROP TABLE Notices;
-- DROP TABLE Tutor_Notices;
-- DROP TABLE Coaching_Notices;
DROP TABLE EDUCATIONS;
-- DROP TABLE Rates;
DROP TABLE Materials;
DROP TABLE EnrolledIn;
DROP TABLE Batches;
DROP TABLE Courses;
DROP TABLE MemberOf;
DROP TABLE Coachings;
DROP TABLE Offers;
DROP TABLE Feedbacks;
DROP TABLE Applies;
DROP TABLE Tution_Posts;
DROP TABLE Tutions;
DROP TABLE Tutors;
DROP TABLE Students;
DROP TABLE Users;
DROP TABLE Classes;
DROP TABLE Mediums;

CREATE TABLE Classes (
	class_id			NUMBER PRIMARY KEY,
	class 				VARCHAR2(100) NOT NULL
);


CREATE TABLE Mediums (
	medium_id			NUMBER PRIMARY KEY,
	medium 				VARCHAR2(100) NOT NULL
);


CREATE TABLE Users (
  user_id 			NUMBER Primary Key,
  name 					VARCHAR2(100)  NOT NULL,
  image 				VARCHAR2(1000) DEFAULT ON NULL 'sample.jpg',
  email 				VARCHAR2(100)  NOT NULL UNIQUE,
  pass 					VARCHAR2(1024) NOT NULL,
  role 					VARCHAR2(1024) NOT NULL,
  gender 				VARCHAR2(10),
  phone_number 	VARCHAR2(15),
  date_of_birth DATE
);

CREATE TABLE Students (
	user_id 		NUMBER 	REFERENCES Users(user_id)
							ON DELETE CASCADE
							PRIMARY KEY,
	institution VARCHAR2(1024),
	version 		VARCHAR2(1024),
	class 			VARCHAR2(1024),
	address  		VARCHAR2(1024)
);

CREATE TABLE Tutors (
	user_id 						NUMBER 	REFERENCES Users(user_id)
											ON DELETE CASCADE
											PRIMARY KEY,
	expertise						VARCHAR2(1024),
	availability 				VARCHAR2(100),
	years_of_experience NUMBER,
	preffered_salary 		NUMBER
);

CREATE TABLE Tutions (
	tution_id 		NUMBER Primary Key,
	subjects 			VARCHAR2(1024) NOT NULL,
	salary 				NUMBER NOT NULL,
	days_per_week NUMBER,
	type 					VARCHAR2(100) NOT NULL,
	class_days		VARCHAR2(100),	
	start_time		DATE,	
	end_time			DATE,	
	start_date		DATE
);

CREATE TABLE Tution_Posts (
	post_id 							NUMBER Primary Key,
	student_id 						NUMBER REFERENCES Students(user_id)
												ON DELETE CASCADE,
	tution_id 						NUMBER REFERENCES Tutions(tution_id)
												ON DELETE CASCADE,
	timestamp 						DATE DEFAULT sysdate NOT NULL,
	desired_tutor_gender 	VARCHAR2(10) NOT NULL,
	booking_status 				VARCHAR2(10),
	selected_tutor 				NUMBER REFERENCES Tutors(user_id)
												ON DELETE SET NULL
);

CREATE TABLE Applies (
	tutor_id	NUMBER 	REFERENCES Tutors(user_id)
						ON DELETE CASCADE,
	post_id 	NUMBER 	REFERENCES Tution_Posts(post_id)
						ON DELETE CASCADE
);

CREATE TABLE Feedbacks (
	feedback_id 	NUMBER PRIMARY KEY,
	rating 				NUMBER,
	review				VARCHAR2(1024)
);


CREATE TABLE Offers (
	student_id 	NUMBER 	REFERENCES Students(user_id) 
							ON DELETE CASCADE,
	tutor_id 		NUMBER 	REFERENCES Tutors(user_id) 
							ON DELETE CASCADE,
	tution_id 	NUMBER 	REFERENCES Tutions(tution_id)
							ON DELETE SET NULL,
	status 			VARCHAR2(100) DEFAULT ON NULL 'PENDING',
	feedback_id REFERENCES Feedbacks(feedback_id),
	PRIMARY KEY(student_id,tutor_id,status)
);

CREATE TABLE Coachings(
	coaching_id    	NUMBER PRIMARY KEY,
	image          	VARCHAR2(100) DEFAULT ON NULL 'coaching.png',
	name           	VARCHAR2(100) NOT NULL,
	address					VARCHAR2(1024) NOT NULL,
	phone_number 		VARCHAR2(15) NOT NULL
);

--- Member: PENDING is equavalent to JOIN REQUEST
CREATE TABLE MemberOf(
	user_id        	NUMBER  REFERENCES Users(user_id)
									ON DELETE CASCADE,
	coaching_id    	NUMBER  REFERENCES Coachings(coaching_id)
									ON DELETE CASCADE,
	type           	VARCHAR2(100) DEFAULT ON NULL 'PENDING',
	PRIMARY KEY   	(user_id,coaching_id)
);

CREATE TABLE  Courses(
	course_id    	NUMBER  PRIMARY KEY,
	coaching_id  	NUMBER 	REFERENCES Coachings(coaching_id)
								ON DELETE CASCADE,
	class        	VARCHAR2(100) NOT NULL,
	subject				VARCHAR2(100) NOT NULL,
	UNIQUE (coaching_id,class,subject)
);


CREATE TABLE  Batches(
	batch_id    	NUMBER  PRIMARY KEY,
  course_id  		NUMBER 	REFERENCES Courses(course_id)
								ON DELETE CASCADE,
	start_date		DATE NOT NULL,
	seats					NUMBER NOT NULL,
	students			NUMBER DEFAULT 0,
	class_days		VARCHAR2(100) NOT NULL,	
	start_time		DATE,
	end_time 			DATE
);

CREATE TABLE  EnrolledIn(
	student_id    NUMBER 	REFERENCES Students(user_id)
								ON DELETE CASCADE,
	course_id   	NUMBER REFERENCES Courses(course_id)
								ON DELETE CASCADE,
	batch_id   	  NUMBER REFERENCES Batches(batch_id)
								ON DELETE CASCADE,
	status				VARCHAR2(100) DEFAULT ON NULL 'PENDING',
	PRIMARY KEY (student_id,course_id)
);

CREATE TABLE Educations (
	eq_id 					NUMBER PRIMARY KEY,
	tutor_id 				NUMBER 	REFERENCES Tutors(user_id)
									ON DELETE CASCADE,
	institute 			VARCHAR2(100),
	field_of_study 	VARCHAR2(100),
	degree					VARCHAR2(100),
	passing_year		NUMBER
);

DROP TABLE Notifications;
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

CREATE TABLE Materials (
	material_id 		NUMBER PRIMARY KEY,
	material_type 	VARCHAR2(100),
	description			VARCHAR2(1024),
	link        		VARCHAR2(100) NOT NULL,
	tutor_id				NUMBER REFERENCES Tutors(user_id)
									ON DELETE CASCADE,
	timestamp 			DATE DEFAULT SYSDATE
);

CREATE TABLE RESET_PASS (
	reset_id 				NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
	email 					VARCHAR2(100),
	token						VARCHAR2(1024)
);
-- CREATE TABLE Coaching_Notices (
-- 	notice_id 			NUMBER PRIMARY KEY,
-- 	coaching_id			NUMBER NOT NULL,
-- 	text 						VARCHAR2(1024) NOT NULL,
-- 	timestamp 			DATE DEFAULT SYSDATE
-- );



-- CREATE TABLE Tutor_Notices (
-- 	notice_id 			NUMBER PRIMARY KEY,
-- 	tutor_id				NUMBER NOT NULL,
-- 	text 						VARCHAR2(1024) NOT NULL,
-- 	timestamp 			DATE DEFAULT SYSDATE
-- );
