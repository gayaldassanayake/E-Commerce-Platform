const Product = require('../models/productModel');
const Order = require('../models/orderModel');
const Category = require('../models/categoryModel');
const jsonData = require('../utils/json_reader');

exports.shopAction = (req, res, next) => {
    const fetchCategory = () => {
        return new Promise((resolve, reject) => {
            resolve((Category.fetchAllCategoryIDAndCategory()));
        });
    };

    const fetchProducts = () => {
        return new Promise((resolve, reject) => {
            resolve((Product.fetchAllProductForShop()));
        });
    };

    fetchProducts().then((resu) => {
        fetchCategory().then((result) => {
            console.log(result[0]);
            console.log(resu[0])
            res.render('customer_views/shop', {
                pageTitle: "Shop",
                path: '/',
                categories: result[0],
                products: resu[0],
                check_on_category: null,
                isAuthenticated: req.session.isLoggedIn
            });
        });
    });
};

exports.shopCategoryAction = (req, res, next) => {
    const fetchCategory = () => {
        return new Promise((resolve, reject) => {
            resolve((Category.fetchAllCategoryIDAndCategory()));
        });
    };

    fetchCategory().then((result)=>{
        var c = 0;
        for (var i = 0; i<result[0].length ; i++){
            if (result[0][i].category_id==req.params.id){
                c = 1;
                break;
                
            }
        }
        if (c==0){
            res.status(404).render('404', {
                pageTitle: 'Page Not Found', 
                path: '',
                isAuthenticated: req.session.isLoggedIn
            });
        }
    });

    const fetchProducts = () => {
        return new Promise((resolve, reject) => {
            resolve((Product.fetchAllProductsOnCategory(req.params.id)));
        });
    };

    fetchProducts().then((resu) => {
        fetchCategory().then((result) => {
            console.log(result[0]);
            console.log(resu[0])
            res.render('customer_views/shop', {
                pageTitle: "Shop",
                path: '/',
                categories: result[0],
                products: resu[0],
                check_on_category: req.params.id,
                isAuthenticated: req.session.isLoggedIn
            });
        });
    });

};

