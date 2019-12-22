const Product = require('../models/productModel');
const Order = require('../models/orderModel');
const Category = require('../models/categoryModel');
const jsonData = require('../utils/json_reader');

exports.admin_dashboardAction = (req, res, next) => {
    res.render('admin_views/admin_dashboard', {
        pageTitle: "Admin Dashboard",
        adminViewSubTitle: '',
        path: '/',
        isAuthenticated: req.session.isLoggedIn
    });
}

exports.view_categoryAction = (req, res, next) => {
    res.render('admin_views/view_category', {
        pageTitle: "View Category",
        adminViewSubTitle: 'View Category',
        path: '/',
        isAuthenticated: req.session.isLoggedIn
    });
}

exports.view_category_detailsAction = (req,res,next) =>{
    const fetchCategory = () => {
        return new Promise((resolve, reject) => {
            resolve((Category.fetch(req.body.category_id)));
        });
    };

    const fetchProducts = () => {
        return new Promise((resolve, reject) => {
            resolve((Product.fetchAllProductsOnCategoryForAdmin(req.body.category_id)));
        });
    };

    fetchCategory().then((category)=>{
        fetchProducts().then((result)=> {
            console.log(category);
            console.log(req.body.category_id);
            res.render ('admin_views/view_category_details',{
                pageTitle: "View Category Details",
                adminViewSubTitle: 'Details of Category ID '+ req.body.category_id,
                category: category,
                products: result,
                path: '/',
                isAuthenticated: req.session.isLoggedIn
            })
        })

    }).catch((err)=>{
        res.status(404).render('404', {
            pageTitle: 'Page Not Found', 
            path: '',
            isAuthenticated: req.session.isLoggedIn
        });
    })



}

exports.view_productAction = (req, res, next) => {




    res.render('admin_views/view_product', {
        pageTitle: "View Product",
        adminViewSubTitle: 'View Product',
        path: '/',
        isAuthenticated: req.session.isLoggedIn
    });
}

