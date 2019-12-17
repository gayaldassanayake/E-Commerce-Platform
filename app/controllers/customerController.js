const Product = require('../models/productModel');
const jsonData = require('../utils/json_reader');

const database=require('../utils/database');

exports.indexAction = (req, res, next) => {
    console.log("Strat db acc");
    // database.read('product',{conditions:['rating','manufacturer'],parameters:[4,'Q44NSZ198HU9D93QYSG9U18A95']}).then(function(data){
    //     console.log(data);
    // });
    // database.insert('product',{fields:['product_id','title','description','manufacturer','deleted','rating'],values:['0002','New Product','New des','manu',0,5]}).then(function(data){
    //     console.log(data);
    // }).catch(function(err){
    //     console.log(err);
    // });
    
    // database.update('product',{product_id:'0002',description:'chd des'},{description:'chdssss des'}).then(function(data){
    //     console.log(data);
    // }).catch(function(err){
    //     console.log(err);
    // });
    
    database.query('SELECT * FROM product',[]).then(function(data){
        console.log(data);
    });
    
    const promise = jsonData.jsonReader('./data/index_carousel.json');
    
    promise.then((value) =>{
        // console.log(value);

        res.render('customer_views/index', {
            pageTitle: "Home",
            path: '/',
            meta: value
        })
    });
};

exports.cartAction = (req, res, next) => {
    // const promise = jsonData.jsonReader('')

    // res.render('cart');
};