const db = require('../utils/database');

module.exports = class Product {
    constructor(title, description, manufacturer, state, rating) {
        this.title = title;
        this.description = description;
        this.manufacturer = manufacturer;
        this.state = state;
        this.rating = rating;
    }

    save() {
       db.execute('INSERT INTO products (title, description, manufacturer, state, rating) VALUES (?,?,?,?,?,?)',
       [this.title, this.description, manufacturer, this.state, this.rating]
       );
    }

    static fetchAll() {
        db.execute("SELECT * FROM product").then((res)=>{
            console.log(res);
        }).catch((err)=> {
            console.log(err);
        });
    }
};

