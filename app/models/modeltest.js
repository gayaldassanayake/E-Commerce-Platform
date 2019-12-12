const db = require('../utils/database');


module.exports = class Model {

    static getAllCustomers = () => {
        return db.getConnection().then(conn => {
            return new Promise((resolve,reject) => {
                conn.query("SELECT * FROM customer", (err, results, fields) => {
                    conn.release();
                    if (err) {
                        reject(()=>console.error(err));
                    }
                    // console.log(results);
                    resolve(results); 
                });
            });
        });
    };

    save = () => {

    }



};
