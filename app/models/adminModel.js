const db = require('../utils/database');
const hashFunctions = require('../utils/hash_functions');

module.exports = class Admininstrator {
    constructor(params) {
        this.id = params.id,
        this.name = params.name,
        this.username = params.username
    }

    static insert(userInput){
        return new Promise((resolve) => {
            console.log(userInput);
            resolve(db.query("INSERT INTO administrator (name, username, password) VALUES (?,?,?)",
                [userInput.name,
                userInput.username,
                hashFunctions.hash(userInput.password)]))
        }).catch((err) => {
            console.log(err);
        });

    }
    
};

