const db = require('../utils/database');


module.exports = class Category {
    constructor(category_id, category, super_category_id, deleted) {
        this.category_id = category_id;
        this.category = category;
        this.super_category_id = super_category_id;
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
        db.read('categoty', {}).catch((err) => {
            console.log(err);
        }).then(function (data) {
            return data;
        });


        // db.query("SELECT * FROM category").then((res) => {
        //     console.log(res);
        // }).catch((err) => {
        //     console.log(err);
        // });
    }

    static fetchAllCategoryIDAndCategory() {
        // Promise promise = new Promise(db.read('category',{'fields':['category_id','category'] }).catch((err) => {
        //     console.log(err);
        // }));;

        return new Promise((resolve) => {
            resolve(db.read('category', { fields: ['category_id', 'category'] }))
        }).catch((err) => {
            console.log(err);
        });

        // db.read('category',{fields:['category_id','category'] }).then(function(data) {
        //     //console.log(data);
        //     return data;
        // });


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

    static addProductCategory(superCategoryID, title) {

        if (typeof superCategoryID !== 'undefined' && superCategoryID) {

            const check = ()=>{
                return new Promise((resolve, reject) => {
                    resolve(db.read('category',{conditions:{ category: title, deleted: 0 }}));
                });
            }

            check().then((result)=>{
                console.log(result);
                if(result.length>0){
                    return;
                }
                return new Promise((resolve, reject) => {
                    resolve(db.insert('category', { super_category_id: superCategoryID, category: title, deleted: 0 }));
                });
            });
            
        }
        else {
            const check = ()=>{
                return new Promise((resolve, reject) => {
                    resolve(db.read('category',{conditions:{ category: title, deleted: 0 }}));
                });
            }
            check().then((result)=>{
                console.log(result);
                if(result.length>0){
                    return;
                }
                return new Promise((resolve, reject) => {
                    resolve(db.insert('category', { category: title, deleted: 0 }));
                });
            });
        }
    }



    static createProducts(...product_details) {

    }

    static fetchAllProductForShop() {
        return new Promise((resolve) => {
            resolve(db.query("SELECT distinct title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max ORDER BY RAND() LIMIT 16"))
        }).catch((err) => {
            console.log(err);
        });
    }
};

