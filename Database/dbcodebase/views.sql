-- details we need in the order that to show in the views --
CREATE VIEW order_details AS 
SELECT order_id, state, delivery_method, payment_method, delivery_address, estimate_days, name, SUM(order_item.price) as total_price
FROM delivery_person JOIN (order_ JOIN order_item USING (order_id)) 
USING(delivery_person_id) 
GROUP BY (order_item.order_id);

-- Which shows the items in the order --
CREATE VIEW order_items_view AS 
SELECT varient.title, COUNT(order_item.varient_id) as quantity, order_item.price, order_item.order_id 
FROM order_item JOIN (varient_item JOIN varient USING (varient_id,product_id)) 
USING (varient_id,product_id,serial_number) 
GROUP BY order_item.varient_id, order_item.product_id, order_item.order_id;

-- This view will show the items for the shop.ejs  --
CREATE VIEW shop_view_min_max AS 
SELECT category.category_id,category.category,product.product_id,product.title,varient.image_path,MIN(varient.price),MAX(varient.price) 
FROM category JOIN (product_category JOIN (product JOIN varient USING(product_id)) 
USING (product_id)) USING (category_id) 
where category.deleted=0 AND product.deleted = 0 GROUP BY product_id,category_id;





