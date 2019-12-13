const db = require('../utils/database');

module.exports = class Customer {
    constructor(username, name, email) {
        this.username = username;
        this.name = name;
        this.email = email;     
    }

    save(password, address, telephoneNumber) {
        db.getConnection().then(conn => {
            return new Promise((resolve, reject) => {
                conn.execute("INSERT INTO customer (name, username, password, email, address, telephoneNumber) VALUES (?,?,?,?,?,?)",
                [this.name, this.username, password, this.email, address, telephoneNumber]
                );
            });
        });
    }

    register = () => {

    }

    static getCustomerByUsername = () => {

    }

    static login = () => {
        
    }

    static getCustomerById = () => {

    }






};