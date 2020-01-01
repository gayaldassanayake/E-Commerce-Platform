const Product = require('../models/productModel');
const Order = require('../models/orderModel');
const jsonData = require('../utils/json_reader');
const userDetails = require('../data/userDetails');
const Customer = require('../models/customerModel');

exports.indexAction = (req, res, next) => {
    const promise = jsonData.jsonReader('./data/index_carousel.json');

    const fetchProductDetails = () => {
        return new Promise((resolve, reject) => {
            resolve((Product.fetchAllProductForIndex()));
        });
    };

    promise.then((value) => {
        fetchProductDetails().then((result) => {
            res.render('customer_views/index', {
                pageTitle: "Home",
                path: '/',
                meta: value,
                productDetails: result            })
        });

    });
};

exports.track_orderAction = (req, res, next) =>{
    res.render ('customer_views/track_order',{
        pageTitle: "Track Order",
        path: "/",
        isAuthenticated: req.session.isLoggedIn
    })
};

/**
 * cart information is loaded to the cart page 
 * the product model is accessed 
 */

exports.cartAction = (req, res, next) => {

    // change once sessions are done----------------------------------
    req.session.isLoggedIn = false
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
                data: result,
                isAuthenticated: req.session.isLoggedIn
            })
        }).catch(err => console.error(err))
};

exports.order_detailsActionPost = (req, res, next) => {
    var order_id = req.body.order_id;
    // console.log(order_id);
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
        fetchOrderItems().then((resu) => {
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

exports.getCheckoutAction = (req, res, next) => {
    let userDetail = userDetails;
    if (req.session.user) {
        Customer.getCustomerDetails(req.session.user.username)
        .then((results) => {
            userDetail = results
            return res.render('customer_views/checkout', {
                pageTitle: "Checkout",
                path: "/",
                userDetails : userDetail,
            })
        }).catch((err) => {
            console.error(err);
        });
    } else {
        return res.render('customer_views/checkout', {
            pageTitle: "Checkout",
            path: "/",
            userDetails : userDetail,
        });
    }
};

exports.postCheckoutAction = (req, res, next) => {   
    // console.log(req.body);
    // console.log(req.body.payment_method);
    // console.log(req.body.address_no);
    // console.log(req.body.road_name);
    // console.log(req.body.city);
    // console.log(req.body.country);
    // console.log(new Date().toISOString().slice(0,10));

    Order.saveOrder(
        "Pending", 
        req.body.delivery_method, 
        req.body.payment_method, 
        req.body.address_no, 
        req.body.road_name, 
        req.body.city, 
        req.body.country, 
        "11232", 
        new Date().toISOString().slice(0,10));
    res.redirect('/');
};
