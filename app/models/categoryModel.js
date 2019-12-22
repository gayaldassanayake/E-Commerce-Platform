const db = require('../utils/database');


module.exports = class Category {
    constructor(category_id, category, super_category_id, super_category,deleted) {
        this.category_id = category_id;
        this.category = category;
        this.super_category_id = super_category_id;
        this.super_category = super_category;
        this.deleted = deleted;
    }

    save() {
        db.insert('products',
            { 'category_id': this.category_id, 'category': this.category, 'super_category_id': this.super_category_id, 'deleted': this.deleted })
            .catch((err) => {
                console.log(err);
            });

    }

    static fetchAll() {
        return new Promise((resolve) => {
            resolve(db.read('category_details'))
        }).catch((err) => {
            console.log(err);
        });
    }

    static fetch(category_id){
        return new Promise((resolve) => {
            resolve(db.read('category_details',{conditions: {'category_id': category_id}}))
        }).then((result)=>{
            //console.log(result[0].category_id);
            return new Category(result[0].category_id,result[0].category,result[0].super_category_id,result[0].super_category,result[0].deleted);
        }).catch((err) => {
            console.log(err);
        });
    }

    static fetchAllCategoryIDAndCategory() {

        return new Promise((resolve) => {
            resolve(db.read('category', { fields: ['category_id', 'category'] }))
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
            resolve(db.query(select_query, [customer_id]))
        })
    }

    static createProducts(...product_details) {

    }

};

