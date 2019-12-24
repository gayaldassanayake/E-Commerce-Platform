const db = require('../utils/database');

module.exports = class Report {
    
    static getTopSoldProducts(start_date,end_date) {
        // return new Promise((resolve) => {
        //     resolve(db.query(`CALL top_sales_proc('2019-12-01','2019-12-03')`))
        // }).catch((err) => {
        //     console.log(err);
        // });


        return new Promise((resolve=>{

            new Promise((resolve)=>{
                resolve(db.query(`CALL top_sales_proc('${start_date}','${end_date}')`))
            })
            .then(res => {
                
                resolve(res)
            })
            .catch(err => console.error(err))
            
        }))
    }

};

