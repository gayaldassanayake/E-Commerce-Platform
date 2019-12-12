const mysql = require('mysql2');
const {database} = require('./config')

const pool = mysql.createPool({
    host: database.host,
    user: database.user,
    database: database.name,
    password: database.password
});

module.exports = pool.promise();