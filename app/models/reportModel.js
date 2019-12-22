const db = require('../utils/database');

module.exports = class Report {
    
    static getTopSoldProducts() {
        return new Promise((resolve) => {
            resolve(db.read('top_sales_view',{}))
        }).catch((err) => {
            console.log(err);
        });
    }

};

