CREATE OR REPLACE PROCEDURE CREATE_STUDENT(
	u_id 		Users.user_id%TYPE
)
IS
BEGIN
INSERT INTO Students (user_id) VALUES (u_id);
END;
/

CREATE OR REPLACE PROCEDURE CREATE_TUTOR(
	u_id 		Users.user_id%TYPE
)
IS
BEGIN
INSERT INTO Tutors (user_id) VALUES (u_id);
END;
/


CREATE OR REPLACE PROCEDURE CREATE_USER(
	user_name 	Users.name%TYPE,
	user_email	Users.email%TYPE,
	user_pass		Users.pass%TYPE,
	user_type		Users.role%TYPE
)
IS
BEGIN
	IF user_type = 'STUDENT' THEN
		INSERT INTO Users (name,email,pass,role,image) 
		VALUES (user_name,user_email,user_pass,user_type,'male_student.jpg');
	ELSE 
		INSERT INTO Users (name,email,pass,role,image) 
		VALUES (user_name,user_email,user_pass,user_type,'male_tutor.jpg');
	END IF;
END;
/

CREATE OR REPLACE FUNCTION CREATE_TUTION(
	t_subjects 			Tutions.subjects%TYPE,
	t_salary 				Tutions.salary%TYPE,
	t_days_per_week Tutions.days_per_week%TYPE,
	t_start_date		VARCHAR2,
	t_class_days 		Tutions.class_days%TYPE,
	t_start_time 		VARCHAR2,
	t_end_time 			VARCHAR2,
	t_type					Tutions.type%TYPE
)
return Tutions.tution_id%TYPE
AS 
t_id 	Tutions.tution_id%TYPE;
BEGIN
	INSERT INTO Tutions (subjects,salary,days_per_week,start_date,class_days,start_time,end_time,type)
	VALUES(t_subjects,t_salary,t_days_per_week,TO_DATE(t_start_date,'MM/DD/YYYY'),t_class_days,TO_DATE(t_start_time,'HH24:MI:SS'),TO_DATE(t_end_time,'HH24:MI:SS'),t_type)
	RETURNING tution_id 
	INTO t_id;
	return t_id;
END;
/

CREATE OR REPLACE PROCEDURE CREATE_COACHING(
	c_tutor_id			Tutors.user_id%TYPE,
	c_name					Coachings.name%TYPE,
	c_phone_number 	Coachings.phone_number%TYPE,
	c_address 			Coachings.address%TYPE
)
AS
c_id		Coachings.coaching_id%TYPE;
BEGIN
	INSERT INTO Coachings(name,phone_number,address)
	VALUES(c_name,c_phone_number,c_address)
	RETURNING coaching_id
	INTO c_id;
	MAKE_ADMIN(c_tutor_id, c_id);
END;
/

CREATE OR REPLACE PROCEDURE CREATE_BATCH(
	c_course_id		Courses.course_id%TYPE,
	b_start_date	VARCHAR2,
	b_seats				Batches.seats%TYPE,
	b_class_days	Batches.class_days%TYPE,
	b_start_time	VARCHAR2,
	b_end_time		VARCHAR2
)
AS
BEGIN
	INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
	VALUES(c_course_id,TO_DATE(b_start_date,'MM/DD/YYYY'),b_seats,b_class_days,TO_DATE(b_start_time,'HH24:MI:SS'),TO_DATE(b_end_time,'HH24:MI:SS'));
END;
/

CREATE OR REPLACE PROCEDURE CREATE_COURSE(
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE
)
AS
BEGIN
INSERT INTO Courses (coaching_id,class,subject)
VALUES(c_coaching_id,c_class,c_subject);
END;
/
