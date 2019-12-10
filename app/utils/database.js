const mysql = require('mysql2');
const {database} = require('./config')

const pool = mysql.createPool({
    host: database.host,
    user: database.user,
    database: database.name,
    password: database.password,
});

const query = (err, conn) => {
    if (err) {
        console.log(err);
        return;
    }
    conn.query("SELECT * FROM product");

    pool.releaseConnection(conn);
};

module.exports = pool.promise();