const Customer = require('../models/customerModel');
const hash = require('../utils/hash_functions');
const objToDict = require('../utils/objToDict');

exports.getRegisterAction = (req, res, next) => {
    Customer.login("Lynwood893","Ruchin");
    
    res.render('customer_views/register',{
        pageTitle: 'Sign up',
        isAuthenticated: req.session.isLoggedIn,
        path: '/signup'
    });
    
}

exports.postRegisterAction = (req, res, next) => {
    const userInput = objToDict.objToDict(req.body);
    const validation = true;
    if (validation) {
        Customer.register(userInput).then(res.redirect('/login'));
    } else {
        console.log("Not Correct !")
    }
    
}

exports.getLoginAction = (req, res, next) => {
    res.render('customer_views/login',{
        path: '/login',
        isAuthenticated: req.session.isLoggedIn,
        pageTitle: 'Login'  
    });
}

exports.postLoginAction = (req, res, next) => {
    req.session.isLoggedIn = true;
    res.redirect('/');
}

exports.postLogoutAction = (req, res, next) => {
    req.session.destroy((err) => {
        if(err) console.error(err);
        res.redirect('/');
    });
}