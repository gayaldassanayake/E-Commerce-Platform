const db = require('../utils/database');

module.exports = class Product {
    constructor(params) {
        this.title = params.title;
        this.description = params.description;
        this.manufacturer = params.manufacturer;
        this.state = params.state;
        this.rating = params.rating;
        this.image_path = params.image_path
        this.price = params.price
        this.quantity = params.quantity

    }

    save() {
        db.query('INSERT INTO products (title, description, manufacturer, state, rating) VALUES (?,?,?,?,?,?)',
            [this.title, this.description, manufacturer, this.state, this.rating, this.image_path, this.price, this.quantity]
        );
    }

    static addProduct(params) {

        const connection = db.getConnection();

        connection.beginTransaction(function (err) {
            if (err) { throw err; }
            connection.query('INSERT INTO product(title,description,manufacturer,deleted,rating) VALUES(?,?,?,?,?)', [params.title, params.description, params.manufacturer, 0, 0], function (error, results, fields) {
                if (error) {
                    return connection.rollback(function () {
                        throw error;
                    });
                }

                // var log = 'Post ' + results.insertId + ' added';
                var productID = results.insertId;
                console.log(results.insertId);

                connection.query('INSERT INTO varient (product_id,sku,title,price,quantity,deleted,weight,restock_limit,image_path) VALUES(?,?,?,?,?,?,?,?,?)', [results.insertId, params.sku, params.varientTitle, params.price, params.quantity, 0, params.weight, params.restockLimit, params.imagePath], function (error, results, fields) {
                    if (error) {
                        return connection.rollback(function () {
                            throw error;
                        });
                    }

                    var valuesArr = [];
                    var paramterArr = [];
            
                    if (Array.isArray(params.category)) {
                        for (var categoryID in params.category) {
                            console.log(categoryID);
                            if (categoryID) {
                                valuesArr.push('(?,?)');
                                paramterArr.push(productID);
                                paramterArr.push(params.category[categoryID]);
                            }

                        }
                    }
                    else {
                        valuesArr.push('(?,?)');
                        paramterArr.push(productID);
                        paramterArr.push(params.category);
                    }

                    connection.query(`INSERT INTO product_category(product_id,category_id) VALUES ${valuesArr.join(',')}`, paramterArr, function (error, results, fields) {

                        if (error) {
                            return connection.rollback(function () {
                                throw error;
                            });
                        }

                        connection.commit(function (err) {
                            if (err) {
                                return connection.rollback(function () {
                                    throw err;
                                });
                            }
                            console.log('success!');
                        });
                    });
                });
            });
        });
    }

    static fetchAll() {
        db.query("SELECT * FROM product").then((res) => {
            console.log(res);
        }).catch((err) => {
            console.log(err);
        });
    }


    /**
     * the cart,varient,product tables are accessed and cart info sent to the customerController
     * a promise returned
     */
    static getProductsFromTheCart(customer_id) {
        const select_query = "SELECT varient.title,varient.image_path,product.description, varient.price, shopping_cart_item.quantity " +
            "FROM product,varient,shopping_cart_item WHERE "
            + "product.product_id = shopping_cart_item.product_id and "
            + "varient.varient_id = shopping_cart_item.varient_id and "
            + "varient.product_id = shopping_cart_item.product_id and "
            + "shopping_cart_item.customer_id =(?)"


        return new Promise((resolve) => {

            new Promise((resolve) => {
                resolve(db.query(select_query, [customer_id]))
            })
                .then(res => {
                    res = res[0]
                    const product_details = res.map((each) => {
                        return { title: each.title, description: each.description, manufacturer: null, state: null, rating: null, image_path: each.image_path, price: each.price, quantity: each.quantity }
                    })
                    resolve(this.createProducts(product_details))
                })
                .catch(err => err)

        })
    }


    /**
    * For unlogged user the varient,prod ids are taken from the cookie session,
    * the varient,product tables are accessed and cart info sent to the customerController
    * a promise returned
    */
    static getProductsFromTheCartCookie(product_list) {
        var select_query = "SELECT varient.title,varient.image_path,product.description, varient.price " +
            "FROM product,varient WHERE "
            + "product.product_id = varient.product_id AND("
        var bind_params = []

        for (var i = 0; i < product_list.length; i++) {
            select_query += " (varient.product_id =(?) AND varient.varient_id =(?))"
            select_query += (i < product_list.length - 1) ? " OR" : ")"
            bind_params = [...bind_params, product_list[i].prod_id, product_list[i].var_id]
        }
        return new Promise((resolve => {

            new Promise((resolve) => {
                resolve(db.query(select_query, bind_params))
            })
                .then(res => {
                    res = res[0]
                    const product_details = res.map((each, i) => {

                        return { title: each.title, description: each.description, manufacturer: null, state: null, rating: null, image_path: each.image_path, price: each.price, quantity: product_list[i].quantity }
                    })
                    resolve(this.createProducts(product_details))
                })
                .catch(err => console.error(err))

        }))

    }

    /**
     *  array of attr is passed to create a list of product objects
     * 
     */
    static createProducts(product_details) {
        const product_list = product_details.map(
            product => new Product(product)
        )
        return product_list
    }

    static fetchAllProductForIndex() {
        return new Promise((resolve) => {
            resolve(db.query("SELECT distinct title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max ORDER BY RAND() LIMIT 16"))
        }).catch((err) => {
            console.log(err);
        });
    }

    static fetchAllProductForShop() {
        return new Promise((resolve) => {
            resolve(db.query("SELECT distinct title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max ORDER BY RAND()"))
        }).catch((err) => {
            console.log(err);
        });

        // db.query("SELECT distinct title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max ORDER BY RAND()").then(function(data){
        //     return data;
        // })

    }

    static fetchAllProductsOnCategory(category_id) {
        return new Promise((resolve) => {
            resolve(db.query("SELECT title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max where category_id = ? ORDER BY RAND()", [category_id]))
        }).catch((err) => {
            console.log(err);
        });
    }
};

