const Product = require('../models/productModel');
const jsonData = require('../utils/json_reader');

exports.indexAction = (req, res, next) => {
    const promise = jsonData.jsonReader('./data/index_carousel.json');
    
    promise.then((value) =>{
        
        res.render('customer_views/index', {
            pageTitle: "Home",
            path: '/',
            meta: value
        })
    });
};


exports.track_orderAction = (req, res, next) =>{
    res.render ('customer_views/track_order',{
        pageTitle: "Track Order",
        path: "/"
    })
};
exports.checkoutAction = (req, res, next) => {
    res.render ('customer_views/checkout',{
        pageTitle: "Checkout",
        path: "/"
    })
};
exports.cartAction = (req, res, next) => {
    // Product.getProductsFromTheCart(13550)
    // .then((data)=>{
    //     console.log('data:' ,data[0]);
    // }).catch(err=>{console.log(err)})
    const fetchProducts = ()=>{
        return new Promise((resolve,reject)=>{
             resolve((Product.getProductsFromTheCart(13550)))
        })
        // return promise
    }
     
    fetchProducts()
            console.log(result[0])
        .then((result)=>{
            res.render('customer_views/cart',{
                pageTitle: "Cart",
                path: "/cart",
            })
        }).catch(err=>console.error(err))
    
};


