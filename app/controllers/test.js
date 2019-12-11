const model = require('../models/model');

exports.testAction = (req, res, next) => {
    // const promise = new Promise((resolve, reject) => {
    //     var results = model.getCustomers();
    //     resolve(results);
    // });
    const promise = model.getCustomers();

    promise.then((data1) => {
        res.render('test',{pageTitle: 'testing', data: data1});
    });

    
};

// exports.test1Action = (req, res, next) => {
//     var data1 = [
//         { id: 1, name: "bob" },
//         { id: 2, name: "john" },
//         { id: 3, name: "jake" },
//     ];
    
//     // JSON.stringify(data1);
//     console.log(data1);
//     res.render('test',{pageTitle: "TESTING",data: data1});
// };