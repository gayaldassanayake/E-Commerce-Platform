exports.objToDict = (obj) => {
    var dict = {};
    for (var key in obj) {
        dict[key] = obj[key];
    }
    return dict;
}