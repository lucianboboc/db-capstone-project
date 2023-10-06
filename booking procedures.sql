-- Task1:
CREATE PROCEDURE GetMaxQuantity()
SELECT MAX(quantity) FROM orders;

-- Task 2: 
PREPARE GetOrderDetail FROM "SELECT order_id, quantity, total FROM orders WHERE customer_id = ?";

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- Task 3:
CREATE PROCEDURE CancelOrder(IN order_id INT)
SELECT CONCAT("Order ", order_id, " is cancelled") AS Confirmation;

CALL CancelOrder(5);

-------------------------------------------------- 
--------------------------------------------------

-- Task1:
INSERT INTO bookings 
	(booking_id, date, table_no, customer_id) 
VALUES 
	(1, "2022-10-10", 5, 1),
    (2, "2022-11-12", 3, 3),
    (3, "2022-10-11", 2, 2),
    (4, "2022-10-13", 2, 1);


-- Task2:
DELIMITER $$
CREATE PROCEDURE CheckBooking(booking_date DATE, table_nr INT)
BEGIN
	DECLARE table_number INT DEFAULT 0;
    DECLARE booking_count INT DEFAULT 0;
    SELECT COUNT(table_no) INTO table_number FROM bookings WHERE table_no = table_nr;
    IF table_number > 0 THEN
		SELECT COUNT(booking_date) INTO booking_count FROM bookings WHERE date = booking_date AND table_no = table_nr;
		IF booking_count > 0 THEN
			SELECT CONCAT("Table ", table_nr, " is already booked") AS "Booking status";
		ELSE
			SELECT CONCAT("Table ", table_nr, " is available") AS "Booking status";
		END IF;
    ELSE
		SELECT CONCAT("Table ", table_nr, " doesn't exist") AS "Booking status";
    END IF;
END$$
DELIMITER ;


-- Task3:
DELIMITER $$
CREATE PROCEDURE AddValidBooking(booking_date DATE, table_nr INT)
proc_label:BEGIN
    DECLARE booking_count INT DEFAULT 0;
	DECLARE table_count INT DEFAULT 0;

	START TRANSACTION;    
    SELECT COUNT(table_no) INTO table_count FROM bookings WHERE table_no = table_nr;
    IF table_count > 0 THEN
		SELECT COUNT(date) INTO booking_count FROM bookings WHERE date = booking_date AND table_no = table_nr;
        IF booking_count = 0 THEN
			INSERT INTO bookings (date, table_no) VALUES (booking_date, table_nr);
            COMMIT;
            SELECT CONCAT("Table ", table_nr, " booked successfully");
			LEAVE proc_label;
        END IF;
    END IF;
		
	SELECT CONCAT("Table ", table_nr, " is already booked - booking cancelled");
	ROLLBACK;
END$$

DELIMITER ;


-------------------------------------------------- 
--------------------------------------------------


-- Task1:
DELIMITER $$
CREATE PROCEDURE AddBooking(booking_id INT, customer_id INT, booking_date DATE, table_nr INT)
BEGIN
	INSERT INTO bookings (booking_id, date, table_no, customer_id) VALUES (booking_id, booking_date, table_nr, customer_id);
END$$
DELIMITER ;

-- Task2:
DELIMITER $$
CREATE PROCEDURE UpdateBooking(booking_id INT, booking_date DATE)
BEGIN
	UPDATE bookings SET date = booking_date WHERE booking_id = booking_id;
END$$

DELIMITER ;

-- Task3:
DELIMITER $$
CREATE PROCEDURE CancelBooking(booking_id INT)
BEGIN
	DELETE FROM bookings WHERE booking_id = booking_id;
END$$

DELIMITER ;