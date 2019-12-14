const db = require('../utils/database');

module.exports = class Product {
    constructor(title, description, manufacturer, state, rating) {
        this.title = title;
        this.description = description;
        this.manufacturer = manufacturer;
        this.state = state;
        this.rating = rating;
    }

    save() {
        db.execute('INSERT INTO products (title, description, manufacturer, state, rating) VALUES (?,?,?,?,?,?)',
            [this.title, this.description, manufacturer, this.state, this.rating]
        );
    }

    static fetchAll() {
        db.execute("SELECT * FROM product").then((res) => {
            console.log(res);
        }).catch((err) => {
            console.log(err);
        });
    }

    static getProductsFromTheCart(customer_id) {
        const select_query = "SELECT varient.title,varient.image_path,product.description, varient.price, shopping_cart_item.quantity " +
            "FROM product,varient,shopping_cart_item WHERE "
            + "product.product_id = shopping_cart_item.product_id and "
            + "varient.varient_id = shopping_cart_item.varient_id and "
            + "varient.product_id = shopping_cart_item.product_id and "
            + "shopping_cart_item.customer_id =(?)"
        return new Promise((resolve, reject) => {
            resolve(db.execute(select_query, [customer_id]))
        })
    }



    static createProducts(...product_details) {

    }

    static fetchAllProductForIndex() {
        return new Promise((resolve) => {
            resolve(db.execute("SELECT distinct title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max ORDER BY RAND() LIMIT 16"))
        }).catch((err) => {
            console.log(err);
        });
    }

    static fetchAllProductForShop() {
        return new Promise((resolve) => {
            resolve(db.execute("SELECT distinct title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max ORDER BY RAND()"))
        }).catch((err) => {
            console.log(err);
        });
    }

    static fetchAllProductsOnCategory(category_id){
        return new Promise((resolve) => {
            resolve(db.execute("SELECT title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max where category_id = ? ORDER BY RAND()",[category_id]))
        }).catch((err) => {
            console.log(err);
        });
    }
};

