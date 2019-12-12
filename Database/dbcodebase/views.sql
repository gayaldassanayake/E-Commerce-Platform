-- details we need in the order that to show in the views --
CREATE VIEW order_details AS 
SELECT order_id, state, delivery_method, payment_method, delivery_address, estimate_days, name, SUM(order_item.price) as total_price
FROM delivery_person JOIN (order_ JOIN order_item USING (order_id)) 
USING(delivery_person_id) 
GROUP BY (order_item.order_id);

-- Which shows the items in the order --
CREATE VIEW order_items_view AS SELECT varient.title, COUNT(order_item.order_id) as quantity, order_item.price, order_item.order_id 
FROM order_item JOIN (varient_item JOIN varient USING (varient_id,product_id)) 
USING (varient_id,product_id,serial_number) 
GROUP BY (order_item.order_id);