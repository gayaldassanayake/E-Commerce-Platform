const fs = require('fs');

const jsonReader = (filepath) => {
    return new Promise((resolve, reject) => {
        cb = (err, fileData) => {
            if(err) {
                console.log(err);
                reject(err);
            } 
            try {
                const obj = JSON.parse(fileData);
                resolve(obj);
            } catch (err) {
                console.log(err);
                reject(err);
            }
        };

        fs.readFile(filepath,cb);
    })
};

exports.jsonReader = jsonReader;