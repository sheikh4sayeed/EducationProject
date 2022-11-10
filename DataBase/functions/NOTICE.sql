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
