const Product = require('../models/productModel');

exports.getSearchResults = (req, res, next) => {

    const SearchResults = () => {
        return new Promise((resolve, reject) => {
            resolve((Product.fetchSearchedProducts()));
        });
    };

    SearchResults().then((result) => {
        console.log(result);
        res.render('customer_views/search_results', {
            pageTitle: "Products",
            path: '/',
            products: result            
        })
    });
}

