const hashFunctions = require('../utils/hash_functions');
const db = require('../utils/database');

module.exports = class Customer {
    constructor(username, name, email, password) {
        this.username = username;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    static register(userInput) {
        return new Promise((resolve) => {
            resolve(db.execute("INSERT INTO customer (name, username, password, email, address) VALUES (?,?,?,?,?)",
                [userInput.name,
                userInput.username,
                hashFunctions.hash(userInput.password),
                userInput.email,
                userInput.address]))
        }).catch((err) => {
            console.log(err);
        });


        // return db.getConnection().then(conn => {
        //     conn.execute("INSERT INTO customer (name, username, password, email, address) VALUES (?,?,?,?,?)",
        //     [userInput.name, 
        //     userInput.username, 
        //     hashFunctions.hash(userInput.password), 
        //     userInput.email, 
        //     userInput.address])
        //     // .then(conn => {

        //     //     conn.execute("INSERT INTO customer_telephone (customer_id, telephone_number) VALUES (?,?)",
        //     //     []);
        //     // });

        // });


    }

    static getCustomerByUsername(username) {
        return new Promise((resolve) => {
            resolve(db.query("SELECT * FROM customer WHERE username = ?", [username]))
        }).then(value => {
            const details = value[0];
            return new Customer(details.username, details.name, details.email, details.password);
        }).catch((err) => {
            console.log(err);
        });


        // return db.getConnection().then(conn => {
        //     return conn.execute("SELECT * FROM customer WHERE username = ?", [username]).then(
        //         value => {
        //             const details = value[0][0];
        //             return new Customer(details.username, details.name, details.email, details.password);
        //         }
        //     );
        // });
    }

    static login(username, password, req, res) {
        this.getCustomerByUsername(username).then((user) => {
            if (user) {
                if (hashFunctions.checkHashed(password, user.password)) {
                    req.session.isLoggedIn = true;
                    req.session.user = user;
                    return req.session.save(err => {
                        console.error(err);
                        return res.redirect('/');
                    });
                } else {
                    console.error("Password Incorrect !");
                    res.redirect('/login');
                }
            } else {
                console.log("User doesn't exists! Please try Again");
                res.redirect('/login');
            }
        });
    }

    static getCustomerById() {

    }






};