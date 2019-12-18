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
                check_on_category: req.params.id
            });
        });
    });

};

