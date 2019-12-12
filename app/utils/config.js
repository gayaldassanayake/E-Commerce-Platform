// config.js
const dotenv = require('dotenv');
dotenv.config();
module.exports = {
    database: {
        host: process.env.host,
        user: process.env.user,
        password: process.env.password,
        name: process.env.database,
        port: process.env.port,
    }
};