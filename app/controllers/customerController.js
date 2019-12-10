const Product = require('../models/productModel');
const jsonData = require('../utils/json_reader');

exports.indexAction = (req, res, next) => {
    const promise = jsonData.jsonReader('./data/index_carousel.json');

    promise.then((value) =>{
        console.log(value);
        res.render('customer_views/index', {
            pageTitle: "Home",
            path: '/',
            meta: value
        })
    });
};

exports.cartAction = (req, res, next) => {
    // const promise = jsonData.jsonReader('')

    // res.render('cart');
};