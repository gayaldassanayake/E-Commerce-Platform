const Product = require('../models/productModel');
const Order = require('../models/orderModel');
const Category  =require('../models/categoryModel');
const jsonData = require('../utils/json_reader');

exports.indexAction = (req, res, next) => {
    const promise = jsonData.jsonReader('./data/index_carousel.json');

    const fetchProductDetails = () => {
        return new Promise((resolve, reject) => {
            resolve((Product.fetchAllProductForIndex()));
        });
    };

    promise.then((value) => {
        console.log(value);
        fetchProductDetails().then((result)=>{
            console.log(result[0])
            res.render('customer_views/index', {
                pageTitle: "Home",
                path: '/',
                meta: value,
                productDetails : result[0]
            })
        });

    });
};

exports.loginAction = (req, res, next) => {
    res.render('customer_views/customer_login', {
        pageTitle: "Login",
        path: '/'
    });
};

exports.signupAction = (req, res, next) => {
    res.render('customer_views/customer_signup', {
        pageTitle: "Signup",
        path: '/'
    });
};

exports.track_orderAction = (req, res, next) => {
    res.render('customer_views/track_order', {
        pageTitle: "Track Order",
        path: "/"
    })
};

exports.checkoutAction = (req, res, next) => {
    res.render('customer_views/checkout', {
        pageTitle: "Checkout",
        path: "/"
    })
};

exports.cartAction = (req, res, next) => {

    // const promise = jsonData.jsonReader('')

    // res.render('cart');
};

exports.order_detailsActionPost = (req, res, next) => {
    var order_id = req.body.order_id;
    console.log(order_id);
    const fetchOrderDetails = () => {
        return new Promise((resolve, reject) => {
            resolve((Order.findOrderDetailsByOrderID(order_id)));
        });
    };
    const fetchOrderItems = () => {
        return new Promise((resolve, reject) => {
            resolve((Order.findOrderItemsByOrderID(order_id)));
        });
    };
    fetchOrderDetails().then((result) => {
        console.log(result[0][0]);
        fetchOrderItems().then((resu) => {
            console.log(resu[0]);
            res.render('customer_views/track_order_details', {
                pageTitle: "Order Details",
                path: "/",
                order_details: result[0][0],
                order_items: resu[0],
            })
        }).catch(err => console.error(err));
    }).catch(err => console.error(err))
};


exports.cartAction = (req, res, next) => {

    // Product.getProductsFromTheCart(13550)
    // .then((data)=>{
    //     console.log('data:' ,data[0]);
    // }).catch(err=>{console.log(err)})
    const fetchProducts = () => {
        return new Promise((resolve, reject) => {
            resolve((Product.getProductsFromTheCart(13550)))
        })
        // return promise
    }

    fetchProducts()
        .then((result) => {
            console.log(result[0])
            res.render('customer_views/cart', {
                pageTitle: "Cart",
                path: "/cart",
            })
        }).catch(err => console.error(err))

};

exports.shopAction = (req,res,next) => {

    const fetchCategory = () => {
        return new Promise((resolve, reject) => {
            resolve((Category.fetchAllCategoryIDAndCategory()));
        });
    };

    fetchCategory().then((result)=>{
        console.log(result[0]);
        res.render('customer_views/shop', {
            pageTitle: "Shop",
            path: '/',
            categories: result[0]
        });
    });
    
};