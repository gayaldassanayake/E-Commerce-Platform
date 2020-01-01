------------------------triggers-------------------------

-- 
-- Not updating custom attributes table if 
-- the attribute is already in the category specialized attr
-- 
DELIMITER //
CREATE TRIGGER check_cat_spec_attr_before_insert_on_cust_attr BEFORE
INSERT
    ON custom_attribute FOR EACH ROW
    IF EXISTS(SELECT attribute from category_specialized_attribute WHERE attribute = NEW.attribute_name) THEN
        CALL error_procedure(2);
    END IF//
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_cat_spec_attr_before_update_on_cust_attr BEFORE
UPDATE
    ON custom_attribute FOR EACH ROW
    IF EXISTS(SELECT attribute from category_specialized_attribute WHERE attribute = NEW.attribute_name) THEN
        CALL error_procedure(2);
    END IF//
DELIMITER ;

-- 
-- 
-- updating the varient item availability , varient.quantity -1 on 
-- 

DELIMITER //
CREATE TRIGGER update_varient_on_place_order AFTER
INSERT
    ON order_item FOR EACH ROW
    BEGIN 
        UPDATE varient_item set availability = FALSE 
        WHERE varient_item.product_id = NEW.product_id and varient_item.varient_id = NEW.varient_id and varient_item.serial_number = NEW.serial_number;
        UPDATE varient SET quantity = quantity - 1 
        WHERE varient.product_id = NEW.product_id and varient.varient_id = NEW.varient_id;
    END//
DELIMITER ;

-- 
-- 
-- checking if the orderitem.price = varient.price on insert only
-- 
DELIMITER //
CREATE TRIGGER check_order_item_price_eq_varient_price BEFORE
INSERT
    ON order_item FOR EACH ROW
    IF (SELECT price from varient where varient.product_id = NEW.product_id 
        and varient.varient_id = NEW.varient_id) <> NEW.price THEN
        CALL error_procedure(2);
    END IF//
DELIMITER ;



DELIMITER //
CREATE TRIGGER user_validation
    BEFORE INSERT ON customer
    FOR EACH ROW 
 
BEGIN
BEGIN
    DECLARE n TYPE OF customer.name DEFAULT '' ;
    SET n := (SELECT name FROM customer WHERE name = NEW.name);
    IF NEW.name = n THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'name already exist';
    END IF;
    
    IF NEW.email NOT LIKE '_%@_%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email field is not valid';
    END IF;
    
    IF NOT nameCheck(NEW.name) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Name should only contain Letters";
    END IF;
 
    
END
 
 
END; //
 
DELIMITER ;



------------------------procedures-------------------------

-- call this proceudre after adding a data to the product_category table
-- this will automaticall checks and add the supercategories as well

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product_super_cateogry` (`p_id` char(6),`c_id` char(6))
	BEGIN
        declare d_count char(6);
        SELECT super_category_id into d_count FROM category where category.category_id = c_id limit 1;
        IF d_count <> NULL THEN
            INSERT INTO product_category VALUES (p_id, d_count);
        END IF;
	END;
$$

DELIMITER ;

-- 
-- Procedure to get the top sales for a given period


DELIMITER //

	CREATE PROCEDURE top_sales_proc (start_date date,end_date date)
		BEGIN
	    	(SELECT product.product_id,product.title,product.description,product.manufacturer,product.rating,COUNT(*) AS Number_of_sales FROM product,order_,order_item WHERE order_.date_>=start_date AND order_.date_<= end_date AND order_.order_id=order_item.order_id AND order_item.product_id=product.product_id GROUP BY order_item.product_id ORDER BY COUNT(*) DESC);
	    END
	//

	DELIMITER ;


DELIMITER //

CREATE PROCEDURE top_category_proc (start_date date,end_date date)
	BEGIN       
        (SELECT category.category,COUNT(*) AS No_of_sales FROM product,order_,order_item,product_category,category WHERE order_.date_>=start_date AND order_.date_<= end_date AND order_.order_id=order_item.order_id AND order_item.product_id=product.product_id AND product_category.product_id=order_item.product_id AND category.category_id=product_category.category_id GROUP By category.category ORDER BY category.category);
    END
//

DELIMITER ;


DELIMITER //

CREATE PROCEDURE product_popularity_proc (productID integer)
	BEGIN       
        (SELECT date_,COUNT(*)As no_of_sales FROM order_item,order_ WHERE order_item.product_id=productID AND order_.order_id=order_item.order_id GROUP BY order_.date_ ORDER BY date_);
    END
//

DELIMITER ;



---------------- functions -------------------------------------------

DELIMITER //
 
CREATE FUNCTION nameCheck(string varchar(20)) RETURNS boolean DETERMINISTIC
BEGIN
    IF NOT (string REGEXP '[:alpha:]') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'name can only contain strings';
        RETURN FALSE;
    END IF;
    RETURN TRUE;
END; //
 
DELIMITER ;
        
