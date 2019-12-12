// config.js
const dotenv = require('dotenv');
dotenv.config();

exports.database = {
    host: process.env.host,
    user: process.env.user,
    database: process.env.database,
    password: process.env.password
    
};

exports.sessionStorage = {
    host: process.env.host,
    port: process.env.port,
    user: process.env.user,
    password: process.env.password,
    database: process.env.database
}

exports.sessionDetails = {
    key: process.env.session_key,
    secret: process.env.secret
}