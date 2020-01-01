const db = require('../utils/database');

module.exports = class Product {
    constructor(params) {
        this.id = params.id
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
                    // res = res[0]
                    console.log("Hi")
                    const product_details = res.map((each) => {
                        console.log(each)
                        return { id:null, title: each.title, description: each.description, manufacturer: null, state: null, rating: null, image_path: each.image_path, price: each.price, quantity: each.quantity }
                    })
                    console.log(product_details)
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
                // res = res[0]
                const product_details = res.map((each, i) => {
                    return { id:null, title: each.title, description: each.description, manufacturer: null, state: null, rating: null, image_path: each.image_path, price: each.price, quantity: product_list[i].quantity }
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
            resolve(db.query("SELECT distinct product_id,title,image_path,`MIN(varient.price)` as min_price,`MAX(varient.price)` as max_price FROM shop_view_min_max ORDER BY RAND()"))
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

    static getProductDetails(product_id,varient_id){
        console.log(product_id,varient_id)
        var productDetails = {}

        return new Promise((resolve => {
            var parameters = {
                'fields':['product_id','title','description','manufacturer','rating'],
                'orderby':'product_id ASC',
                'conditions':{'product_id':product_id}
            }

            db.read("product",parameters)
            .then(res => {
                res = res[0]
                var productObj = { id:res.product_id, title: res.title, description: res.description, manufacturer: res.manufacturer, state: null, rating: res.rating, image_path: null, price: null, quantity: null}
                var product = new Product(productObj)
                productDetails['product'] = product
                return productDetails

            }).then(prod =>{
                var parameters1 = {
                    'fields':['varient_id','title','image_path','restock_limit'],
                    'orderby':'varient_id ASC',
                    'conditions':{'product_id':product_id}
                }
                
                return db.read("varient",parameters1)
                
            })
            .then(varients=>{
                productDetails['varients'] = varients
                if(varient_id==null){
                    varient_id = varients.varient_id
                }

                var statement = "SELECT category.category_id, category.category from product_category,category "+
                                "where category.category_id = product_category.category_id and product_id= (?)"
                // var parameters2 = {
                //     'fields':['category_id'],
                //     'orderby':'category_id ASC',
                //     'conditions':{'product_id':product_id}
                // }

                return db.query(statement,[product_id])
                
            }).then(cat=>{
                // console.log(cat)
                productDetails['categories'] = cat

                var statement = "SELECT cat.attribute_id, attribute,value from "+
                                "category_specialized_attribute as cat, product_category_specialized_attribute as prod "+
                                "where  cat.attribute_id = prod.attribute_id and "+
                                "cat.category_id = prod.category_id and "+
                                "prod.product_id=(?) and ("
                
                for(var i=0;i<cat.length;i++){
                    statement+= " prod.category_id = (?) "
                    statement+= (i<cat.length-1)?"OR ":")"
                }

                var parameters3 = productDetails['categories'].map(category=>category["category_id"])
                
                parameters3.unshift(product_id)
                // console.log(parameters3)
                return db.query(statement,parameters3)

            })
            .then(cat_attr=>{
                // console.log(cat_attr)
                productDetails['category_attributes'] = cat_attr

                var varients = productDetails['varients'].map(varient=>varient['varient_id'])
                var statement = "SELECT varient_id,attribute_name, value from custom_attribute where product_id = (?) and ("
                
                for(var i=0;i<varients.length;i++){
                    statement+= " varient_id = (?) "
                    statement+= (i<varients.length-1)?"OR ":")"
                }
                var parameters1 = [product_id, ...varients]
                return db.query(statement,parameters1)
                
            }).then(varient_attr=>{
                productDetails['varient_attributes'] = varient_attr
                // console.log(productDetails)
                resolve([productDetails,varient_id])
            })
            .catch(err => console.error(err))

        }))
    }



    static fetchAllProductsOnCategoryForAdmin(category_id){
        return new Promise((resolve) => {
            resolve(db.query('select * from product_category_details where category_id = ?',[category_id]))
        }).catch((err) => {
            console.log(err);
        });
    }

    static fetchSingleProduct(product_id){
        return new Promise((resolve)=>{
            resolve(db.query("SELECT * FROM product WHERE product_id = ?",[product_id]))
        }).catch((err) => {
            console.log(err);
        });
    }

    static fetchAllVarientsOnProductForAdmin(product_id){
        return new Promise((resolve) => {
            resolve(db.query('select * from product_varient_details where product_id = ?',[product_id]))
        }).catch((err) => {
            console.log(err);
        });
    }
    

    static fetchSearchedProducts(query_string) {
        return new Promise((resolve,reject) => {
            resolve(db.query("SELECT * FROM varient WHERE title LIKE '%Dell%' LIMIT 10"))
            .catch(() => {
                console.log("HI");
                reject(null);
                console.log(err);
            });
        });
    }
};

