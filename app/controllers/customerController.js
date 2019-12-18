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
            console.log(result[0])
            res.render('customer_views/index', {
                pageTitle: "Home",
                path: '/',
                meta: value,
                productDetails: result[0]
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