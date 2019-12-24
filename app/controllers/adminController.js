const Product = require('../models/productModel');
const Order = require('../models/orderModel');
const Category = require('../models/categoryModel');
const jsonData = require('../utils/json_reader');
const Report = require('../models/reportModel');

exports.admin_dashboardAction = (req, res, next) => {
    res.render('admin_views/admin_dashboard', {
        pageTitle: "Admin Dashboard",
        path: '/',
        isAuthenticated: req.session.isLoggedIn
    });
}

exports.view_categoryAction = (req, res, next) => {
    res.render('admin_views/view_category', {
        pageTitle: "View Category",
        path: '/',
        isAuthenticated: req.session.isLoggedIn
    });
}

exports.view_productAction = (req, res, next) => {
    res.render('admin_views/view_product', {
        pageTitle: "View Category",
        path: '/',
        isAuthenticated: req.session.isLoggedIn
    });
}

exports.reportAction = (req,res,next) =>{
    res.render('admin_views/report',{
        pageTitle: "Admin Dashboard",
        path: '/',
        isAuthenticated: req.session.isLoggedIn
    });
}

exports.top_sold_productsAction = (req,res,next) =>{

    const fetchTopSoldProducts = () => {
        return new Promise((resolve, reject) => {
            resolve((Report.getTopSoldProducts('2019-11-01','2019-12-31')));
        });
    };

    fetchTopSoldProducts().then((result) => {

        res.render('admin_views/top_sold_products', {
            pageTitle: "Admin Dashboard",
            path: '/',
            isAuthenticated: req.session.isLoggedIn,
            table:result[0]
        })
    });
}