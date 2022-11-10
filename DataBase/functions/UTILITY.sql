
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



CREATE OR REPLACE FUNCTION GET_USER_BY_ID (id Users.user_id%TYPE)
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







