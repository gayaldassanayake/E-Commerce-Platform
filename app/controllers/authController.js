const Customer = require('../models/customerModel');
const hashFunctions = require('../utils/hash_functions');
const objToDict = require('../utils/objToDict');

exports.getRegisterAction = (req, res, next) => {
    Customer.getCustomerByUsername("Lynwood893").then((user) => {
        console.log(hashFunctions.checkHashed("Ruchin", user.password));
    });
    
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
    const username = req.body.username;
    const password = req.body.password;
    // console.log(username);
    // console.log(password);
    Customer.getCustomerByUsername(username).then((user) => {
        if(user) {
            if(hashFunctions.checkHashed(password, user.password)) {
                req.session.isLoggedIn = true;
                req.session.user = user;
                return req.session.save(err => {
                    if(err) {
                        console.error(err);
                    }
                    return res.redirect('/');
                });
            } else {
                console.error("Password Incorrect !");
                res.redirect('/login');
            }
        }
    }).catch((err) => {
        if (err) {
            console.log("User doesn't exists! Please try Again");
            res.redirect('/login');
        }
    });
}

exports.postLogoutAction = (req, res, next) => {
    req.session.destroy((err) => {
        if(err) console.error(err);
        res.redirect('/');
    });
}