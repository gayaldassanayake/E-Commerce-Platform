const db = require('../utils/database');

module.exports = class Customer {
    constructor(username, name, email, address) {
        this.username = username;
        this.name = name;
        this.email = email;
        this.address = address;
    }

    // save() {
    //     db.
    // }

    register = () => {

    }

    static getCustomerByUsername = () => {

    }

    static login = () => {
        
    }

    static getCustomerById = () => {

    }






};