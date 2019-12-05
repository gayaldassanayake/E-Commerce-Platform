--------------------------- ERROR PROCEDURE ---------------------------------------------

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `error_procedure` (`pval` INT)  BEGIN
  IF pval = 0 THEN
    SIGNAL SQLSTATE '23513'
    SET MESSAGE_TEXT = 'Violation of attribute size constraint';
  ELSEIF pval = 1 THEN
    SIGNAL SQLSTATE '23513'
    SET MESSAGE_TEXT = 'Violation of attribute range constraint';
  ELSEIF pval = 2 THEN
    SIGNAL SQLSTATE '23513'
    SET MESSAGE_TEXT = 'Invalid value for an attribute';
  ELSE
    SIGNAL SQLSTATE '45000';
  END IF;
END$$

DELIMITER ;


----------------------------- TRIGGERS FOR CHECKS ------------------------------------------

-- CREDIT CARD CHECKS
DELIMITER //
CREATE TRIGGER credit_card_validation_on_insert BEFORE
INSERT
    ON credit_card_detail FOR EACH ROW 
    IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    END IF //
DELIMITER ;


DELIMITER //
CREATE TRIGGER credit_card_validation_on_update BEFORE
UPDATE
    ON credit_card_detail FOR EACH ROW 
    IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    END IF //
DELIMITER ;

-- VARIENT CHECKS

DELIMITER //
CREATE TRIGGER varient_validation_on_insert BEFORE
INSERT
    ON varient FOR EACH ROW 
    IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.weight <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.restock_limit THEN
        CALL error_procedure(1);
    END IF //
DELIMITER ;


DELIMITER //
CREATE TRIGGER varient_validation_on_update BEFORE
UPDATE
    ON varient FOR EACH ROW 
    IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.weight <0 THEN
        CALL error_procedure(1);
    ELSEIF NEW.restock_limit THEN
        CALL error_procedure(1);
    END IF //
DELIMITER ;


-- ORDER CHECKS
DELIMITER //
CREATE TRIGGER order_validation_on_insert BEFORE
INSERT
    ON `order` FOR EACH ROW 
    IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    ELSEIF NEW.state not in (
            'Pending',
            'Deliverying',
            'Delivered',
            'Waiting for Customer'
        ) THEN
        CALL error_procedure(2);
    ELSEIF NEW.delivery_method not in ('Store Pickup', 'Delivered') THEN
        CALL error_procedure(2);
    ELSEIF NEW.payment_method not in ('Credit Card', 'Cash on Delivery') THEN
        CALL error_procedure(2);
        END IF //
DELIMITER ;


DELIMITER //
CREATE TRIGGER order_validation_on_update BEFORE
UPDATE
    ON `order` FOR EACH ROW 
    IF LENGTH(NEW.credit_card_number) <> 16 THEN
        CALL error_procedure(0);
    ELSEIF LENGTH(NEW.cvv) <> 3 THEN
        CALL error_procedure(0);
    ELSEIF NEW.expire_year <= 1950 OR NEW.expire_year >=2100 THEN
        CALL error_procedure(1);
    ELSEIF NEW.expire_month < 1 OR NEW.expire_month > 12 THEN
        CALL error_procedure(1);
    ELSEIF NEW.state not in (
            'Pending',
            'Deliverying',
            'Delivered',
            'Waiting for Customer'
        ) THEN
        CALL error_procedure(2);
    ELSEIF NEW.delivery_method not in ('Store Pickup', 'Delivered') THEN
        CALL error_procedure(2);
    ELSEIF NEW.payment_method not in ('Credit Card', 'Cash on Delivery') THEN
        CALL error_procedure(2);
        END IF //
DELIMITER ;


-- SHOPPING_CART_ITEM CHECK
DELIMITER //
CREATE TRIGGER shopping_cart_item_validation_on_insert BEFORE
INSERT
    ON shopping_cart_item FOR EACH ROW 
    IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    END IF //
DELIMITER ;

DELIMITER //
CREATE TRIGGER shopping_cart_item_validation_on_update BEFORE
UPDATE
    ON shopping_cart_item FOR EACH ROW 
    IF NEW.quantity <0 THEN
        CALL error_procedure(1);
    END IF //
DELIMITER ;



-- DELIVERY_DETAIL CHECK

DELIMITER //
CREATE TRIGGER delivery_detail_validation_on_insert BEFORE
INSERT
    ON delivery_detail FOR EACH ROW 
    IF NEW.estimate_days <0 THEN
        CALL error_procedure(1);
    END IF //
DELIMITER ;

DELIMITER //
CREATE TRIGGER delivery_detail_validation_on_update BEFORE
UPDATE
    ON delivery_detail FOR EACH ROW 
    IF NEW.estimate_days <0 THEN
        CALL error_procedure(1);
    END IF //
DELIMITER ;






























