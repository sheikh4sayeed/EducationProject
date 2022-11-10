CREATE OR REPLACE PROCEDURE CANCEL_JOIN_NOTIFICATION(
	c_coaching_id Coachings.coaching_id%TYPE,
	s_student_id 	Students.user_id%TYPE
)
AS
	t_id   	Tutors.user_id%TYPE;
BEGIN
	SELECT user_id INTO t_id
	FROM MemberOf NATURAL JOIN Tutors
	WHERE coaching_id = c_coaching_id;
	
	DELETE FROM Notifications
	WHERE type = 'JOIN' AND action = 'REQUEST' AND sender_id = s_student_id AND user_id = t_id;
END;
/

CREATE OR REPLACE PROCEDURE DECLINE_JOIN_NOTIFICATION(
	c_coaching_id Coachings.coaching_id%TYPE,
	s_student_id 	Students.user_id%TYPE
)
AS
	c_name 	Coachings.name%TYPE;
	c_image Coachings.image%TYPE;
BEGIN
	SELECT name,image INTO c_name,c_image
	FROM Coachings WHERE coaching_id = c_coaching_id;
		
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('JOIN','DECLINE',c_coaching_id,c_coaching_id,s_student_id,c_image,c_name||' has declined your join request','/home/oachings?id='||c_coaching_id);
END;
/


CREATE OR REPLACE PROCEDURE DECLINE_ENROLL_NOTIFICATION(
	s_student_id 	Students.user_id%TYPE,
	b_batch_id 		Batches.batch_id%TYPE
)
AS
	c_name 			Coachings.name%TYPE;
	c_image 		Coachings.image%TYPE;
	c_class 		Courses.class%TYPE;
	c_subject 	Courses.subject%TYPE;
	c_id 			 	Coachings.coaching_id%TYPE;
	c_course_id	Courses.course_id%TYPE;
BEGIN
	SELECT name,image,class,subject,coaching_id,course_id INTO c_name,c_image,c_class,c_subject,c_id,c_course_id
	FROM Courses NATURAL JOIN Coachings NATURAL JOIN Batches
	WHERE batch_id = b_batch_id;
		
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('ENROLL','DECLINE',c_id,c_course_id,s_student_id,c_image,c_name||' has declined your enrollment in '||c_subject||', '||c_class||', '||c_name,'/my_courses');
END;
/

CREATE OR REPLACE PROCEDURE APPROVE_JOIN_NOTIFICATION(
	c_coaching_id Coachings.coaching_id%TYPE,
	s_student_id 	Students.user_id%TYPE
)
AS
	c_name 	Coachings.name%TYPE;
	c_image Coachings.image%TYPE;
	t_id   	Tutors.user_id%TYPE;
BEGIN
	SELECT name,image INTO c_name,c_image
	FROM Coachings WHERE coaching_id = c_coaching_id;
	
	SELECT user_id INTO t_id
	FROM MemberOf NATURAL JOIN Tutors
	WHERE coaching_id = c_coaching_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('JOIN','APPROVE',c_coaching_id,c_coaching_id,s_student_id,c_image,c_name||' has approved your join request','/my_coachings?id='||c_coaching_id);
	
	
	DELETE FROM Notifications
	WHERE type = 'JOIN' AND action = 'REQUEST' AND sender_id = s_student_id AND user_id = t_id;
END;
/


CREATE OR REPLACE PROCEDURE SEEN_NOTIFICATIONS(
	u_user_id		Users.user_id%TYPE
)
AS
BEGIN
	UPDATE Notifications
	SET seen = 'YES'
	WHERE user_id = u_user_id;
END;
/
