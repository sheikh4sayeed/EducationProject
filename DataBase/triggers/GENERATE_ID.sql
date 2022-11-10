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
