const { validationResult }  = require('express-validator');

const Customer = require('../models/customerModel');
const hashFunctions = require('../utils/hash_functions');
const objToDict = require('../utils/objToDict');
const errorMessage = require('../utils/errorMessage');

exports.getRegisterAction = (req, res, next) => {
    // Customer.getCustomerByUsername("Lynwood893").then((user) => {
    //     console.log(hashFunctions.checkHashed("Ruchin", user.password));
    // });

    res.render('customer_views/register',{
        pageTitle: 'Sign up',
        isAuthenticated: req.session.isLoggedIn,
        path: '/signup',
        errorMessages: false,
        prevInputs: {
            name: '',
            username: '',
            email: '',
            address: '',
            telephoneNumber: ''
        }
    });
    
}

exports.postRegisterAction = (req, res, next) => {
    const userInput = objToDict.objToDict(req.body);
    const errorMessages = validationResult(req);
    console.log(errorMessages)
    if (errorMessages.isEmpty()) {
        Customer.register(userInput).then(res.redirect('/login'));
        return res.redirect('/login');
    } else {
        return res.status(422).render('customer_views/register',{
            pageTitle: 'Sign up',
            path: '/signup',
            isAuthenticated: req.body.isLoggedIn,
            errorMessages: errorMessages.array()[0].msg,
            prevInputs: {
                name: req.body.name,
                username: req.body.username,
                email: req.body.email,
                address: req.body.address,
                telephoneNumber: req.body.telephoneNumber
            }
        });
    }  
}

exports.getLoginAction = (req, res, next) => {
    res.render('customer_views/login',{
        path: '/login',
        pageTitle: 'Login',
        errorMessage: false,
        prevInput: ''
    });
}

exports.postLoginAction = (req, res, next) => {
    const username = req.body.username;
    const password = req.body.password;
    Customer.getCustomerByUsername(username).then((user) => {
        if(user) {
            if(hashFunctions.checkHashed(password, user.password)) {
                req.session.isLoggedIn = true;
                req.session.user = user;
                req.session.user.type = "Customer";
                return req.session.save(err => {
                    if(err) {
                        console.error(err);
                    }
                    return res.redirect('/');
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

// Fuctions

const redirectToLogin = (req, res) => {
    return res.status(422).render('customer_views/login',{
        pageTitle: 'Login',
        path: '/login',
        errorMessage: "Invalid password or Username",
        prevInput: req.body.username
    });
}