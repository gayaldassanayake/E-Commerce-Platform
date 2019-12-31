const path = require('path');

const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const csrf = require('csurf');
const flash = require('connect-flash');

const adminRoutes = require('./routes/adminRouter');
const homeRoutes = require('./routes/homeRouter');
const shoppingRoutes = require('./routes/shopRouter');
const authRoutes = require('./routes/authRouter');
const b = require('./utils/hash_functions');

const errorController = require('./controllers/errorController');
const config = require('./utils/config');
const Customer = require('./models/customerModel');
const AccessControls = require('./data/access_controls');

const app = express();
const csrfProtection = csrf();

app.set('view engine', 'ejs');
app.set('views', 'views');

app.use((erq,res,next) => {
  // console.log(b.hash("Ruchin1"));
    next();
});
app.use(bodyParser.urlencoded({extended: false}));
app.use(express.static(path.join(__dirname, 'public'))); 
const sessionStorage = new MySQLStore(config.sessionStorage);
app.use(session({ 
    key: config.sessionDetails['key'],
    secret: config.sessionDetails['secret'],
    store: sessionStorage,
    resave: false, 
    saveUninitialized: false
}));

// app.use((req, res, next) => {
//     if(!req.session.user) {
//         console.log(req.url);
//         for (const [key, value] of Object.entries(AccessControls.guest)) {
//             if(req.url == value) {
//                 next();
//                 return;
//             }         
//         }
//         // else {
//             res.redirect('/');
//             return;
//         // }   
//     } else {
        
//         if(req.session.user.type === "Admin") {
//             for (const [key, value] of Object.entries(AccessControls.Admin)) {
//                 if(req.url == value) {
//                     next();
//                     return;
//                 } else {
//                     app.use(errorController.get404);
//                     return;
//                 }
//             }
//         }
//         if(req.session.user.type === "Customer") {
//             console.log("hi");
//             for (const [key, value] of Object.entries(AccessControls.Loggedin)) {
//                 if(req.url == value) {
//                     next();
//                     return;
//                 } else {
//                     app.use(errorController.get404);
//                     return;
//                 }
//             }
//         }
//     }
    
// });

app.use(csrfProtection);
app.use(flash());



app.use((req, res, next) => {
    if (!req.session.user) {
        return next();
    } 
    Customer.getCustomerByUsername(req.session.user.username)
        .then (user => {
            req.user = user;
            next();
        }).catch(err => console.log(err));
});

app.use((req, res, next) => {
    res.locals.isAuthenticated = req.session.isLoggedIn;
    res.locals.csrfToken = req.csrfToken();
    next();
});

app.use('/admin', adminRoutes);
app.use(homeRoutes);
app.use(authRoutes);
app.use('/shop',shoppingRoutes);
// app.use((req,res, next) => {
//     req.session.cart = "cart";
// });

app.use(errorController.get404);

app.listen(3000);
