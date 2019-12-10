const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    database: 'e_commerce',
    password: 'ruchin123',
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