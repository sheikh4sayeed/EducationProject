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
 
CREATE OR REPLACE PROCEDURE UPDATE_USER_PROFILE(
	u_id 						Users.user_id%TYPE,
	u_name 					Users.name%TYPE,
	u_phone_number 	Users.phone_number%TYPE,
	u_date_of_birth VARCHAR2,
	u_gender 				Users.gender%TYPE
)
IS
BEGIN
	UPDATE Users 
  SET name = u_name, phone_number = u_phone_number, date_of_birth = TO_DATE(u_date_of_birth,'MM/DD/YYYY'), gender = u_gender
  WHERE user_id = u_id;
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_STUDENT_PROFILE(
	u_id 						Users.user_id%TYPE,
	u_name 					Users.name%TYPE,
	u_phone_number 	Users.phone_number%TYPE,
	u_date_of_birth VARCHAR2,
	u_gender 				Users.gender%TYPE,
	s_institution		Students.institution%TYPE,
	s_version				Students.version%TYPE,
	s_class					Students.class%TYPE,
	s_address				Students.address%TYPE
)
IS
BEGIN
	UPDATE Students 
	SET institution = s_institution, version = s_version, class = s_class, address = s_address
	WHERE user_id = u_id;
	UPDATE_USER_PROFILE(u_id, u_name, u_phone_number, u_date_of_birth, u_gender);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_TUTOR_PROFILE(
	u_id 									Users.user_id%TYPE,
	u_name 								Users.name%TYPE,
	u_phone_number 				Users.phone_number%TYPE,
	u_date_of_birth 			VARCHAR2,
	u_gender 							Users.gender%TYPE,
	t_availability				Tutors.availability%TYPE,
	t_years_of_experience	Tutors.years_of_experience%TYPE,
	t_preffered_salary		Tutors.preffered_salary%TYPE,
	t_expertise						Tutors.expertise%TYPE
)
IS
BEGIN
	UPDATE Tutors 
	SET availability = t_availability, years_of_experience = t_years_of_experience, preffered_salary = t_preffered_salary, expertise = t_expertise
	WHERE user_id = u_id;
	UPDATE_USER_PROFILE(u_id, u_name, u_phone_number, u_date_of_birth, u_gender);
END;
/

-- CREATE OR REPLACE PROCEDURE CHANGE_PASSWORD(
-- 	id 	Users.user_id%TYPE
-- )
-- IS
-- BEGIN
-- INSERT INTO Users (name,email,pass,type) 
-- VALUES (user_name,user_email,user_pass,user_type);
-- END;
-- /

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

CREATE OR REPLACE PROCEDURE POST_TUTION(
	tp_student_id 						Tution_Posts.student_id%TYPE,
	tp_desired_tutor_gender 	Tution_Posts.desired_tutor_gender%TYPE,
	t_subjects 								Tutions.subjects%TYPE,
	t_salary 									Tutions.salary%TYPE,
	t_days_per_week 					Tutions.days_per_week%TYPE,
	t_type										Tutions.type%TYPE
)
AS
BEGIN
	INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender)
	VALUES(tp_student_id,CREATE_TUTION(t_subjects,t_salary,t_days_per_week,NULL,NULL,NULL,NULL,t_type),tp_desired_tutor_gender);
END;
/

CREATE OR REPLACE FUNCTION GET_TUTION_POST_DETAILS(
	tp_post_id	Tution_Posts.post_id%TYPE
)
return TUTION_POST
AS
tution_post_row TUTION_POST;
BEGIN
	FOR r IN (
		SELECT *
		FROM Tution_Posts NATURAL JOIN Tutions 
		JOIN Students ON student_id = user_id
		NATURAL JOIN Users
		WHERE post_id = tp_post_id
	)LOOP
		tution_post_row := TUTION_POST(
				r.gender,
				r.version,
				r.class,
				r.address,
				r.post_id, 
				r.desired_tutor_gender, 
				r.subjects, 
				r.salary,
				r.days_per_week,
				r.type,
				TO_CHAR(r.timestamp,'DD/MON/YYYY HH24:MI:SS'),
				0,
				r.booking_status,
				r.selected_tutor);
	END LOOP;
	SELECT COUNT(*) INTO tution_post_row.applicant_count
	FROM Applies
	WHERE post_id = tp_post_id;
	return tution_post_row;
END;
/

CREATE OR REPLACE PROCEDURE POST_NOTICE(
	n_admin_id		Notices.admin_id%TYPE,
	c_coaching_id Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE,
	b_batch_id		Batches.batch_id%TYPE,
	n_text  			Notices.text%TYPE
)
AS
BEGIN
	INSERT INTO Notices(admin_id,coaching_id,class,subject,batch_id,text)
	VALUES(n_admin_id,c_coaching_id,c_class,c_subject,b_batch_id,n_text);
END;
/


CREATE OR REPLACE FUNCTION IS_MEMBER_INCLUDED(
	s_student_id 	Students.user_id%TYPE,
	n_admin_id 		Notices.admin_id%TYPE,
	c_coaching_id Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
return VARCHAR2
AS
s_id Students.user_id%TYPE;
BEGIN
-- 	DBMS_OUTPUT.PUT_LINE(c_coaching_id||' '||c_class||' '||c_subject||' '||b_batch_id||' '||'YES');
-- Notice to only 
	SELECT student_id INTO s_id
	FROM EnrolledIn NATURAL JOIN Courses NATURAL JOIN Coachings NATURAL JOIN MemberOf
	WHERE type = 'ADMIN'
	AND user_id = n_admin_id
	AND (c_coaching_id = -1 OR coaching_id = c_coaching_id)
	AND (c_class = 'All' OR class = c_class)
	AND (c_subject = 'All' OR subject = c_subject)
	AND (b_batch_id = -1 OR batch_id = b_batch_id)
	AND student_id = s_student_id
	AND status = 'APPROVED';
	return 'YES';
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		return 'NO';
	WHEN TOO_MANY_ROWS THEN
		return 'YES';
END;
/

-- DROP PROCEDURE JOIN_REQUEST_NOTIFICATION;
-- CREATE OR REPLACE PROCEDURE JOIN_REQUEST_NOTIFICATION(
-- 	c_coaching_id Coachings.coaching_id%TYPE,
-- 	s_student_id 	Students.user_id%TYPE
-- )
-- AS
-- 	c_name 	Coachings.name%TYPE;
-- 	s_name 	Users.name%TYPE;
-- 	s_image Users.image%TYPE;
-- 	t_id   	Tutors.user_id%TYPE;
-- BEGIN
-- 	SELECT name INTO c_name
-- 	FROM Coachings WHERE coaching_id = c_coaching_id;
-- 	
-- 	SELECT name,image INTO s_name,s_image
-- 	FROM Users 
-- 	WHERE user_id = s_student_id;
-- 	
-- 	SELECT user_id INTO t_id
-- 	FROM MemberOf NATURAL JOIN Tutors
-- 	WHERE coaching_id = c_coaching_id;
-- 	
-- 	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
-- 	VALUES('JOIN','REQUEST',s_student_id,c_coaching_id,t_id,s_image,s_name||' has requested to join '||c_name,'/pending_requests?type=Join+Request&coaching='||c_coaching_id||'&id=
-- '||s_student_id);
-- 
-- 	DELETE FROM Notifications
-- 	WHERE type = 'JOIN' AND action = 'DECLINE' AND sender_id = c_coaching_id AND user_id = s_student_id;
-- END;
-- /

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

CREATE OR REPLACE FUNCTION GET_NOTICE_DETAILS(
	n_notice_id Notices.notice_id%TYPE
)
return NOTICE
AS 
	notice_row NOTICE := NOTICE(NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Notices NATURAL JOIN Coachings
		WHERE notice_id = n_notice_id
	)LOOP
		notice_row := NOTICE(
				r.name,
				r.image,
				r.class,
				r.subject,
				r.text,
				TO_CHAR(r.timestamp,'DD/MON/YYYY HH24:MI:SS')
		);
	END LOOP;
	return notice_row;
END;
/

-- CREATE OR REPLACE FUNCTION GET_SCHEDULE_DETAILS(
-- 	
-- )
-- return NOTICE
-- AS 
-- 	notice_row NOTICE := SCHEDULE(NULL,NULL,NULL,NULL);
-- BEGIN
-- 	FOR r IN (
-- 		SELECT * 	 	
-- 		FROM Notices NATURAL JOIN Coachings
-- 		WHERE notice_id = n_notice_id
-- 	)LOOP
-- 		notice_row := NOTICE(
-- 				r.name,
-- 				r.image,
-- 				r.class,
-- 				r.subject,
-- 				r.text,
-- 				TO_CHAR(r.timestamp,'DD/MON/YYYY HH24:MI:SS')
-- 		);
-- 	END LOOP;
-- 	return notice_row;
-- END;
-- /
-- 
CREATE OR REPLACE FUNCTION GET_MEMBER_NOTICES(
	s_student_id	Students.user_id%TYPE
)
return NOTICE_ARRAY
AS
notice_list NOTICE_ARRAY := NOTICE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Notices
		ORDER BY notice_id DESC
	)LOOP
	IF IS_MEMBER_INCLUDED(s_student_id,r.admin_id,r.coaching_id,r.class,r.subject,r.batch_id) = 'YES' THEN
		notice_list.EXTEND;
		notice_list(notice_list.LAST) := GET_NOTICE_DETAILS(r.notice_id);
	END IF;
	END LOOP;
	return notice_list;
END;
/

CREATE OR REPLACE FUNCTION GET_STUDENT_SCHEDULE(
	s_student_id	Students.user_id%TYPE
)
return SCHEDULE_ARRAY
AS
schedule_list SCHEDULE_ARRAY := SCHEDULE_ARRAY();
BEGIN
	FOR r IN (
		SELECT start_date, class_days, start_time, end_time, tutor_id as entity_id, name, image, subjects
		FROM Offers NATURAL JOIN Tutions 
		JOIN Users ON tutor_id = user_id
		WHERE student_id = s_student_id
		AND status = 'ACCEPTED'
		UNION
		SELECT start_date, class_days, start_time, end_time, -1 as entity_id, name, image, subject AS subjects
		FROM EnrolledIn 
		NATURAL JOIN Coachings
		NATURAL JOIN Courses
		NATURAL JOIN Batches 
		WHERE student_id = s_student_id
		AND status = 'APPROVED'
		ORDER BY start_time ASC
	)LOOP
	schedule_list.EXTEND;
	schedule_list(schedule_list.LAST) := SCHEDULE(TO_CHAR(r.start_date,'DD/MON/YYYY'),r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.entity_id, r.name,r.image,r.subjects);
	END LOOP;
	return schedule_list;
END;
/

CREATE OR REPLACE FUNCTION GET_STUDENT_ALL_SCHEDULE(
	s_student_id	Students.user_id%TYPE
)
return SCHEDULE_ARRAY
AS
schedule_list SCHEDULE_ARRAY := SCHEDULE_ARRAY();
BEGIN
	FOR r IN (
		SELECT start_date, class_days, start_time, end_time, tutor_id as entity_id, name, image, subjects
		FROM Offers NATURAL JOIN Tutions 
		JOIN Users ON tutor_id = user_id
		WHERE student_id = s_student_id
		AND (status <> 'CANCELLED' AND status <> 'REJECTED')
		UNION
		SELECT start_date, class_days, start_time, end_time, -1 as entity_id, name, image, subject AS subjects
		FROM EnrolledIn 
		NATURAL JOIN Coachings
		NATURAL JOIN Courses
		NATURAL JOIN Batches 
		WHERE student_id = s_student_id
		ORDER BY start_time ASC
	)LOOP
	schedule_list.EXTEND;
	schedule_list(schedule_list.LAST) := SCHEDULE(TO_CHAR(r.start_date,'DD/MON/YYYY'),r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.entity_id, r.name,r.image,r.subjects);
	END LOOP;
	return schedule_list;
END;
/

CREATE OR REPLACE FUNCTION GET_TUTOR_SCHEDULE(
	t_tutor_id	Tutors.user_id%TYPE
)
return SCHEDULE_ARRAY
AS
schedule_list SCHEDULE_ARRAY := SCHEDULE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers NATURAL JOIN Tutions 
		JOIN Users ON student_id = user_id
		WHERE tutor_id = t_tutor_id
		AND status = 'ACCEPTED'
		ORDER BY start_time ASC
	)LOOP
	schedule_list.EXTEND;
	schedule_list(schedule_list.LAST) := SCHEDULE(TO_CHAR(r.start_date,'DD/MON/YYYY'),r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.student_id, r.name,r.image,r.subjects);
	END LOOP;
	return schedule_list;
END;
/

CREATE OR REPLACE FUNCTION GET_TUTOR_ALL_SCHEDULE(
	t_tutor_id	Tutors.user_id%TYPE
)
return SCHEDULE_ARRAY
AS
schedule_list SCHEDULE_ARRAY := SCHEDULE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers NATURAL JOIN Tutions 
		JOIN Users ON student_id = user_id
		WHERE tutor_id = t_tutor_id
		AND status = 'ACCEPTED'
		ORDER BY start_time ASC
	)LOOP
	schedule_list.EXTEND;
	schedule_list(schedule_list.LAST) := SCHEDULE(TO_CHAR(r.start_date,'DD/MON/YYYY'),r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.student_id, r.name,r.image,r.subjects);
	END LOOP;
	return schedule_list;
END;
/

CREATE OR REPLACE FUNCTION GET_ADMIN_NOTICES(
	n_admin_id	Notices.admin_id%TYPE
)
return NOTICE_ARRAY
AS
notice_list NOTICE_ARRAY := NOTICE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Notices
		WHERE admin_id = n_admin_id
		ORDER BY notice_id DESC
	)LOOP
	notice_list.EXTEND;
	notice_list(notice_list.LAST) := GET_NOTICE_DETAILS(r.notice_id);
	END LOOP;
	return notice_list;
END;
/

CREATE OR REPLACE FUNCTION GET_NOTIFICATION_DETAILS(
	n_notification_id Notifications.notification_id%TYPE
)
return NOTIFICATION
AS 
	notification_row NOTIFICATION := NOTIFICATION(NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Notifications 
		WHERE notification_id = n_notification_id
	)LOOP
		notification_row := NOTIFICATION(
				r.image,
				r.text,
				r.url,
				TO_CHAR(r.timestamp,'DD/MON/YYYY HH24:MI:SS'),
				r.seen
		);
	END LOOP;
	return notification_row;
END;
/
CREATE OR REPLACE FUNCTION GET_NOTIFICATIONS(
	u_user_id		Users.user_id%TYPE
)
return NOTIFICATION_ARRAY
AS
notification_list NOTIFICATION_ARRAY := NOTIFICATION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Notifications
		WHERE user_id = u_user_id
		ORDER BY notification_id DESC
	)LOOP
	notification_list.EXTEND;
	notification_list(notification_list.LAST) := GET_NOTIFICATION_DETAILS(r.notification_id);
	END LOOP;
	return notification_list;
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


CREATE OR REPLACE FUNCTION IS_OFFER_EXISTS(
	t_tutor_id Tutors.user_id%TYPE,
	s_student_id	Students.user_id%TYPE
)
return VARCHAR2
AS
o_status Offers.status%TYPE;
BEGIN
	SELECT status INTO o_status
	FROM Offers 
	WHERE student_id = s_student_id
	AND tutor_id = t_tutor_id;
	return 'YES';
EXCEPTION
	WHEN OTHERS THEN
		return 'NO';
END;
/
CREATE OR REPLACE FUNCTION GET_ALL_TUTION_POSTS(
	t_tutor_id Tutors.user_id%TYPE
)
return TUTION_POST_ARRAY
AS
tution_post_list TUTION_POST_ARRAY := TUTION_POST_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Tution_Posts
		WHERE booking_status IS NULL OR booking_status = 'PENDING'
		ORDER BY post_id DESC
	)LOOP
		IF IS_OFFER_EXISTS(t_tutor_id,r.student_id) = 'NO' THEN
			tution_post_list.EXTEND;
			tution_post_list(tution_post_list.LAST) := GET_TUTION_POST_DETAILS(r.post_id);
		END IF;
	END LOOP;
	return tution_post_list;
END;
/

CREATE OR REPLACE FUNCTION GET_FILTERED_TUTION_POSTS(
	t_tutor_id 			Tutors.user_id%TYPE,
	u_gender				Users.gender%TYPE,
	t_start					Tutions.salary%TYPE,
	t_end						Tutions.salary%TYPE,
	t_days_per_week	Tutions.days_per_week%TYPE,
	s_version				Students.version%TYPE,
	t_type					Tutions.type%TYPE,
	s_class					Students.class%TYPE
)
return TUTION_POST_ARRAY
AS
tution_post_list TUTION_POST_ARRAY := TUTION_POST_ARRAY();
BEGIN
	FOR r IN (
		SELECT post_id,student_id
		FROM Tution_Posts Natural Join Tutions
		JOIN Students 
		ON student_id = user_id
		NATURAL JOIN Users
		WHERE salary >= t_start AND salary <= t_end
		AND days_per_week <= t_days_per_week
		AND (u_gender = 'Any' OR gender = u_gender)
		AND (s_version = 'Any' OR version = s_version)
		AND (t_type = 'Any' OR type = t_type)
		AND (s_class = 'Any' OR class = s_class)
		AND (booking_status IS NULL OR booking_status = 'PENDING')
		ORDER BY post_id DESC
	)LOOP
	IF IS_OFFER_EXISTS(t_tutor_id,r.student_id) = 'NO' THEN
		tution_post_list.EXTEND;
		tution_post_list(tution_post_list.LAST) := GET_TUTION_POST_DETAILS(r.post_id);
	END IF;
	END LOOP;
	return tution_post_list;
END;
/

CREATE OR REPLACE FUNCTION IS_APPLIED_FILTERED(
	t_tutor_id 			Tutors.user_id%TYPE,
	u_gender				Users.gender%TYPE,
	t_start					Tutions.salary%TYPE,
	t_end						Tutions.salary%TYPE,
	t_days_per_week	Tutions.days_per_week%TYPE,
	s_version				Students.version%TYPE,
	t_type					Tutions.type%TYPE,
	s_class					Students.class%TYPE
)
return STRING_ARRAY 
AS
apply_list STRING_ARRAY := STRING_ARRAY();
BEGIN	
	FOR r IN (
	SELECT tutor_id,student_id
	FROM Tution_Posts T
	Natural Join Tutions
	JOIN Students 
	ON student_id = user_id
	NATURAL JOIN Users
	LEFT OUTER JOIN Applies A
	ON A.post_id = T.post_id AND tutor_id = t_tutor_id
	WHERE salary >= t_start AND salary <= t_end
	AND days_per_week <= t_days_per_week
	AND (u_gender = 'Any' OR gender = u_gender)
	AND (s_version = 'Any' OR version = s_version)
	AND (t_type = 'Any' OR type = t_type)
	AND (s_class = 'Any' OR class = s_class)
	AND (booking_status IS NULL OR booking_status = 'PENDING')
	ORDER BY T.post_id DESC
	)LOOP
	IF IS_OFFER_EXISTS(t_tutor_id,r.student_id) = 'NO' THEN
		apply_list.EXTEND;
		IF r.tutor_id IS NULL  THEN
			apply_list(apply_list.LAST) := 'NO';
		ELSE 
			apply_list(apply_list.LAST) := 'YES';
		END IF;
	END IF;
	END LOOP;
	return apply_list;
END;
/

CREATE OR REPLACE FUNCTION IS_APPLIED(
	t_tutor_id Tutors.user_id%TYPE
)
return STRING_ARRAY 
AS
apply_list STRING_ARRAY := STRING_ARRAY();
BEGIN	
	FOR r IN (
	SELECT tutor_id,student_id
	FROM Tution_Posts T
	LEFT OUTER JOIN Applies A
	ON A.post_id = T.post_id AND tutor_id = t_tutor_id
	WHERE (booking_status IS NULL OR booking_status = 'PENDING')
	ORDER BY T.post_id DESC
	)LOOP
	IF IS_OFFER_EXISTS(t_tutor_id,r.student_id) = 'NO' THEN
		apply_list.EXTEND;
		IF r.tutor_id IS NULL  THEN
			apply_list(apply_list.LAST) := 'NO';
		ELSE 
			apply_list(apply_list.LAST) := 'YES';
		END IF;
	END IF;
	END LOOP;
	return apply_list;
END;
/

CREATE OR REPLACE FUNCTION IS_JOINED(
	s_student_id	Students.user_id%TYPE
)
return STRING_ARRAY 
AS
join_list STRING_ARRAY := STRING_ARRAY();
BEGIN	
	FOR r IN (
	SELECT user_id
	FROM Coachings C
	LEFT OUTER JOIN MemberOf M
	ON C.coaching_id = M.coaching_id AND user_id = s_student_id
	ORDER BY C.coaching_id ASC
	)LOOP
	join_list.EXTEND;
	IF r.user_id IS NULL  THEN
		join_list(join_list.LAST) := 'NO';
	ELSE 
		join_list(join_list.LAST) := 'YES';
	END IF;
	END LOOP;
	return join_list;
END;
/

CREATE OR REPLACE FUNCTION GET_MY_TUTION_POSTS(
	s_student_id	Students.user_id%TYPE
)
return TUTION_POST_ARRAY
AS
tution_post_list TUTION_POST_ARRAY := TUTION_POST_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Tution_Posts
		WHERE student_id = s_student_id
		ORDER BY post_id DESC
	)LOOP
		tution_post_list.EXTEND;
		tution_post_list(tution_post_list.LAST) := GET_TUTION_POST_DETAILS(r.post_id);
	END LOOP;
	return tution_post_list;
END;
/

CREATE OR REPLACE
FUNCTION GET_USER_BY_ID (id Users.user_id%TYPE)
RETURN Users%ROWTYPE 
AS
user_row Users%ROWTYPE;
BEGIN	
	SELECT * INTO user_row
	FROM Users WHERE user_id = id;
	return user_row;
EXCEPTION
 WHEN no_data_found THEN
    return NULL;
 WHEN too_many_rows THEN
    return NULL;
END;
/

CREATE OR REPLACE FUNCTION GET_USER_BY_EMAIL(email_address Users.email%TYPE)
return Users%ROWTYPE 
AS
user_row Users%ROWTYPE;
user_count NUMBER;
BEGIN	
	SELECT * INTO user_row
	FROM Users WHERE email = email_address;
	return user_row;
EXCEPTION
 WHEN no_data_found THEN
		RAISE_APPLICATION_ERROR(-20000,'Invalid credentials');
 WHEN too_many_rows THEN
		return NULL;
END;
/

CREATE OR REPLACE FUNCTION IS_EMAIL_TAKEN(email_address Users.email%TYPE)
return VARCHAR2 
AS
user_count NUMBER;
BEGIN	
	SELECT COUNT(*) INTO user_count
	FROM Users WHERE email = email_address;
	IF user_count = 0 THEN
		return 'NO';
	ELSE 
		return 'YES';
	END IF;
END;
/

CREATE OR REPLACE PROCEDURE MAKE_ADMIN(
	t_tutor_id			Tutors.user_id%TYPE,
	c_coaching_id		Coachings.coaching_id%TYPE
)
AS 
BEGIN
	INSERT INTO MemberOf
  VALUES(t_tutor_id,c_coaching_id,'ADMIN');
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
-- CREATE OR REPLACE FUNCTION IS_ALREADY_OFFERED(email_address Users.email%TYPE)
-- return VARCHAR2 
-- AS
-- user_count NUMBER;
-- BEGIN	
-- 	SELECT COUNT(*) INTO user_count
-- 	FROM Users WHERE email = email_address;
-- 	IF user_count = 0 THEN
-- 		return 'NO';
-- 	ELSE 
-- 		return 'YES';
-- 	END IF;
-- END;
-- /

CREATE OR REPLACE FUNCTION IS_VALID_USERID(id Users.user_id%TYPE)
return VARCHAR2 
AS
user_count NUMBER;
BEGIN	
	SELECT COUNT(*) INTO user_count
	FROM Users WHERE user_id = id;
	IF user_count = 0 THEN
		return 'NO';
	ELSE 
		return 'YES';
	END IF;
END;
/

-- DECLARE
-- 	TYPE user_list_type IS VARRAY(10) OF Users%ROWTYPE NOT NULL;
-- 	user_list		user_list_type();
-- BEGIN
	
CREATE OR REPLACE FUNCTION GET_STUDENT_DETAILS(
	s_student_id Students.user_id%TYPE
)
return STUDENT
AS 
	student_row STUDENT := STUDENT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Users NATURAL JOIN Students
		WHERE user_id = s_student_id
	)LOOP
		student_row := Student(
			r.user_id,
			r.name,
			r.image,
			r.gender,
			r.phone_number,
			TO_CHAR(r.date_of_birth,'MM/DD/YYYY'),
			r.institution,
			r.version,
			r.class,
			r.address
	);
	END LOOP;
	return student_row;
END;
/

CREATE OR REPLACE FUNCTION GET_ALL_STUDENTS
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Students
		ORDER BY user_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.user_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_MY_STUDENTS(
	t_tutor_id Tutors.user_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Offers 
		WHERE tutor_id = t_tutor_id AND status = 'ACCEPTED'
		ORDER BY student_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.student_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_PENDING_STUDENTS(
	t_tutor_id Tutors.user_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Offers 
		WHERE tutor_id = t_tutor_id 
		AND (status = 'PENDING' OR status = 'UPDATE')
		ORDER BY student_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.student_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_PENDING_TUTIONS(
	t_tutor_id Tutors.user_id%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers
		WHERE tutor_id = t_tutor_id 
		AND (status = 'PENDING' OR status = 'UPDATE')
		ORDER BY student_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_TUTION_DETAILS(t_tutor_id,r.student_id);
	END LOOP;
	return tution_list;
END;
/

CREATE OR REPLACE FUNCTION GET_COACHING_STUDENTS(
	c_coaching_id	Coachings.coaching_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT user_id 	 	
		FROM MemberOf
		WHERE coaching_id = c_coaching_id
		AND type = 'MEMBER'
		ORDER BY user_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.user_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_JOIN_REQUESTS(
	c_coaching_id	Coachings.coaching_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT user_id 	 	
		FROM MemberOf
		WHERE coaching_id = c_coaching_id
		AND type = 'PENDING'
		ORDER BY user_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.user_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_COURSE_STUDENTS(
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT student_id
    FROM EnrolledIn NATURAL JOIN Courses NATURAL JOIN Batches 
    WHERE coaching_id = c_coaching_id
    AND (c_class IS NULL OR class = c_class)
    AND (c_subject IS NULL OR subject = c_subject)
    AND (b_batch_id IS NULL OR batch_id = b_batch_id)
		AND status = 'APPROVED'
		ORDER BY student_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.student_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_PENDING_ENROLLMENTS(
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT student_id
    FROM EnrolledIn NATURAL JOIN Courses NATURAL JOIN Batches 
    WHERE coaching_id = c_coaching_id
    AND (c_class IS NULL OR class = c_class)
    AND (c_subject IS NULL OR subject = c_subject)
    AND (b_batch_id IS NULL OR batch_id = b_batch_id)
		AND status = 'PENDING'
		ORDER BY student_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.student_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_AVG_RATING(
	t_tutor_id Tutors.user_id%TYPE
)
return NUMBER
AS
	avg_rating		Feedbacks.rating%TYPE;
	total_rating 	Feedbacks.rating%TYPE;
	count					NUMBER;
BEGIN
	SELECT SUM(rating)/COUNT(*) INTO avg_rating
	FROM Offers NATURAL JOIN Feedbacks
	WHERE tutor_id = t_tutor_id AND rating IS NOT NULL
	GROUP BY tutor_id;
	return avg_rating;
EXCEPTION
	WHEN NO_DATA_FOUND THEN	
		return -1;
END;
/

CREATE OR REPLACE FUNCTION GET_TUTOR_DETAILS(
	t_tutor_id Tutors.user_id%TYPE
)
return TUTOR
AS 
	tutor_row TUTOR := TUTOR(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Users NATURAL JOIN Tutors
		WHERE user_id = t_tutor_id
	)LOOP
		tutor_row := TUTOR(
			r.user_id,
			r.name,
			r.image,
			r.gender,
			r.phone_number,
			TO_CHAR(r.date_of_birth,'MM/DD/YYYY'),
			r.expertise,
			r.availability,
			r.years_of_experience,
			r.preffered_salary,
			NULL
	);
	END LOOP;
	tutor_row.rating := GET_AVG_RATING(t_tutor_id);
	return tutor_row;
END;
/


CREATE OR REPLACE FUNCTION GET_ALL_TUTORS
return TUTOR_ARRAY
AS
	tutor_list TUTOR_ARRAY := TUTOR_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Tutors
		ORDER BY user_id ASC
	)LOOP
		tutor_list.EXTEND;
		tutor_list(tutor_list.LAST) := GET_TUTOR_DETAILS(r.user_id);
	END LOOP;
	return tutor_list;
END;	
/

-- CREATE OR REPLACE FUNCTION GET_ALL_EDUCATIONS
-- return EDUCATION_2D_ARRAY
-- AS
-- 	education_list 	EDUCATION_2D_ARRAY := EDUCATION_2D_ARRAY();
-- 	education		 		EDUCATION_ARRAY := EDUCATION_ARRAY();
-- BEGIN
-- -- 		education_list.EXTEND;
-- -- 		education := GET_EDUCATIONS(5);
-- -- 		education_list(education_list.LAST) := education;
-- 	FOR r IN (
-- 		SELECT * 	 	
-- 		FROM Tutors
-- 		ORDER BY user_id ASC
-- 	)LOOP	
-- 		education_list.EXTEND;
-- 		education_list(education_list.LAST) := GET_EDUCATIONS(r.user_id);
-- 	END LOOP;
-- 	return education_list;
-- END;	
-- /
-- 
CREATE OR REPLACE FUNCTION GET_FILTERED_TUTORS(
	u_gender			Users.gender%TYPE,
	t_start				Tutions.salary%TYPE,
	t_end					Tutions.salary%TYPE,
	t_status			Tutors.availability%TYPE,
	t_experience	Tutors.years_of_experience%TYPE
)
return TUTOR_ARRAY
AS
	tutor_list TUTOR_ARRAY := TUTOR_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Tutors NATURAL JOIN Users
		WHERE (u_gender = 'Any' OR gender = u_gender)
		AND	preffered_salary >= t_start AND preffered_salary <= t_end
		AND (t_status = 'Any' OR availability = t_status)
		AND years_of_experience >= t_experience
		ORDER BY user_id ASC
	)LOOP
		tutor_list.EXTEND;
		tutor_list(tutor_list.LAST) := GET_TUTOR_DETAILS(r.user_id);
	END LOOP;
	return tutor_list;
END;	
/

-- CREATE OR REPLACE FUNCTION GET_FILTERED_EDUCATIONS(
-- 	u_gender			Users.gender%TYPE,
-- 	t_start				Tutions.salary%TYPE,
-- 	t_end					Tutions.salary%TYPE,
-- 	t_status			Tutors.availability%TYPE,
-- 	t_experience	Tutors.years_of_experience%TYPE
-- )
-- return EDUCATION_2D_ARRAY
-- AS
-- 	education_list EDUCATION_2D_ARRAY := EDUCATION_2D_ARRAY();
-- BEGIN
-- 	FOR r IN (
-- 		SELECT * 	 	
-- 		FROM Tutors NATURAL JOIN Users
-- 		WHERE (u_gender = 'Any' OR gender = u_gender)
-- 		AND	preffered_salary >= t_start AND preffered_salary <= t_end
-- 		AND (t_status = 'Any' OR availability = t_status)
-- 		AND years_of_experience >= t_experience
-- 		ORDER BY user_id ASC
-- 	)LOOP
-- 		education_list.EXTEND;
-- 		education_list(education_list.LAST) := GET_EDUCATIONS(r.user_id);
-- 	END LOOP;
-- 	return education_list;
-- END;	
-- /
-- 
CREATE OR REPLACE FUNCTION GET_MY_TUTORS(
	s_student_id 	Students.user_id%TYPE
)
return TUTOR_ARRAY
AS
	tutor_list TUTOR_ARRAY := TUTOR_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Offers
		WHERE student_id = s_student_id AND status = 'ACCEPTED'
		ORDER BY tutor_id ASC
	)LOOP
		tutor_list.EXTEND;
		tutor_list(tutor_list.LAST) := GET_TUTOR_DETAILS(r.tutor_id);
	END LOOP;
	return tutor_list;
END;	
/



CREATE OR REPLACE FUNCTION GET_COACHING_DETAILS(
	c_coaching_id Coachings.coaching_id%TYPE
)
return COACHING
AS 
	coaching_row COACHING := COACHING(NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Coachings
		WHERE coaching_id = c_coaching_id
	)LOOP
		coaching_row := COACHING(
				r.coaching_id,
				r.image,
				r.name,
				r.address,
				r.phone_number,
				NULL
		);
	END LOOP;
	return coaching_row;
END;
/

CREATE OR REPLACE FUNCTION GET_ALL_COACHINGS(
	s_student_id	Students.user_id%TYPE
)
return COACHING_ARRAY
AS
	coaching_list COACHING_ARRAY := COACHING_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
    FROM Coachings
		ORDER BY coaching_id ASC
	)LOOP
		coaching_list.EXTEND;
		coaching_list(coaching_list.LAST) := GET_COACHING_DETAILS(r.coaching_id);
		FOR r2 IN(
			SELECT type
			FROM MemberOf
			WHERE user_id = s_student_id AND coaching_id = r.coaching_id
		)LOOP
			coaching_list(coaching_list.LAST).type := r2.type;
		END LOOP;
	END LOOP;
	return coaching_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_MY_COACHINGS(
	id	Users.user_id%TYPE
)
return COACHING_ARRAY
AS
	coaching_list COACHING_ARRAY := COACHING_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM MemberOf
		WHERE user_id = id AND (type = 'MEMBER'  OR type = 'ADMIN')
		ORDER BY coaching_id ASC
	)LOOP
		coaching_list.EXTEND;
		coaching_list(coaching_list.LAST) := GET_COACHING_DETAILS(r.coaching_id);
		coaching_list(coaching_list.LAST).type := r.type;
	END LOOP;
	return coaching_list;
END;	
/

CREATE OR REPLACE PROCEDURE JOIN_COACHING(
	u_user_id			Users.user_id%TYPE,
	c_coaching_id	Coachings.coaching_id%TYPE
) 
AS
BEGIN
	INSERT INTO MemberOf
  VALUES(u_user_id,c_coaching_id,'PENDING');
-- 	JOIN_REQUEST_NOTIFICATION(c_coaching_id,u_user_id);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_COACHING_INFO(
	c_coaching_id 	Coachings.coaching_id%TYPE,
	c_name					Coachings.name%TYPE,
	c_phone_number	Coachings.phone_number%TYPE,
	c_address				Coachings.address%TYPE
) 
AS
BEGIN
	UPDATE Coachings 
	SET name = c_name, phone_number = c_phone_number, address = c_address
	WHERE coaching_id = c_coaching_id;
END;
/
CREATE OR REPLACE FUNCTION GET_ALL_APPLICANTS(
	tp_post_id Tution_Posts.post_id%TYPE
)
return TUTOR_ARRAY
AS
	tutor_list TUTOR_ARRAY := TUTOR_ARRAY();
BEGIN
	FOR r IN (
		SELECT A.tutor_id 	 	
		FROM Tution_Posts T NATURAL JOIN APPLIES A
		LEFT OUTER JOIN Offers O
		ON T.student_id = O.student_id
		AND A.tutor_id 	= O.tutor_id
		WHERE (status <> 'ACCEPTED' OR status IS NULL)
		AND post_id = tp_post_id
		ORDER BY tutor_id ASC
	)LOOP
		tutor_list.EXTEND;
		tutor_list(tutor_list.LAST) := GET_TUTOR_DETAILS(r.tutor_id);
	END LOOP;
	return tutor_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_ACCEPTED_TUTION_DETAILS(
	t_tutor_id Tutors.user_id%TYPE,
	s_student_id Students.user_id%TYPE
)
return TUTION
AS
tution_row TUTION := TUTION(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers O NATURAL JOIN Tutions LEFT OUTER JOIN Feedbacks F
		ON O.feedback_id = F.feedback_id
		WHERE tutor_id = t_tutor_id
		AND student_id = s_student_id
	)LOOP
		IF r.status = 'ACCEPTED' THEN
			tution_row := TUTION(r.status, r.subjects, r.salary, r.days_per_week, r.type,r.rating,r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.review,TO_CHAR(r.start_date,'DD/MON/YYYY'));
		END IF;
	END LOOP;
	return tution_row;
END;
/

CREATE OR REPLACE FUNCTION GET_TUTION_DETAILS(
	t_tutor_id Tutors.user_id%TYPE,
	s_student_id Students.user_id%TYPE
)
return TUTION
AS
tution_row TUTION := TUTION(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers O NATURAL JOIN Tutions LEFT OUTER JOIN Feedbacks F
		ON O.feedback_id = F.feedback_id
		WHERE tutor_id = t_tutor_id
		AND student_id = s_student_id
	)LOOP
		IF r.status = 'UPDATE' THEN
			tution_row := TUTION(r.status, r.subjects, r.salary, r.days_per_week, r.type,r.rating,r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.review,TO_CHAR(r.start_date,'DD/MON/YYYY'));
		ELSIF tution_row.status IS NULL THEN
			tution_row := TUTION(r.status, r.subjects, r.salary, r.days_per_week, r.type,r.rating,r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.review,TO_CHAR(r.start_date,'DD/MON/YYYY'));
		END IF;
	END LOOP;
	return tution_row;
END;
/

CREATE OR REPLACE FUNCTION GET_EDUCATION_DETAILS(
	e_eq_id Educations.eq_id%TYPE
)
return EDUCATION
AS
education_row EDUCATION := EDUCATION(NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT *
		FROM Educations
		WHERE eq_id = e_eq_id
	)LOOP
		education_row := EDUCATION(r.eq_id, r.institute, r.field_of_study, r.degree, r.passing_year);
	END LOOP;
	return education_row;
END;
/

CREATE OR REPLACE FUNCTION GET_EDUCATIONS(
	t_tutor_id Tutors.user_id%TYPE
)
return EDUCATION_ARRAY
AS
	education_list EDUCATION_ARRAY := EDUCATION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Educations
		WHERE tutor_id = t_tutor_id
		ORDER BY passing_year DESC
	)LOOP
		education_list.EXTEND;
		education_list(education_list.LAST) := GET_EDUCATION_DETAILS(r.eq_id);
	END LOOP;
	return education_list;
END;
/

CREATE OR REPLACE PROCEDURE ADD_EDUCATION(
	t_tutor_id 	Tutors.user_id%TYPE,
	e_institute 	Educations.institute%TYPE,
	e_field_of_study 	Educations.field_of_study%TYPE,
	e_degree 	Educations.degree%TYPE,
	e_passing_year 	Educations.passing_year%TYPE
)
AS
BEGIN
INSERT INTO Educations(tutor_id,institute,field_of_study,degree,passing_year)
VALUES(t_tutor_id,e_institute,e_field_of_study,e_degree,e_passing_year);
END;
/
CREATE OR REPLACE PROCEDURE UPDATE_EDUCATION(
	e_eq_id						Educations.eq_id%TYPE,
	t_tutor_id 				Tutors.user_id%TYPE,
	e_institute 			Educations.institute%TYPE,
	e_field_of_study 	Educations.field_of_study%TYPE,
	e_degree 					Educations.degree%TYPE,
	e_passing_year 		Educations.passing_year%TYPE
)
AS
BEGIN
UPDATE Educations SET 
tutor_id = t_tutor_id,
institute = e_institute,
field_of_study = e_field_of_study,
degree = e_degree,
passing_year = e_passing_year
WHERE eq_id = e_eq_id;
END;
/
CREATE OR REPLACE PROCEDURE DELETE_EDUCATION(
	e_eq_id 	Educations.eq_id%TYPE
)
AS
BEGIN
DELETE FROM Educations
WHERE eq_id = e_eq_id;
END;
/
CREATE OR REPLACE FUNCTION GET_TUTION_DETAILS_FROM_POST(
	tp_post_id Tution_Posts.post_id%TYPE
)
return TUTION
AS
tution_row TUTION := TUTION(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT *
		FROM Tution_Posts NATURAL JOIN Tutions
		WHERE post_id = tp_post_id
	)LOOP
		tution_row := TUTION(NULL, r.subjects, r.salary, r.days_per_week, r.type,NULL,NULL,NULL,NULL,NULL,NULL);
	END LOOP;
	return tution_row;
END;
/


CREATE OR REPLACE FUNCTION GET_APPLICANTS_TUTION_DETAILS(
	tp_post_id Tution_Posts.post_id%TYPE,
	s_student_id Students.user_id%TYPE
)
return TUTION_ARRAY
AS
tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT A.tutor_id, O.status
		FROM Tution_Posts T NATURAL JOIN Applies A
		LEFT OUTER JOIN Offers O
		ON T.student_id = O.student_id 
		AND A.tutor_id = O.tutor_id
		WHERE (status <> 'ACCEPTED' OR status IS NULL)
		AND post_id = tp_post_id
		ORDER BY A.tutor_id ASC
	)LOOP
		tution_list.EXTEND;
		IF r.status IS NULL THEN
			tution_list(tution_list.LAST) := GET_TUTION_DETAILS_FROM_POST(tp_post_id);
		ELSE 
			tution_list(tution_list.LAST) := GET_TUTION_DETAILS(r.tutor_id,s_student_id);
		END IF;
	END LOOP;
	return tution_list;
END;
/

select * from user_errors;
/

CREATE OR REPLACE FUNCTION GET_ALL_TUTIONS(
	s_student_id Students.user_id%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Tutors
		ORDER BY user_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_TUTION_DETAILS(r.user_id,s_student_id);
	END LOOP;
	return tution_list;
END;
/
CREATE OR REPLACE FUNCTION GET_FILTERED_TUTIONS(
	s_student_id 	Students.user_id%TYPE,
	u_gender			Users.gender%TYPE,
	t_start				Tutions.salary%TYPE,
	t_end					Tutions.salary%TYPE,
	t_status			Tutors.availability%TYPE,
	t_experience	Tutors.years_of_experience%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Tutors NATURAL JOIN Users
		WHERE (u_gender = 'Any' OR gender = u_gender)
		AND	preffered_salary >= t_start AND preffered_salary <= t_end
		AND (t_status = 'Any' OR availability = t_status)
		AND years_of_experience >= t_experience
		ORDER BY user_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_TUTION_DETAILS(r.user_id,s_student_id);
	END LOOP;
	return tution_list;
END;
/
CREATE OR REPLACE FUNCTION GET_MY_TUTIONS_BY_STUDENT(
	s_student_id Students.user_id%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers
		WHERE student_id = s_student_id 
		AND status = 'ACCEPTED'
		ORDER BY tutor_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_ACCEPTED_TUTION_DETAILS(r.tutor_id,s_student_id);
	END LOOP;
	return tution_list;
END;
/

CREATE OR REPLACE FUNCTION GET_MY_TUTIONS_BY_TUTOR(
	t_tutor_id Tutors.user_id%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers
		WHERE tutor_id = t_tutor_id 
		AND status = 'ACCEPTED'
		ORDER BY student_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_TUTION_DETAILS(t_tutor_id,r.student_id);
	END LOOP;
	return tution_list;
END;
/

CREATE or REPLACE PROCEDURE CHANGE_PASSWORD(
	u_id			Users.user_id%TYPE,
	new_pass	Users.pass%TYPE
)
AS
BEGIN
	UPDATE Users
	SET pass = new_pass
	where user_id = u_id;
EXCEPTION
	WHEN no_data_found THEN
		RAISE_APPLICATION_ERROR(-20999,'No such user');
END;
/

CREATE or REPLACE PROCEDURE RESET_PASSWORD(
	u_email			Users.email%TYPE,
	new_pass		Users.pass%TYPE
)
AS
BEGIN
	DELETE FROM Reset_Pass
	WHERE email = u_email;
	
	UPDATE Users
	SET pass = new_pass
	where email = u_email;
EXCEPTION
	WHEN no_data_found THEN
		RAISE_APPLICATION_ERROR(-20999,'No such user');
END;
/

CREATE OR REPLACE FUNCTION GET_COURSE_ID(
	b_batch_id	Batches.batch_id%TYPE
)
return NUMBER
AS
c_course_id Courses.course_id%TYPE;
BEGIN
SELECT course_id INTO c_course_id
FROM Batches  
WHERE batch_id = b_batch_id;
return c_course_id;
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

CREATE OR REPLACE PROCEDURE ENROLL_COURSE(
	u_user_id		Users.user_id%TYPE,
	b_batch_id	Batches.batch_id%TYPE
)
AS
BEGIN
INSERT INTO EnrolledIn
VALUES(u_user_id,GET_COURSE_ID(b_batch_id),b_batch_id,'PENDING');
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		RAISE_APPLICATION_ERROR(-20999,'Already enrolled in this course');
END;
/

CREATE OR REPLACE PROCEDURE APPROVE_ENROLLMENT(
	s_student_id 	Students.user_id%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
AS
BEGIN
	UPDATE EnrolledIn
	SET status = 'APPROVED'
	WHERE student_id = s_student_id AND batch_id = b_batch_id;
END;
/

CREATE OR REPLACE PROCEDURE DECLINE_ENROLLMENT(
	s_student_id 	Students.user_id%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
AS
BEGIN
	CANCEL_ENROLLMENT(s_student_id,b_batch_id);
	DECLINE_ENROLL_NOTIFICATION(s_student_id,b_batch_id);
END;
/

CREATE OR REPLACE PROCEDURE CANCEL_ENROLLMENT(
	s_student_id 	Students.user_id%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
AS
BEGIN
	DELETE FROM EnrolledIn
	WHERE student_id = s_student_id AND batch_id = b_batch_id;
END;
/

CREATE OR REPLACE FUNCTION  GET_BATCH_DETAILS(
	b_batch_id	Batches.batch_id%TYPE
)
return BATCH
AS 
	batch_row BATCH := BATCH(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Batches
		WHERE batch_id = b_batch_id
	)LOOP
		batch_row := BATCH(
				r.batch_id,
				TO_CHAR(r.start_date,'DD/MON/YYYY'),
				r.seats,
				r.students,
				r.class_days,
				TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),
				TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),
				0,
				NULL
		);
	END LOOP;
	batch_row.student_count := GET_BATCH_STUDENT_COUNT(b_batch_id);
	return batch_row;
END;
/

CREATE OR REPLACE FUNCTION  GET_COURSE_DETAILS(
	c_course_id	Courses.course_id%TYPE,
	b_batch_id  Batches.batch_id%TYPE
)
return COURSE
AS 
	course_row COURSE := COURSE(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT C.course_id,name,class,subject,start_date,seats,students,class_days,start_time,end_time
		FROM Courses C NATURAL JOIN Coachings
		LEFT OUTER JOIN Batches B
		ON B.course_id = C.course_id
		WHERE C.course_id = c_course_id 
		AND (b_batch_id IS NULL OR B.batch_id = b_batch_id)
	)LOOP
		course_row := COURSE(
				r.course_id,
				r.name,
				r.class,
				r.subject,
				TO_CHAR(r.start_date,'DD/MON/YYYY'),
				r.seats,
				r.students,
				r.class_days,
				TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),
				TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),
				0,
				0,
				NULL
		);
		course_row.batch_count := GET_BATCH_COUNT(c_course_id);
		course_row.student_count := GET_COURSE_STUDENT_COUNT(c_course_id);
	END LOOP;
	return course_row;
END;
/
CREATE OR REPLACE FUNCTION  GET_BATCHES(
	c_course_id	Courses.course_id%TYPE
)
return BATCH_ARRAY
AS
batch_list BATCH_ARRAY := BATCH_ARRAY();
BEGIN
	FOR r IN (
			SELECT *
      FROM Batches 
      WHERE course_id = c_course_id
			ORDER BY batch_id ASC
	)LOOP
		batch_list.EXTEND;
		batch_list(batch_list.LAST) := GET_BATCH_DETAILS(r.batch_id);
	END LOOP;
	return batch_list;
END;
/

CREATE OR REPLACE FUNCTION GET_ALREADY_SELECTED_BATCH(
	s_student_id 	Students.user_id%TYPE,
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE
)
return BATCH
AS
batch_row BATCH := BATCH(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN(
		SELECT batch_id,status
		FROM EnrolledIn NATURAL JOIN Courses
		WHERE coaching_id = c_coaching_id
		AND  class = c_class
		AND subject = c_subject
		AND student_id = s_student_id
	)LOOP
		batch_row := GET_BATCH_DETAILS(r.batch_id);
		batch_row.status := r.status;
	END LOOP;
	return batch_row;
END;
/
CREATE OR REPLACE FUNCTION  GET_BATCH_OPTIONS(
	s_student_id 	Students.user_id%TYPE,
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE
)
return BATCH_ARRAY
AS
batch_list BATCH_ARRAY := BATCH_ARRAY();
batch_row BATCH;
BEGIN
	batch_row := GET_ALREADY_SELECTED_BATCH(s_student_id,c_coaching_id,c_class,c_subject);
	IF batch_row.batch_id IS NOT NULL THEN
		batch_list.EXTEND;
		batch_list(batch_list.LAST) := batch_row;
		return batch_list;
	END IF;
	FOR r IN (
			SELECT *
      FROM Courses NATURAL JOIN Batches 
      WHERE coaching_id = c_coaching_id
      AND class = c_class
      AND subject = c_subject
			ORDER BY batch_id ASC
	)LOOP
		batch_list.EXTEND;
		batch_list(batch_list.LAST) := GET_BATCH_DETAILS(r.batch_id);
		FOR r2 IN(
			SELECT status 
			FROM EnrolledIn
			WHERE student_id = s_student_id
			AND batch_id = r.batch_id
		)LOOP
			batch_list(batch_list.LAST).status := r2.status;
		END LOOP;
	END LOOP;
	return batch_list;
END;
/

CREATE OR REPLACE FUNCTION  GET_SUBJECT_OPTIONS(
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE
)
return STRING_ARRAY
AS
subject_list STRING_ARRAY := STRING_ARRAY();
BEGIN
	FOR r IN (
			SELECT DISTINCT subject
      FROM Courses 
      WHERE coaching_id = c_coaching_id
      AND class = c_class
	)LOOP
		subject_list.EXTEND;
		subject_list(subject_list.LAST) := r.subject;
	END LOOP;
	return subject_list;
END;
/

CREATE OR REPLACE FUNCTION  GET_CLASS_OPTIONS(
	c_coaching_id	Coachings.coaching_id%TYPE
)
return STRING_ARRAY
AS
class_list STRING_ARRAY := STRING_ARRAY();
BEGIN
	FOR r IN (
			SELECT DISTINCT class
      FROM Courses 
      WHERE coaching_id = c_coaching_id
	)LOOP
		class_list.EXTEND;
		class_list(class_list.LAST) := r.class;
	END LOOP;
	return class_list;
END;
/

CREATE OR REPLACE FUNCTION GET_PASSWORD(
	u_email			Users.email%TYPE,
	u_role 			Users.role%TYPE
)
return 	Users.pass%TYPE
AS
curr_pass	Users.pass%TYPE;
BEGIN
	SELECT pass INTO curr_pass
	FROM Users
	where email = u_email
	AND role = u_role;
	return curr_pass;
EXCEPTION
	WHEN others THEN
		return NULL;
END;
/

CREATE OR REPLACE PROCEDURE CANCEL_APPLICATION(
	t_tutor_id	Tutors.user_id%TYPE,
	tp_post_id 	Tution_Posts.post_id%TYPE
)
AS
BEGIN
	DELETE FROM Applies
  WHERE tutor_id = t_tutor_id AND post_id = tp_post_id;
END;
/

CREATE OR REPLACE PROCEDURE APPLY_FOR_TUTION(
	t_tutor_id	Tutors.user_id%TYPE,
	tp_post_id 	Tution_Posts.post_id%TYPE
)
AS
BEGIN
	INSERT INTO Applies (tutor_id, post_id)
  VALUES(t_tutor_id,tp_post_id);
END;
/

CREATE OR REPLACE FUNCTION IS_TUTION_REJECTED(
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE
)
return VARCHAR2
AS
o_status Offers.status%TYPE; 
BEGIN
	SELECT status INTO o_status
	FROM Offers
	WHERE student_id = s_student_id
	AND tutor_id = t_tutor_id
	AND status = 'REJECTED';
	return 'YES';
EXCEPTION
	WHEN OTHERS THEN
		return 'NO';
END;
/

CREATE OR REPLACE FUNCTION IS_TUTION_CANCELLED(
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE
)
return VARCHAR2
AS
o_status Offers.status%TYPE; 
BEGIN
	SELECT status INTO o_status
	FROM Offers
	WHERE student_id = s_student_id
	AND tutor_id = t_tutor_id
	AND status = 'CANCELLED';
	return 'YES';
EXCEPTION
	WHEN OTHERS THEN
		return 'NO';
END;
/

CREATE OR REPLACE FUNCTION IS_TUTION_ACCEPTED(
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE
)
return VARCHAR2
AS
o_status Offers.status%TYPE; 
BEGIN
	SELECT status INTO o_status
	FROM Offers
	WHERE student_id = s_student_id
	AND tutor_id = t_tutor_id
	AND status = 'ACCEPTED';
	return 'YES';
EXCEPTION
	WHEN OTHERS THEN
		return 'NO';
END;
/

CREATE OR REPLACE PROCEDURE MAKE_OFFER(
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE,
	t_subjects 			Tutions.subjects%TYPE,
	t_salary 				Tutions.salary%TYPE,
	t_start_date 		VARCHAR2,
	t_class_days 		Tutions.class_days%TYPE,
	t_start_time		VARCHAR2,
	t_end_time			VARCHAR2,
	t_type					Tutions.type%TYPE
)
AS
BEGIN
		IF IS_TUTION_ACCEPTED(s_student_id,t_tutor_id) = 'YES' THEN
			INSERT INTO Offers (student_id, tutor_id, tution_id, status)
			VALUES(s_student_id,t_tutor_id,CREATE_TUTION(t_subjects,t_salary,NULL,t_start_date,t_class_days,t_start_time,t_end_time,t_type),'UPDATE');
		ELSIF IS_TUTION_REJECTED(s_student_id,t_tutor_id) = 'YES' OR IS_TUTION_CANCELLED(s_student_id,t_tutor_id) = 'YES' THEN
			UPDATE Offers
			SET status = 'PENDING',
			tution_id = CREATE_TUTION(t_subjects,t_salary,NULL,t_start_date,t_class_days,t_start_time,t_end_time,t_type)
			WHERE student_id = s_student_id AND tutor_id = t_tutor_id;
		ELSE 
			INSERT INTO Offers (student_id, tutor_id, tution_id, status)
			VALUES(s_student_id,t_tutor_id,CREATE_TUTION(t_subjects,t_salary,NULL,t_start_date,t_class_days,t_start_time,t_end_time,t_type),'PENDING');
	 END IF;
END;
/

CREATE OR REPLACE PROCEDURE MAKE_OFFER_FOR_POST(
	p_post_id 			Tution_Posts.post_id%TYPE,
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE,
	t_subjects 			Tutions.subjects%TYPE,
	t_salary 				Tutions.salary%TYPE,
	t_start_date 		VARCHAR2,
	t_class_days 		Tutions.class_days%TYPE,
	t_start_time		VARCHAR2,
	t_end_time			VARCHAR2,
	t_type					Tutions.type%TYPE
)
AS
BEGIN
	UPDATE Tution_Posts SET booking_status = 'PENDING', selected_tutor = t_tutor_id
	WHERE post_id = p_post_id;
	
	MAKE_OFFER(s_student_id,t_tutor_id,t_subjects,t_salary,t_start_date,t_class_days,t_start_time,t_end_time,t_type);
END;
/

CREATE OR REPLACE FUNCTION IS_VALID_TOKEN(
	u_id			Users.user_id%TYPE, 
	u_email		Users.email%TYPE, 
	u_pass		Users.pass%TYPE,  
	u_role		Users.role%TYPE
)
return VARCHAR2
AS
user_row Users%ROWTYPE;
BEGIN
	user_row := GET_USER_BY_EMAIL(u_email);
	IF user_row.pass = u_pass AND user_row.user_id = u_id AND user_row.role = u_role THEN
		return 'YES';
	ELSE
		return 'NO';
	END IF;
END;
/

CREATE OR REPLACE PROCEDURE CHANGE_PROFILE_PICTURE(
	u_user_id	Users.user_id%TYPE,
	u_image		Users.image%TYPE
)
AS 
BEGIN
	UPDATE Users
  SET image = u_image
  WHERE user_id = u_user_id;
END;
/

CREATE OR REPLACE PROCEDURE CHANGE_COACHING_PICTURE(
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_image				Coachings.image%TYPE
)
AS 
BEGIN
	UPDATE Coachings
	SET image = c_image
	WHERE coaching_id = c_coaching_id;
END;
/
CREATE OR REPLACE PROCEDURE ACCEPT_OFFER(
	t_tutor_id 		Tutors.user_id%TYPE,
	s_student_id 	Students.user_id%TYPE
)
AS
new_tution_id Tutions.tution_id%TYPE;
BEGIN
	UPDATE Tution_Posts SET booking_status = 'BOOKED'
	WHERE student_id = s_student_id AND booking_status = 'PENDING' AND selected_tutor = t_tutor_id;
		
	IF IS_TUTION_ACCEPTED(s_student_id,t_tutor_id) = 'YES' THEN
		--- Replace old tution id with new one.
		SELECT tution_id INTO new_tution_id
		FROM Offers
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'UPDATE';
		
		DELETE FROM Offers
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'UPDATE';
		
		UPDATE Offers
		SET tution_id = new_tution_id
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'ACCEPTED';
	ELSE 
		--- Update offer status
		UPDATE Offers
		SET status = 'ACCEPTED', feedback_id = NULL
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'PENDING';
	END IF;
	
END;
/

CREATE OR REPLACE PROCEDURE APPROVE_JOIN_REQUEST(
	c_coaching_id 		Coachings.coaching_id%TYPE,
	s_student_id 			Students.user_id%TYPE
)
AS
BEGIN
	UPDATE MemberOf
	SET type = 'MEMBER'
	WHERE coaching_id = c_coaching_id AND user_id = s_student_id;
	
	APPROVE_JOIN_NOTIFICATION(c_coaching_id,s_student_id);
END;
/

-- CREATE OR REPLACE PROCEDURE UPLOAD_CONTENT_COACHING(
-- 	c_coaching_id 		Coachings.coaching_id%TYPE,
-- 	title 						Materials.title%TYPE,
-- 	subject						Materials.subject%TYPE,
-- 	link 							Materials.link%TYPE
-- )
-- AS
-- coaching_row COACHING;
-- BEGIN
-- 	UPDATE MemberOf
-- 	SET type = 'MEMBER'
-- 	WHERE coaching_id = c_coaching_id AND user_id = s_student_id;
-- 	APPROVE_JOIN_NOTIFICATION(c_coaching_id,s_student_id);
-- END;
-- /

CREATE OR REPLACE PROCEDURE UPLOAD_MATERIAL(
	t_tutor_id 					NUMBER,
	m_material_type			Materials.material_type%TYPE,
	m_description 			Materials.description%TYPE,
	m_link 							Materials.link%TYPE
)
AS
tutor_row TUTOR;
BEGIN
	tutor_row := GET_TUTOR_DETAILS(t_tutor_id);
	INSERT INTO MATERIALS(material_type,description,link,tutor_id) 
	VALUES(m_material_type,m_description,m_link,t_tutor_id);
END;
/

CREATE OR REPLACE FUNCTION GET_MATERIAL_DETAILS(
	m_material_id Materials.material_id%TYPE
)
return MATERIAL
AS 
	material_row MATERIAL := MATERIAL(NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Materials JOIN Users
		ON tutor_id = user_id
		WHERE material_id = m_material_id
	)LOOP
		material_row := MATERIAL(
				r.material_type,
				r.description,
				r.link,
				r.name,
				r.image,
				TO_CHAR(r.timestamp,'DD/MON/YYYY HH24:MI:SS')
		);
	END LOOP;
	return material_row;
END;
/

CREATE OR REPLACE FUNCTION GET_ALL_MATERIALS
	return MATERIAL_ARRAY
AS
material_list MATERIAL_ARRAY := MATERIAL_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Materials
		ORDER BY material_id DESC
	)LOOP
	material_list.EXTEND;
	material_list(material_list.LAST) := GET_MATERIAL_DETAILS(r.material_id);
	END LOOP;
	return material_list;
END;
/


CREATE OR REPLACE FUNCTION GET_TUTOR_MATERIALS(
	t_tutor_id 		Tutors.user_id%TYPE
)
return MATERIAL_ARRAY
AS
material_list MATERIAL_ARRAY := MATERIAL_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Materials
		WHERE tutor_id = t_tutor_id
		ORDER BY material_id	 DESC
	)LOOP
	material_list.EXTEND;
	material_list(material_list.LAST) := GET_MATERIAL_DETAILS(r.material_id);
	END LOOP;
	return material_list;
END;
/

CREATE OR REPLACE PROCEDURE DECLINE_JOIN_REQUEST(
	c_coaching_id 		Coachings.coaching_id%TYPE,
	s_student_id 			Students.user_id%TYPE
)
AS
BEGIN
	CANCEL_JOIN_REQUEST(c_coaching_id,s_student_id);
	DECLINE_JOIN_NOTIFICATION(c_coaching_id,s_student_id);
END;
/

CREATE OR REPLACE PROCEDURE CANCEL_JOIN_REQUEST(
	c_coaching_id 		Coachings.coaching_id%TYPE,
	s_student_id 			Students.user_id%TYPE
)
AS
BEGIN
	DELETE FROM MemberOf
	WHERE coaching_id = c_coaching_id AND user_id = s_student_id;
	
	CANCEL_JOIN_NOTIFICATION(c_coaching_id,s_student_id);
END;
/

CREATE OR REPLACE PROCEDURE CANCEL_OFFER(
	t_tutor_id 		Tutors.user_id%TYPE,
	s_student_id 	Students.user_id%TYPE
)
AS
BEGIN
	UPDATE Tution_Posts SET booking_status = NULL, selected_tutor = NULL
	WHERE student_id = s_student_id AND booking_status = 'PENDING' AND selected_tutor = t_tutor_id;
	IF IS_TUTION_ACCEPTED(s_student_id,t_tutor_id) = 'YES' THEN
		DELETE FROM Offers
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id
		AND status = 'UPDATE';
	ELSE 	 
		UPDATE Offers
		SET status = 'CANCELLED'
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id 
		AND status = 'PENDING';
	END IF;
END;
/

CREATE OR REPLACE PROCEDURE REJECT_OFFER(
	t_tutor_id 		Tutors.user_id%TYPE,
	s_student_id 	Students.user_id%TYPE,
	reason 				Feedbacks.review%TYPE
)
AS
f_id Feedbacks.feedback_id%TYPE;
BEGIN
	UPDATE Tution_Posts SET booking_status = NULL, selected_tutor = NULL
	WHERE student_id = s_student_id AND booking_status = 'PENDING' AND selected_tutor = t_tutor_id;
	
	IF IS_TUTION_ACCEPTED(s_student_id,t_tutor_id) = 'YES' THEN
		DELETE FROM Offers
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id 
		AND status = 'UPDATE';
	ELSE
		INSERT INTO Feedbacks(review) 
		VALUES(reason)
		RETURNING feedback_id INTO f_id;

		UPDATE Offers
		SET status = 'REJECTED',feedback_id = f_id
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'PENDING';
	END IF;
END;
/

CREATE OR REPLACE FUNCTION GET_ADMIN_COURSES(
	t_tutor_id	Tutors.user_id%TYPE
)
return COURSE_ARRAY
AS
course_list COURSE_ARRAY := COURSE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM MemberOf NATURAL JOIN Courses
		WHERE user_id = t_tutor_id AND type = 'ADMIN'
		ORDER BY course_id ASC
	)LOOP
		course_list.EXTEND;
		course_list(course_list.LAST) := GET_COURSE_DETAILS(r.course_id, NULL);
	END LOOP;
	return course_list;
END;
/

CREATE OR REPLACE FUNCTION GET_COACHING_COURSES(
	c_coaching_id	Coachings.coaching_id%TYPE
)
return COURSE_ARRAY
AS
course_list COURSE_ARRAY := COURSE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Courses
		WHERE coaching_id = c_coaching_id
		ORDER BY course_id ASC
	)LOOP
		course_list.EXTEND;
		course_list(course_list.LAST) := GET_COURSE_DETAILS(r.course_id, NULL);
	END LOOP;
	return course_list;
END;
/

CREATE OR REPLACE FUNCTION GET_MEMBER_COURSES(
	s_student_id	Students.user_id%TYPE
)
return COURSE_ARRAY
AS
course_list COURSE_ARRAY := COURSE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM EnrolledIn
		WHERE student_id = s_student_id
		ORDER BY course_id ASC
	)LOOP
		course_list.EXTEND;
		course_list(course_list.LAST) := GET_COURSE_DETAILS(r.course_id,r.batch_id);
		course_list(course_list.LAST).status := r.status;
	END LOOP;
	return course_list;
END;
/



CREATE OR REPLACE PROCEDURE RATE_TUTOR(
	s_student_id 	Students.user_id%TYPE,
	t_tutor_id 		Tutors.user_id%TYPE,
	f_rating			Feedbacks.rating%TYPE,
	f_review			Feedbacks.review%TYPE
)
AS
f_id	Feedbacks.feedback_id%TYPE;
BEGIN
	SELECT feedback_id INTO f_id
	FROM Offers
	WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'ACCEPTED';
	
	IF f_id IS NULL THEN 
		INSERT INTO Feedbacks(rating,review) 
		VALUES(f_rating,f_review)
		RETURNING feedback_id INTO f_id;
		UPDATE Offers SET feedback_id = f_id
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'ACCEPTED';
	ELSE 
		UPDATE Feedbacks SET rating = f_rating, review = f_review
		WHERE feedback_id = f_id;
	END IF;
END;
/

CREATE OR REPLACE FUNCTION GET_FEEDBACK_DETAILS(
	f_feedback_id 		Feedbacks.feedback_id%TYPE
)
return FEEDBACK
AS
feedback_row FEEDBACK := FEEDBACK(NULL,NULL,NULL);
BEGIN
	FOR r IN(
		SELECT *
		FROM Feedbacks
		WHERE feedback_id = f_feedback_id
	)LOOP
		feedback_row := FEEDBACK(r.feedback_id,r.rating,r.review);
	END LOOP;
	return feedback_row;
END;
/

CREATE OR REPLACE FUNCTION GET_FEEDBACKS(
	t_tutor_id 		Tutors.user_id%TYPE
)
return FEEDBACK_ARRAY
AS
feedback_list FEEDBACK_ARRAY := FEEDBACK_ARRAY();
BEGIN
	FOR r IN(
		SELECT feedback_id
		FROM Offers
		WHERE tutor_id = t_tutor_id AND status = 'ACCEPTED'
		AND feedback_id IS NOT NULL
		ORDER BY feedback_id ASC
	)LOOP
	feedback_list.EXTEND;
	feedback_list(feedback_list.LAST) := GET_FEEDBACK_DETAILS(r.feedback_id);
	END LOOP;
	return feedback_list;
END;
/

CREATE OR REPLACE FUNCTION GET_BATCH_STUDENT_COUNT(
	b_batch_id	Batches.batch_id%TYPE
)
return NUMBER
AS
student_count	NUMBER;
BEGIN
	SELECT COUNT(*) INTO student_count
	FROM EnrolledIn 
	WHERE batch_id = b_batch_id;
	return student_count;
END;
/

CREATE OR REPLACE FUNCTION GET_BATCH_COUNT(
	c_course_id	Courses.course_id%TYPE
)
return NUMBER
AS
batch_count	NUMBER;
BEGIN
	SELECT COUNT(*) INTO batch_count
	FROM Batches
	WHERE course_id = c_course_id;
	return batch_count;
END;
/

CREATE OR REPLACE FUNCTION GET_COURSE_STUDENT_COUNT(
	c_course_id	Courses.course_id%TYPE
)
return NUMBER
AS
student_count	NUMBER;
BEGIN
	SELECT COUNT(*) INTO student_count
	FROM EnrolledIn 
	WHERE course_id = c_course_id;
	return student_count;
END;
/

CREATE OR REPLACE FUNCTION GET_SEAT_COUNT(
	b_batch_id	Batches.batch_id%TYPE
)
return NUMBER
AS
seat_count	NUMBER;
BEGIN
	SELECT seats INTO seat_count
	FROM Batches 
	WHERE batch_id = b_batch_id;
	return seat_count;
END;
/

CREATE OR REPLACE PROCEDURE SAVE_RESET_TOKEN(
	u_email		Users.email%TYPE,
	token 		VARCHAR2
)
AS
BEGIN
	DELETE FROM Reset_Pass
	WHERE email = u_email;
	INSERT INTO Reset_Pass(email,token)
	VALUES(u_email,token);
END;
/

CREATE OR REPLACE FUNCTION GET_RESET_EMAIL(
	u_token 		VARCHAR2
)
return Users.email%TYPE
AS
u_email Users.email%TYPE;
BEGIN
	SELECT email INTO u_email
	FROM Reset_Pass
	WHERE token = u_token;
	return u_email;
END;
/


DECLARE
curr_pass	Users.pass%TYPE;
BEGIN
curr_pass := GET_PASSWORD(1);
DBMS_OUTPUT.PUT_LINE(curr_pass);
END;
/