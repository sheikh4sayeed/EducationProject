-- DROP TRIGGER REJECT_OFFER_NOTIFICATION;
-- DROP TRIGGER ACCEPT_OFFER_NOTIFICATION;
-- DROP TRIGGER APPROVE_JOIN_NOTIFICATION;
-- DROP TRIGGER DECLINE_JOIN_NOTIFICATION;
-- DROP TRIGGER APPROVE_ENROLL_NOTIFICATION;
-- DROP TRIGGER DECLINE_ENROLL_NOTIFICATION;
-- DROP TRIGGER TUTION_OFFER_NOTIFICATION;

CREATE OR REPLACE TRIGGER  CHECK_DATE_OF_BIRTH
	BEFORE INSERT
	ON Users
	FOR EACH ROW
BEGIN
    IF (:new.DATE_OF_BIRTH <= ADD_MONTHS(SYSDATE, - 120) AND :new.DATE_OF_BIRTH >= (ADD_MONTHS(SYSDATE, -1300))) = FALSE THEN
        RAISE_APPLICATION_ERROR(-20999, 'invalid date');
    end if;
end;
/

CREATE OR REPLACE TRIGGER GENERATE_USER_ID
	BEFORE INSERT
	ON Users
	FOR EACH ROW
BEGIN
	SELECT COUNT(user_id)+1 INTO :NEW.user_id
	FROM Users; 
	IF :NEW.user_id > 1 THEN
		SELECT MAX(user_id)+1 INTO :NEW.user_id
		FROM Users; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_TUTION_ID
	BEFORE INSERT
	ON Tutions
	FOR EACH ROW
BEGIN
	SELECT COUNT(tution_id)+1 INTO :NEW.tution_id
	FROM Tutions; 
	IF :NEW.tution_id > 1 THEN
		SELECT MAX(tution_id)+1 INTO :NEW.tution_id
		FROM Tutions; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_FEEDBACK_ID
	BEFORE INSERT
	ON Feedbacks
	FOR EACH ROW
BEGIN
	SELECT COUNT(feedback_id)+1 INTO :NEW.feedback_id
	FROM Feedbacks; 
	IF :NEW.feedback_id > 1 THEN
		SELECT MAX(feedback_id)+1 INTO :NEW.feedback_id
		FROM Feedbacks; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_TUTION_POST_ID
	BEFORE INSERT
	ON Tution_Posts
	FOR EACH ROW
BEGIN
	SELECT COUNT(post_id)+1 INTO :NEW.post_id
	FROM Tution_Posts; 
	IF :NEW.post_id > 1 THEN
		SELECT MAX(post_id)+1 INTO :NEW.post_id
		FROM Tution_Posts; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_COACHING_ID
	BEFORE INSERT
	ON Coachings
	FOR EACH ROW
BEGIN
	SELECT COUNT(coaching_id)+1 INTO :NEW.coaching_id
	FROM Coachings; 
	IF :NEW.coaching_id > 1 THEN
		SELECT MAX(coaching_id)+1 INTO :NEW.coaching_id
		FROM Coachings; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_COURSE_ID
	BEFORE INSERT
	ON Courses
	FOR EACH ROW
BEGIN
	SELECT COUNT(course_id)+1 INTO :NEW.course_id
	FROM Courses; 
	IF :NEW.course_id > 1 THEN
		SELECT MAX(course_id)+1 INTO :NEW.course_id
		FROM Courses; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_MATERIAL_ID
	BEFORE INSERT
	ON Materials
	FOR EACH ROW
BEGIN
	SELECT COUNT(material_id)+1 INTO :NEW.material_id
	FROM Materials; 
	IF :NEW.material_id > 1 THEN
		SELECT MAX(material_id)+1 INTO :NEW.material_id
		FROM Materials; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_BATCH_ID
	BEFORE INSERT
	ON Batches
	FOR EACH ROW
BEGIN
	SELECT COUNT(batch_id)+1 INTO :NEW.batch_id
	FROM Batches; 
	IF :NEW.batch_id > 1 THEN
		SELECT MAX(batch_id)+1 INTO :NEW.batch_id
		FROM Batches; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_EDUCATION_ID
	BEFORE INSERT
	ON Educations
	FOR EACH ROW
BEGIN
	SELECT COUNT(eq_id)+1 INTO :NEW.eq_id
	FROM Educations; 
	IF :NEW.eq_id > 1 THEN
		SELECT MAX(eq_id)+1 INTO :NEW.eq_id
		FROM Educations; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_NOTICE_ID
	BEFORE INSERT
	ON Notices
	FOR EACH ROW
BEGIN
	SELECT COUNT(notice_id)+1 INTO :NEW.notice_id
	FROM Notices; 
	IF :NEW.notice_id > 1 THEN
		SELECT MAX(notice_id)+1 INTO :NEW.notice_id
		FROM Notices; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER GENERATE_NOTIFICATION_ID
	BEFORE INSERT
	ON Notifications
	FOR EACH ROW
BEGIN
	SELECT COUNT(notification_id)+1 INTO :NEW.notification_id
	FROM Notifications; 
	IF :NEW.notification_id > 1 THEN
		SELECT MAX(notification_id)+1 INTO :NEW.notification_id
		FROM Notifications; 
	END IF;
END;
/

CREATE OR REPLACE TRIGGER NEW_USER
	AFTER INSERT
	ON USERS
	FOR EACH ROW
BEGIN
	IF :NEW.role = 'STUDENT' THEN
		CREATE_STUDENT(:NEW.user_id);
	ELSE
		CREATE_TUTOR(:NEW.user_id);
	END IF;
END;
/

CREATE OR REPLACE TRIGGER CHECK_EMAIL
	BEFORE INSERT
	ON USERS
	FOR EACH ROW
DECLARE	
	user_row Users%ROWTYPE;
BEGIN
	IF IS_EMAIL_TAKEN(:NEW.email) = 'YES' THEN
		RAISE_APPLICATION_ERROR(-20999, 'Email is already taken');
	END IF;
END;
/

CREATE OR REPLACE TRIGGER NOTICE_NOTIFICATION
	AFTER INSERT
	ON Notices
	FOR EACH ROW
DECLARE
	c_name 	Coachings.name%TYPE;
	c_image Coachings.image%TYPE;
BEGIN
	SELECT name,image INTO c_name,c_image
	FROM Coachings WHERE coaching_id = :NEW.coaching_id;	
	FOR r IN (
		SELECT user_id
		FROM Students
	)LOOP
	IF IS_MEMBER_INCLUDED(r.user_id,:NEW.admin_id,:NEW.coaching_id,:NEW.class,:NEW.subject,:NEW.batch_id) = 'YES' THEN
		INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
		VALUES('NOTICE','POST',:NEW.coaching_id,:NEW.notice_id,r.user_id,c_image,c_name||' has posted a new notice','/notice_board');
	END IF;
	END LOOP;
END;
/

CREATE OR REPLACE TRIGGER ACCEPT_UPDATED_OFFER_NOTIFICATION
	AFTER UPDATE
	ON Offers
	FOR EACH ROW
WHEN (OLD.status = 'ACCEPTED' AND NEW.status = 'ACCEPTED' AND OLD.tution_id <> NEW.tution_id)
DECLARE
	t_name 	Users.name%TYPE;
	t_image Users.image%TYPE;
BEGIN
	SELECT name,image INTO t_name,t_image
	FROM Users WHERE user_id = :NEW.tutor_id;
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('TUTION','ACCEPT_UPDATE',:NEW.tutor_id,:NEW.tution_id,:NEW.student_id,t_image,t_name||' has accepted your updated offer','/my_tutors?id='||:NEW.tutor_id);
	
	DELETE FROM Notifications
	WHERE type = 'TUTION' AND action = 'UPDATE' AND sender_id = :NEW.student_id AND user_id = :NEW.tutor_id;
END;
/


CREATE OR REPLACE TRIGGER ACCEPT_OFFER_NOTIFICATION
	AFTER UPDATE
	ON Offers
	FOR EACH ROW
WHEN (OLD.status = 'PENDING' AND NEW.status = 'ACCEPTED')
DECLARE
	t_name 	Users.name%TYPE;
	t_image Users.image%TYPE;
BEGIN
	SELECT name,image INTO t_name,t_image
	FROM Users WHERE user_id = :NEW.tutor_id;
	
	DELETE FROM Notifications
	WHERE type = 'TUTION' AND action = 'OFFER' AND sender_id = :NEW.student_id AND user_id = :NEW.tutor_id;
	
	DELETE FROM Notifications
	WHERE type = 'APPLICATION' AND action = 'SUBMIT' AND sender_id = :NEW.tutor_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('TUTION','ACCEPT',:NEW.tutor_id,:NEW.tution_id,:NEW.student_id,t_image,t_name||' has accepted your offer','/my_tutors?id='||:NEW.tutor_id);
END;
/

CREATE OR REPLACE TRIGGER REJECT_OFFER_NOTIFICATION
	AFTER UPDATE
	OF status
	ON Offers
	FOR EACH ROW
WHEN (NEW.status = 'REJECTED')
DECLARE
	t_name 	Users.name%TYPE;
	t_image Users.image%TYPE;
	reason 	Feedbacks.review%TYPE;
BEGIN
	SELECT review INTO reason
	FROM Feedbacks WHERE feedback_id = :NEW.feedback_id; 
	
	SELECT name,image INTO t_name,t_image
	FROM Users WHERE user_id = :NEW.tutor_id;
	
	DELETE FROM Notifications
	WHERE type = 'TUTION' AND action = 'OFFER' AND sender_id = :NEW.student_id AND user_id = :NEW.tutor_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('TUTION','REJECT',:NEW.tutor_id,:NEW.tution_id,:NEW.student_id,t_image,t_name||' has rejected your offer. Reason: "'||reason||'"','/home/tutors?id='||:NEW.tutor_id);
END;
/

CREATE OR REPLACE TRIGGER TUTION_OFFER_NOTIFICATION
	AFTER INSERT OR UPDATE
	OF status
	ON Offers
	FOR EACH ROW
WHEN (NEW.status = 'PENDING')
DECLARE
	student_row STUDENT;
BEGIN
	student_row := GET_STUDENT_DETAILS(:NEW.student_id);
	DELETE FROM Notifications
	WHERE type = 'TUTION' AND action = 'REJECT' AND sender_id = :NEW.tutor_id AND user_id = :NEW.student_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('TUTION','OFFER',:NEW.student_id,:NEW.tution_id,:NEW.tutor_id,student_row.image,student_row.name||' has offered you a tution','/pending_requests?type=Tution+Offer&id='||:NEW.student_id);
END;
/

CREATE OR REPLACE TRIGGER CANCEL_OFFER_NOTIFICATION
	AFTER UPDATE
	OF status
	ON Offers
	FOR EACH ROW
WHEN (NEW.status = 'CANCELLED')
DECLARE
	t_name 	Users.name%TYPE;
	t_image Users.image%TYPE;
BEGIN
	SELECT name,image INTO t_name,t_image
	FROM Users WHERE user_id = :NEW.tutor_id;
	
	DELETE FROM Notifications
	WHERE type = 'TUTION' AND action = 'OFFER' AND sender_id = :NEW.student_id AND user_id = :NEW.tutor_id;
END;
/

CREATE OR REPLACE TRIGGER NEW_FEEDBACK_NOTIFICATION
	AFTER UPDATE
	OF feedback_id
	ON Offers
	FOR EACH ROW
WHEN (OLD.status = 'ACCEPTED')
DECLARE
	s_name 	Users.name%TYPE;
	s_image Users.image%TYPE;
BEGIN
	SELECT name,image INTO s_name,s_image
	FROM Users
	WHERE user_id = :NEW.student_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('FEEDBACK','SUBMIT',:NEW.student_id,:NEW.feedback_id,:NEW.tutor_id,s_image,'You have received a feedback by '||s_name,'/my_students?id='||:NEW.student_id);
	
END;
/

-- DROP TRIGGER FEEDBACK_UPDATE_NOTIFICATION;
CREATE OR REPLACE TRIGGER FEEDBACK_UPDATE_NOTIFICATION
	AFTER UPDATE
	ON Feedbacks
	FOR EACH ROW
DECLARE
	s_name 	Users.name%TYPE;
	s_image Users.image%TYPE;
	s_id 		Users.user_id%TYPE;
	t_id 		Tutors.user_id%TYPE;
BEGIN
	SELECT name,image,user_id,tutor_id INTO s_name,s_image,s_id,t_id
	FROM Offers JOIN Users
	ON user_id = student_id
	WHERE feedback_id = :NEW.feedback_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('FEEDBACK','UPDATE',s_id,:NEW.feedback_id,t_id,s_image,s_name||' has updated feedback','/my_students?id='||s_id);
	
	DELETE FROM Notifications
	WHERE type = 'FEEDBACK' AND sender_id = s_id AND user_id = t_id
	AND entity_id <> :NEW.feedback_id;
END;
/

CREATE OR REPLACE TRIGGER COURSE_ENROLL_NOTIFICATION
	AFTER INSERT
	ON EnrolledIn
	FOR EACH ROW
WHEN (NEW.status = 'PENDING')
DECLARE
	s_name 		Users.name%TYPE;
	s_image 	Users.image%TYPE;
	c_id			Coachings.coaching_id%TYPE;
	t_id  		Tutors.user_id%TYPE;
	c_name 		Coachings.name%TYPE;
	c_class		Courses.class%TYPE;
	c_subject Courses.subject%TYPE;
BEGIN
	SELECT coaching_id,name INTO c_id,c_name
	FROM Courses NATURAL JOIN Coachings 
	WHERE course_id = :NEW.course_id;
	
	SELECT user_id INTO t_id
	FROM MemberOf NATURAL JOIN Tutors
	WHERE coaching_id = c_id AND type = 'ADMIN';
	
	SELECT name,image INTO s_name,s_image
	FROM Users
	WHERE user_id = :NEW.student_id;
	
	SELECT class,subject INTO c_class,c_subject
	FROM Courses
	WHERE course_id = :NEW.course_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('ENROLL','REQUEST',:NEW.student_id,:NEW.course_id,t_id,s_image,s_name||' has requested to enroll in '||c_subject||', '||c_class||', '||c_name,'/pending_requests?type=Course+Enroll&coaching='||c_id||'&class='||c_class||'&subject='||c_subject||'&batch='||:NEW.batch_id||'&id='||:NEW.student_id);
	
	DELETE FROM Notifications
	WHERE type = 'ENROLL' AND action = 'DECLINE' AND sender_id = c_id AND entity_id = :NEW.course_id AND user_id = :NEW.student_id;
END;
/

CREATE OR REPLACE TRIGGER CANCEL_ENROLL_NOTIFICATION
	AFTER DELETE
	ON EnrolledIn
	FOR EACH ROW
WHEN (OLD.status = 'PENDING')
BEGIN
	DELETE FROM NOTIFICATIONS 
	WHERE type = 'ENROLL' AND action = 'REQUEST' AND sender_id = :OLD.student_id AND entity_id = :OLD.course_id;
END;
/

-- CREATE OR REPLACE TRIGGER DELETE_OFFER_TRIGGER
-- 	AFTER DELETE
-- 	ON Offers
-- 	FOR EACH ROW
-- BEGIN
-- 	DELETE FROM Tutions 
-- 	WHERE tution_id = :OLD.tution_id;
-- END;
-- /


CREATE OR REPLACE TRIGGER APPROVE_ENROLL_NOTIFICATION
	AFTER UPDATE
	OF status
	ON EnrolledIn
	FOR EACH ROW
WHEN (OLD.status = 'PENDING' AND NEW.status = 'APPROVED')
DECLARE
	c_name 	Coachings.name%TYPE;
	c_image Coachings.image%TYPE;
	c_id		Coachings.coaching_id%TYPE;
	c_class		Courses.class%TYPE;
	c_subject Courses.subject%TYPE;
BEGIN
	SELECT name,image,coaching_id INTO c_name,c_image,c_id
	FROM Courses NATURAL JOIN Coachings 
	WHERE course_id = :NEW.course_id;
	
	SELECT class,subject INTO c_class,c_subject
	FROM Courses
	WHERE course_id = :NEW.course_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('ENROLL','APPROVE',c_id,:NEW.course_id,:NEW.student_id,c_image,c_name||' has approved your enrollment in '||c_subject||', '||c_class||', '||c_name,'/my_courses');
	
	DELETE FROM NOTIFICATIONS 
	WHERE type = 'ENROLL' AND action = 'REQUEST' AND sender_id = :NEW.student_id AND entity_id = :NEW.course_id;
END;
/



CREATE OR REPLACE TRIGGER TUTION_UPDATE_NOTIFICATION
	AFTER INSERT
	ON Offers
	FOR EACH ROW
WHEN (NEW.status = 'UPDATE')
DECLARE
	student_row STUDENT;
BEGIN
	student_row := GET_STUDENT_DETAILS(:NEW.student_id);
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('TUTION','UPDATE',:NEW.student_id,:NEW.tution_id,:NEW.tutor_id,student_row.image,student_row.name||' has requested to update tution','/pending_requests?type=Tution+Offer&id='||:NEW.student_id);
END;
/


CREATE OR REPLACE TRIGGER NEW_APPLICATION_NOTIFICATION
	AFTER INSERT
	ON Applies
	FOR EACH ROW
DECLARE
	t_name 	Users.name%TYPE;
	t_image Users.image%TYPE;
	s_id		Students.user_id%TYPE;
BEGIN
	SELECT name,image INTO t_name,t_image
	FROM Users WHERE user_id = :NEW.tutor_id;
	SELECT student_id INTO s_id
	FROM Tution_Posts WHERE post_id = :NEW.post_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('APPLICATION','SUBMIT',:NEW.tutor_id,:NEW.post_id,s_id,t_image,t_name||' has applied to your tution post','/req_tutor/applicants?post_id='||:NEW.post_id||'&id='||:NEW.tutor_id);
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20000,'ERROR APP');
END;
/


CREATE OR REPLACE TRIGGER CANCEL_APPLICATION_NOTIFICATION
	AFTER DELETE
	ON Applies
	FOR EACH ROW
DECLARE
	t_name 	Users.name%TYPE;
	t_image Users.image%TYPE;
	s_id		Students.user_id%TYPE;
BEGIN
	SELECT student_id INTO s_id
	FROM Tution_Posts WHERE post_id = :OLD.post_id;
	
	DELETE FROM Notifications 
	WHERE type = 'APPLICATION' AND action = 'SUBMIT' AND sender_id = :OLD.tutor_id AND entity_id = :OLD.post_id;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20000,'ERROR APP');
END;
/

CREATE OR REPLACE TRIGGER TUTION_POST_OFFER_TRIGGER
	BEFORE UPDATE
	OF booking_status
	ON Tution_Posts
	FOR EACH ROW
WHEN (OLD.booking_status IS NOT NULL AND NEW.booking_status = 'PENDING')
BEGIN
	RAISE_APPLICATION_ERROR(-20999, 'Can`t offer more than one tutor for the same tution');
END;
/

CREATE OR REPLACE TRIGGER CHECK_BATCH_LIMIT
	BEFORE INSERT
	ON EnrolledIn
	FOR EACH ROW
DECLARE	
	student_count NUMBER;
BEGIN
	IF GET_BATCH_STUDENT_COUNT(:NEW.batch_id) = GET_SEAT_COUNT(:NEW.batch_id) THEN
		RAISE_APPLICATION_ERROR(-20999, 'Batch is full');
	END IF;
END;
/

CREATE OR REPLACE TRIGGER MATCH_CLASS
	BEFORE INSERT
	ON EnrolledIn
	FOR EACH ROW
DECLARE	
student_row	STUDENT;
course_row	COURSE;
BEGIN
	student_row := GET_STUDENT_DETAILS(:NEW.student_id);
	course_row	:= GET_COURSE_DETAILS(:NEW.course_id,:NEW.batch_id);
	IF student_row.class <> course_row.class THEN
		RAISE_APPLICATION_ERROR(-20999, 'Your class doesn`t match with the course');
	END IF;
END;
/


SELECT * FROM user_errors WHERE type='TRIGGER';
-- DROP TRIGGER JOIN_REQUEST_NOTIFICATION;
CREATE OR REPLACE TRIGGER JOIN_REQUEST_NOTIFICATION
	BEFORE INSERT
	ON MemberOf
	FOR EACH ROW
WHEN (NEW.type = 'PENDING')
DECLARE
	c_name 	Coachings.name%TYPE;
	s_name 	Users.name%TYPE;
	s_image Users.image%TYPE;
	t_id   	Tutors.user_id%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE(:NEW.user_id||' '||:NEW.coaching_id);
	SELECT name INTO c_name
	FROM Coachings WHERE coaching_id = :NEW.coaching_id;
	
	SELECT name,image INTO s_name,s_image
	FROM Users 
	WHERE user_id = :NEW.user_id;
	
	SELECT user_id INTO t_id
	FROM MemberOf NATURAL JOIN Tutors
	WHERE coaching_id = :NEW.coaching_id;
	
	INSERT INTO Notifications(type,action,sender_id,entity_id,user_id,image,text,url)
	VALUES('JOIN','REQUEST',:NEW.user_id,:NEW.coaching_id,t_id,s_image,s_name||' has requested to join '||c_name,'/pending_requests?type=Join+Request&coaching='||:NEW.coaching_id||'&id=
'||:NEW.user_id);
	
	DELETE FROM Notifications
	WHERE type = 'JOIN' AND action = 'DECLINE' AND sender_id = :NEW.coaching_id AND user_id = :NEW.user_id;
END;
/

-- DROP TRIGGER REJECT_OFFER_NOTIFICATION;



-- DROP TRIGGER DECLINE_JOIN_NOTIFICATION;
-- CREATE OR REPLACE TRIGGER DECLINE_JOIN_NOTIFICATION
-- 	AFTER DELETE
-- 	ON MemberOf
-- 	FOR EACH ROW
-- WHEN (OLD.type = 'PENDING')
-- DECLARE
-- 	c_name 	Coachings.name%TYPE;
-- 	c_image Coachings.image%TYPE;
-- BEGIN
-- 	SELECT name,image INTO c_name,c_image
-- 	FROM Coachings WHERE coaching_id = :OLD.coaching_id;
-- 	
-- 	INSERT INTO Notifications(user_id,image,text,url)
-- 	VALUES(:OLD.user_id,c_image,c_name||' has declined your join request',NULL);
-- END;
-- /
-- 
-- DROP TRIGGER DECLINE_ENROLL_NOTIFICATION;
-- CREATE OR REPLACE TRIGGER DECLINE_ENROLL_NOTIFICATION
-- 	AFTER DELETE
-- 	ON EnrolledIn
-- 	FOR EACH ROW
-- WHEN (OLD.status = 'PENDING')
-- DECLARE
-- 	c_name 	Coachings.name%TYPE;
-- 	c_image Coachings.image%TYPE;
-- BEGIN
-- 	SELECT name,image INTO c_name,c_image
-- 	FROM Courses NATURAL JOIN Coachings 
-- 	WHERE course_id = :OLD.course_id;
-- 	
-- 	INSERT INTO Notifications(user_id,image,text,url)
-- 	VALUES(:OLD.student_id,c_image,c_name||' has declined your course enrollment',NULL);
-- END;
-- /
-- 

--- Prevent tutor from applying to own student's post

-- DROP TRIGGER NEW_USER ;
