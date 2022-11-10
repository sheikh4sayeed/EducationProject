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
