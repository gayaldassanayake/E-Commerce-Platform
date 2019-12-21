const Product = require('../models/productModel');
const jsonData = require('../utils/json_reader');

const database=require('../utils/database');

exports.indexAction = (req, res, next) => {
    console.log("Strat db acc");

    // database.read('product',{conditions:{'rating':5},parameters:[5,'manu1']}).then(function(data){
    //     console.log(data);
    // });
    // database.insert('product',{'product_id':'0005','title':'Title1','description':'des1','manufacturer':'manu3','deleted':0,'rating':4}).then(function(data){
    //     console.log(data);
    // }).catch(function(err){
    //     console.log(err);
    // });
    
    // database.update('product',{product_id:'0005'},{description:'chdssss des'}).then(function(data){
    //     console.log(data);
    // }).catch(function(err){
    //     console.log(err);
    // });
    
    // database.query('SELECT * FROM product',[]).then(function(data){
    //     console.log(data);
    // });
    
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