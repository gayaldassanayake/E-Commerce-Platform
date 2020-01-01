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

CREATE VIEW product_category_details as 
SELECT category_id,product_id, title, rating, number_of_sales 
from top_sales_view JOIN product_category using (product_id);

CREATE VIEW category_details as 
SELECT category.category_id,category.category,c.category as super_category, c.category_id as super_category_id, category.deleted 
from category left outer join category as c on (category.super_category_id = c.category_id);

create view product_varient_details as 
select product.product_id,varient.varient_id,sku,varient.title,varient.price,quantity,varient.deleted,weight,restock_limit,count(0) as number_of_sales 
from ((varient join product using (product_id)) join order_) join order_item where ((order_.order_id = order_item.order_id) and (order_item.varient_id = varient.varient_id)) group by order_item.varient_id order by count(0) desc limit 100;


CREATE VIEW customer_details AS
SELECT username, name, email, address_no, road_name, city, country, telephone_number
FROM customer, customer_telephone
WHERE customer.customer_id = customer_telephone.customer_id;
