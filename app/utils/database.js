const mysql = require('mysql2');
const config = require('./config')

const pool = mysql.createPool(config.database);

module.exports = pool.promise();