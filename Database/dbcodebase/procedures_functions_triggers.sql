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




    

