const db = require('../utils/database');
const hashFunctions = require('../utils/hash_functions');

module.exports = class Admininstrator {
    constructor(params) {
        this.id = params.id,
        this.name = params.name,
        this.username = params.username,
        this.password = params.password
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

    static getAdminUserName(username){

        return new Promise((resolve) => {
            resolve(db.query("SELECT * FROM administrator WHERE username = ?",[username]))
        }).then(value => {
            const detail = value[0];
            return new Admininstrator(detail);
        }).catch((err) => {
            console.log(err);
        });
    }
    
};

