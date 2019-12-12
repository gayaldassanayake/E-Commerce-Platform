const Product = require('../models/productModel');
const jsonData = require('../utils/json_reader');

exports.indexAction = (req, res, next) => {
    const promise = jsonData.jsonReader('./data/index_carousel.json');
    
    promise.then((value) =>{
        console.log(req.session);
        res.render('customer_views/index', {
            pageTitle: "Home",
            path: '/',
            meta: value
        })
    });
};

exports.cartAction = (req, res, next) => {

};

exports.getRegisterAction = (req, res, next) => {
    
    res.render('customer_views/register');
    
}

exports.postRegisterAction = (req, res, next) => {

}

exports.getLoginAction = (req, res, next) => {
    res.render('customer_views/login',{
        path: '/login',
        pageTitle: 'Login'
    });
}

exports.postLoginAction = (req, res, next) => {
    req.session.isLoggedIn = true;
    res.redirect('/');
}