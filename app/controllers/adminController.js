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

exports.view_loginAction = (req, res, next) => {
    res.render('admin_views/admin_login', {
        pageTitle: "Admin Login",
        path: '/',
        //isAuthenticated: req.session.isLoggedIn
    });
}

exports.add_adminAction = (req, res, next) => {
    res.render('admin_views/add_admin', {
        pageTitle: "Add Admin",
        path: '/',
        //isAuthenticated: req.session.isLoggedIn
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

exports.reportAction = (req, res, next) => {
    res.render('admin_views/report', {
        pageTitle: "Admin Dashboard",
        path: '/',
        isAuthenticated: req.session.isLoggedIn
    });
}

exports.top_sold_productsAction = (req, res, next) => {

    var end_date = new Date().toISOString().slice(0, 10);
    var start_date = new Date(new Date().setDate(new Date().getDate() - 30)).toISOString().slice(0, 10);

    const fetchTopSoldProducts = () => {
        return new Promise((resolve, reject) => {
            resolve((Report.getTopSoldProducts(start_date, end_date)));
        });
    };

    fetchTopSoldProducts().then((result) => {

        res.render('admin_views/top_sold_products', {
            pageTitle: "Admin Dashboard",
            path: '/',
            isAuthenticated: req.session.isLoggedIn,
            table: result[0],
            reportText: "Top sales from " + start_date + " to " + end_date
        })
    });
}

exports.top_sold_productsPOSTAction = (req, res, next) => {

    const fetchTopSoldProducts = () => {
        return new Promise((resolve, reject) => {
            resolve((Report.getTopSoldProducts(req.body.start_date, req.body.end_date)));
        });
    };

    fetchTopSoldProducts().then((result) => {

        res.render('admin_views/top_sold_products', {
            pageTitle: "Admin Dashboard",
            path: '/',
            isAuthenticated: req.session.isLoggedIn,
            table: result[0],
            reportText: "Top sales from " + req.body.start_date + " to " + req.body.end_date
        })
    });
}

exports.view_category_detailsAction = (req, res, next) => {
    var category_id = req.body.category_id;
    console.log(category_id);
    const fetchCategoryDetails = () => {
        return new Promise((resolve, reject) => {
            resolve((Category.fetchAllDetailsCategoryForViewCateogryDetails(category_id)));
        });
    };
    const fetchProduts = () => {
        return new Promise((resolve, reject) => {
            resolve((Product.fetchAllProductsOnCategoryForAdmin(category_id)));
        });
    };
    fetchCategoryDetails().then((result) => {
        console.log(result[0]);
        fetchProduts().then((resu) => {
            console.log(resu);
            res.render('admin_views/view_category_details', {
                pageTitle: "Category Details",
                path: "/",
                category: result[0],
                products: resu
            })
        }).catch(err => console.error(err));
    }).catch(err => console.error(err))
}