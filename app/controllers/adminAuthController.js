const { validationResult }  = require('express-validator');

const Customer = require('../models/customerModel');
const Admin = require('../models/adminModel');
const hashFunctions = require('../utils/hash_functions');
const objToDict = require('../utils/objToDict');
const errorMessage = require('../utils/errorMessage');


const redirectToLogin = (req, res) => {
    return res.status(422).render('admin_views/admin_login',{
        pageTitle: 'Admin Login',
        path: '/login',
        errorMessages: "Invalid password or Username",
        prevInput: req.body.username
    });
}

// Admininstrator Auth Settings

exports.getAdminRegisterAction = (req, res, next) => {
    res.render('admin_views/add_admin',{
        pageTitle: 'Add Admin',
        isAuthenticated: req.session.isLoggedIn,
        path: '/signup',
        errorMessages: false,
        prevInputs: {
            username: ''
        }
    });   
}

exports.postRegisterAction = (req, res, next) => {
    const userInput = objToDict.objToDict(req.body);
    const errorMessages = validationResult(req);
    console.log(errorMessages)
    if (errorMessages.isEmpty()) {
        Admin.insert(userInput).then(res.redirect('/admin'));
        //return res.redirect('/admin');
    } else {
        return res.status(422).render('admin_views/add_admin',{
            pageTitle: 'Add Admin',
            path: '/signup',
            errorMessages: errorMessages.array()[0].msg,
            prevInputs: {
                name: req.body.name,
                username: req.body.username
            }
        });
    }  
}

exports.view_loginAction = (req, res, next) => {
    res.render('admin_views/admin_login', {
        pageTitle: "Admin Login",
        path: '/',
        errorMessages: false,
        prevInput: ''
    });
}

exports.postLoginAction = (req, res, next) => {
    const username = req.body.username;
    const password = req.body.password;
    Admin.getAdminUserName(username).then((user) => {
        if(user) {
            if(hashFunctions.checkHashed(password, user.password)) {
                req.session.isLoggedIn = true;
                req.session.user = user;
                req.session.user.type = "Admin";
                return req.session.save(err => {
                    if(err) {
                        console.error(err);
                    }
                    return res.redirect('/admin');
                });
            } else { 
                redirectToLogin(req, res);
            }
        } else {
            redirectToLogin(req, res);
        }
    }).catch((err) => {
        if(err) {
            redirectToLogin(req, res);
        }
    });

}

exports.postLogoutAction = (req, res, next) => {
    req.session.destroy((err) => {
        if(err) console.error(err);
        res.redirect('/');
    });
}
