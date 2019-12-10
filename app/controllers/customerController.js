const Product = require('../models/productModel');
const jsonData = require('../utils/json_reader');

exports.indexAction = (req, res, next) => {
    const promise = jsonData.jsonReader('./data/index_carousel.json');

    promise.then((value) =>{
        console.log(value);
        res.render('index', {
            pageTitle: "Home",
            path: '/',
            meta: value
        })
    });

    // async function a() {
    //     var x = await resolve(jsonData.jsonReader('./data/index_carousel.json'));
    // };
    // const products = Product.fetchAll();

};