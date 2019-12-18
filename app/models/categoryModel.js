const db = require('../utils/database');

module.exports = class Category {
    constructor(category_id, category, super_category_id, deleted) {
        this.category_id = category_id;
        this.category= category;
        this.super_category_id = super_category_id;
        this.deleted = deleted;
    }

    save() {
        db.execute('INSERT INTO products (category_id, category, super_category_id, deleted) VALUES (?,?,?,?)',
            [this.category_id, this.category, this.super_category_id, this.deleted]
        );
    }

    static fetchAll() {
        db.execute("SELECT * FROM category").then((res) => {
            console.log(res);
        }).catch((err) => {
            console.log(err);
        });
    }

    static fetchAllCategoryIDAndCategory(){
        return new Promise((resolve)=>{
            resolve(db.execute("SELECT category_id,category from category"))
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

    static fetchAllProductForShop() {
        return new Promise((resolve) => {
            resolve(db.execute("SELECT distinct title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max ORDER BY RAND() LIMIT 16"))
        }).catch((err) => {
            console.log(err);
        });
    }
};

