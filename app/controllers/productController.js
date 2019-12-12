const Product = require('../models/productModel');

exports.getAddProduct = (req, res, next) => {
    res.render('admin_views/add-product', {
        pageTitle: 'Add Products', 
        path: '/admin/add-product',
        isAuthenticated: req.session.isLoggedIn, 
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
        isAuthenticated: req.session.isLoggedIn,
        activeShop: true,
        productCSS: true
    });
};