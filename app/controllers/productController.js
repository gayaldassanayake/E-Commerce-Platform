const Product = require('../models/productModel');


exports.getAddProduct = (req, res, next) => {
    res.render('admin_views/add-product', {
        pageTitle: 'Add Products', 
        path: '/admin/add-product',
        formsCSS: true, 
        productCSS: true, 
        activeAddProduct:true
    });
};

exports.postAddProduct = (req, res, next) => {
    const product = new Product(
        req.body.title,
        req.body.description,
        req.body.manufacturer,
        req.body.state,
        req.bdy.rating
        );
    product.save();
    res.redirect('/');
};

exports.getProducts = (req, res, next) => {
    res.render('index', {
        pageTitle: 'Shop',
        path: '/',
        activeShop: true,
        productCSS: true
    });
};

exports.viewProduct = (req, res, next) => {
    // console.log(req.params.id)

    const fetchProducts = new Promise((resolve, reject) => {
            resolve((Product.getProductDetails(req.params.id,null)))
    })


    fetchProducts
        .then(([productDetails,varient]) => {
            // console.log(varient)
            res.render('customer_views/varient_item', {
                pageTitle: 'Product',
                path: 'product/id',
                activeShop: true,
                productCSS: true,
                product: productDetails,
                varient: varient
            })
        }).catch(err => console.error(err))

}

exports.viewVarient = (req, res, next) => {
    // console.log(req.params.id,req.params.var)

    const fetchProducts = new Promise((resolve, reject) => {
            resolve((Product.getProductDetails(req.params.id,req.params.var)))
    })


    fetchProducts
        .then(([productDetails,varient]) => {
            // console.log(productDetails,varient)
            res.render('customer_views/varient_item', {
                pageTitle: 'Product',
                path: 'product/id',
                activeShop: true,
                productCSS: true,
                product: productDetails,
                varient: varient
            })
        }).catch(err => console.error(err))

}

