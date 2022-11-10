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