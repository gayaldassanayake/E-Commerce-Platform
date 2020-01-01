const db = require('../utils/database');

module.exports = class Report {
    
    static getTopSoldProducts(start_date,end_date) {

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

    static getTopCategory(start_date,end_date) {

        return new Promise((resolve=>{

            new Promise((resolve)=>{
                resolve(db.query(`CALL top_category_proc('${start_date}','${end_date}')`))
            })
            .then(res => {
                
                resolve(res)
            })
            .catch(err => console.error(err))
            
        }))
    }

    static getProductSales(productID) {

        return new Promise((resolve=>{

            new Promise((resolve)=>{
                resolve(db.query(`CALL product_popularity_proc('${productID}')`))
            })
            .then(res => {
                
                resolve(res)
            })
            .catch(err => console.error(err))
            
        }))
    }

};

