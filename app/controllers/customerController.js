const Product = require('../models/productModel');
const Order = require('../models/orderModel');
const Category = require('../models/categoryModel');
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
        fetchProductDetails().then((result) => {
            console.log(result)
            res.render('customer_views/index', {
                pageTitle: "Home",
                path: '/',
                meta: value,
                productDetails: result,
                isAuthenticated: req.session.isLoggedIn
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

exports.track_orderAction = (req, res, next) =>{
    res.render ('customer_views/track_order',{
        pageTitle: "Track Order",
        path: "/",
        isAuthenticated: req.session.isLoggedIn
    })
};
exports.checkoutAction = (req, res, next) => {
    res.render('customer_views/checkout', {
        pageTitle: "Checkout",
        path: "/"
    })
};

/**
 * cart information is loaded to the cart page 
 * the product model is accessed 
 */

exports.cartAction = (req, res, next) => {

    // change once sessions are done----------------------------------
    // req.session.isLoggedIn = true
    req.session.cartItems = [
        { prod_id: 15731, var_id: 66376, quantity: 3 }, 
        { prod_id: 16113, var_id: 38282, quantity: 4 },
    ]
    //-----------------------------------------------------------------
    
    const fetchProducts = new Promise((resolve, reject) => {
        const custId = 13550
        if (req.session.isLoggedIn) {
            resolve((Product.getProductsFromTheCart(custId)))
        }
        else {
            resolve(Product.getProductsFromTheCartCookie(req.session.cartItems))
        }
    })


    fetchProducts
        .then((result) => {
            res.render('customer_views/cart', {
                pageTitle: "Cart",
                path: "/cart",
                isAuthenticated: req.session.isLoggedIn,
                data: result
            })
        }).catch(err => console.error(err))
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
        console.log(result[0]);
        fetchOrderItems().then((resu) => {
            console.log(resu);
            res.render('customer_views/track_order_details', {
                pageTitle: "Order Details",
                path: "/",
                order_details: result[0],
                order_items: resu,
                isAuthenticated: req.session.isLoggedIn
            })
        }).catch(err => console.error(err));
    }).catch(err => console.error(err))
};