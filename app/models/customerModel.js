const hashFunctions = require('../utils/hash_functions');
const db = require('../utils/database');

module.exports = class Customer {
    constructor(username, name, email) {
        this.username = username;
        this.name = name;
        this.email = email;     
    }

    static register = (userInput) => {
        return db.getConnection().then(conn => {
            conn.execute("INSERT INTO customer (name, username, password, email, address) VALUES (?,?,?,?,?)",
            [userInput.name, userInput.username, hashFunctions.hash(userInput.password), userInput.email, userInput.address])
            // .then(conn => {
                
            //     conn.execute("INSERT INTO customer_telephone (customer_id, telephone_number) VALUES (?,?)",
            //     []);
            // });
               
        });
    }

    static getCustomerByUsername = (username) => {
        return db.getConnection().then(conn => {
            return conn.execute("SELECT * FROM customer WHERE username = ?",[username]).then(
                value => {                
                    return value[0];
                }
            );
        });
    }

    static login = (username, password) => {
        this.getCustomerByUsername(username).then((value) => {
            // console.log(value[0].password);
            if(value) {
                if(hashFunctions.checkHashed(password, value[0].password)) {
                    console.log("hi")
                } else {
                    
                }
            } else {
                console.log("Password Incorrect !");
            }
        });
    }

    static getCustomerById = () => {

    }






};