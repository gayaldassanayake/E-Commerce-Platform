const Product = require('../models/productModel');
const jsonData = require('../utils/json_reader');

exports.indexAction = (req, res, next) => {
    const promise = jsonData.jsonReader('./data/index_carousel.json');
    
    promise.then((value) =>{
        
        res.render('customer_views/index', {
            pageTitle: "Home",
            isAuthenticated: req.session.isLoggedIn, 
            path: '/',
            meta: value
        })
    });
};

exports.loginAction = (req,res, next) => {
    res.render ('customer_views/customer_login',{
        pageTitle: "Login",
        path:'/'
    });
};

exports.track_orderAction = (req, res, next) =>{
    res.render ('customer_views/track_order',{
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
                data: result
            })
            console.log("success")

        }).catch(err => console.error(err))
};


