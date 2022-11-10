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