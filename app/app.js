const path = require('path');

const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);

const adminRoutes = require('./routes/adminRouter');
const homeRoutes = require('./routes/homeRouter');
const shoppingRoutes = require('./routes/shopRouter');
const authRoutes = require('./routes/authRouter');
const b = require('./utils/hash_functions');

const errorController = require('./controllers/errorController');
const config = require('./utils/config');

const app = express();

app.set('view engine', 'ejs');
app.set('views', 'views');

// app.use((erq,res,next) => {
//     console.log(b.hash("Ruchin1"));e
//     next();
// });
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

app.use('/admin', adminRoutes);
app.use(homeRoutes);
app.use(authRoutes);
// app.use('/shop',shoppingRoutes);


app.use(errorController.get404);

app.listen(3000);
