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


