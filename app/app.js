const path = require('path');

const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);

const adminRoutes = require('./routes/admin');
const shopRoutes = require('./routes/home');

const errorController = require('./controllers/errorController');

const app = express();


app.set('view engine', 'ejs');
app.set('views', 'views');

app.use(bodyParser.urlencoded({extended: false}));
app.use(express.static(path.join(__dirname, 'public'))); 
const sessionStorage = new MySQLStore({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '',
    database: 'ecom_db'
});
app.use(session({ 
    key: 'session_cookie_name',
    secret: 'laeslfn',
    store: sessionStorage,
    resave: false, 
    saveUninitialized: false
}));

app.use('/admin', adminRoutes);
app.use(shopRoutes);

app.use(errorController.get404);

app.listen(3000);
