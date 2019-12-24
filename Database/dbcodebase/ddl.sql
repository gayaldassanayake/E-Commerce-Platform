CREATE TABLE administrator(
    admin_id char(5),
    name varchar(200) NOT NULL,
    username varchar(45) NOT NULL UNIQUE,
    password varchar(255) NOT NULL,
    PRIMARY KEY(admin_id)
);

CREATE TABLE delivery_person(
    delivery_person_id char(5),
    name varchar(200) NOT NULL,
    PRIMARY KEY (delivery_person_id)
);

CREATE TABLE customer(
    customer_id char(7),
    address varchar(255) not null,
    email varchar(100) not null unique,
    name varchar(100) not null,
    username varchar(45) not null unique,
    password varchar(255) not null,
    deleted boolean not null,
    PRIMARY KEY (customer_id)
);

CREATE TABLE customer_telephone(
    customer_id char(7),
    telephone_number char(15),
    PRIMARY KEY(customer_id, telephone_number),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE credit_card_detail(
    customer_id char(7),
    credit_card_number char(16),
    cvv char(3) ,
    expire_year NUMERIC(4, 0),
    expire_month numeric(2, 0),
    name_on_card varchar(200),
    primary key (customer_id, credit_card_number),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE product(
    product_id char(6),
    title varchar(100) not null,
    description text not null,
    manufacturer varchar(50) NOT NULL,
    deleted boolean not null,
    rating numeric,
    PRIMARY KEY(product_id)
);

CREATE TABLE varient(
    product_id char(6),
    varient_id char(6),
    sku char(10) NOT NULL unique,
    title char(100) NOT NULL,
    price numeric(12, 2) NOT NULL,
    quantity int not null,
    deleted boolean not null,
    weight numeric(6, 2),
    restock_limit int not null,
    image_path varchar(255) NOT NULL,
    PRIMARY KEY(product_id, varient_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE order_(
    order_id char(7),
    state char(30) not null,
    delivery_method char(20) not null,
    payment_method char(25) not null,
    credit_card_number char(16),
    cvv char(3),
    expire_year NUMERIC(4, 0),
    expire_month numeric(2, 0),
    name_on_card varchar(200),
    delivery_address varchar(255),
    estimate_days numeric(2, 0),
    delivery_person_id char(5),
    
    PRIMARY KEY (order_id),
    FOREIGN KEY (delivery_person_id) REFERENCES delivery_person(delivery_person_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE varient_item(
    product_id char(6),
    varient_id char(6),
    serial_number char(10),
    
    availability boolean NOT NULL,
    PRIMARY KEY(product_id, varient_id, serial_number),
    FOREIGN KEY (product_id, varient_id) REFERENCES varient(product_id, varient_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE order_item(
    product_id char(6),
    varient_id char(6),
    serial_number char(10),
    order_id char(6),
    price numeric(12,2) not null,

    PRIMARY KEY(product_id, varient_id, serial_number,order_id),
    FOREIGN KEY (product_id, varient_id,serial_number) REFERENCES varient_item(product_id, varient_id,serial_number) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (order_id) REFERENCES order_(order_id) ON UPDATE CASCADE ON DELETE RESTRICT

);

CREATE TABLE category(
    category_id char(6),
    category varchar(50) not null,
    super_category_id char(6),
    deleted boolean not null,
    PRIMARY KEY(category_id),
    FOREIGN KEY(super_category_id) REFERENCES category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE product_category(
    product_id char(6),
    category_id char(6),
    PRIMARY KEY(product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(category_id) REFERENCES category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE category_specialized_attribute(
    attribute_id int AUTO_INCREMENT,
    attribute varchar(50) NOT NULL,
    category_id char(6),
    PRIMARY KEY(attribute_id, category_id),
    FOREIGN KEY(category_id) REFERENCES category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE product_category_specialized_attribute(
    product_id char(6),
    attribute_id int AUTO_INCREMENT,
    category_id char(6),
    value VARCHAR(255) NOT NULL,
    PRIMARY KEY(product_id, attribute_id, category_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (attribute_id) REFERENCES category_specialized_attribute(attribute_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(category_id) REFERENCES category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE custom_attribute(
    product_id char(6),
    varient_id char(6),
    attribute_name varchar(255) NOT NULL,
    value varchar(255) NOT NULL,
    PRIMARY KEY(attribute_name, product_id, varient_id),
    FOREIGN KEY(product_id, varient_id) REFERENCES varient(product_id, varient_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE shopping_cart_item(
    customer_id char(7),
    product_id char(6),
    varient_id char(6),
    quantity int not null,
    PRIMARY KEY(customer_id, product_id, varient_id),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(product_id, varient_id) REFERENCES varient(product_id, varient_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE comment(
    comment_id int AUTO_INCREMENT,
    customer_id char(7),
    product_id char(6),
    comment text not null,
    PRIMARY KEY (comment_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE rating(
    customer_id char(7),
    product_id char(6),
    rating int,
    PRIMARY KEY (customer_id,product_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON UPDATE CASCADE ON DELETE CASCADE
);