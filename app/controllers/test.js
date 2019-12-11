exports.testAction = (req, res, next) => {
    var data1 = [
        { id: 1, name: "bob" },
        { id: 2, name: "john" },
        { id: 3, name: "jake" },
    ];
    
    // JSON.stringify(data1);
    console.log(data1);
    res.render('test',{pageTitle: "TESTING",data: data1});
};