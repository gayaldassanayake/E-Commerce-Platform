const db = require('../utils/database');

module.exports = class Order {
    constructor(order_id, state, delivery_method, payment_method, credit_card_number, cvv, expire_month, expire_year, name_on_card, delivery_address, estimate_days, delivery_person_id) {
        this.order_id = order_id;
        this.delivery_method = delivery_method;
        this.payment_method = payment_method;
        this.credit_card_number = credit_card_number;
        this.cvv = cvv;
        this.expire_month = expire_month;
        this.expire_year = expire_year;
        this.name_on_card = name_on_card;
        this.delivery_address = delivery_address;
        this.estimate_days = estimate_days;
        this.delivery_person_id = delivery_person_id;
        this.state = state;
    }


    save() {
        db.query('INSERT INTO products (title, description, manufacturer, state, rating) VALUES (?,?,?,?,?,?)',
            [this.title, this.description, manufacturer, this.state, this.rating]
        );
    }

    static findByOrderID(order_id) {

        //db.read('order_',{conditions: {'order_id': order_id}})

        return new Promise((resolve) => {
            resolve(db.read('order_',{conditions: {'order_id': order_id}}))
        }).catch((err) => {
            console.log(err);
        });
    }

    static findOrderDetailsByOrderID(order_id) {
        return new Promise((resolve) => {
            resolve(db.read('order_details',{conditions: {'order_id': order_id}}))
        }).catch((err) => {
            console.log(err);
        });
    }

    static findOrderItemsByOrderID(order_id) {
        return new Promise((resolve) => {
            resolve(db.read('order_items_view',{conditions: {'order_id': order_id}}))
        }).catch((err) => {
            console.log(err);
        });
    }

    static fetchAll() {

        new Promise((resolve) => {
            resolve(db.query('SELECT * FROM order_ WHERE order_id = ? ', [order_id]))
        }).then((res) => {
            console.log(res);
        }).catch((err) => {
            console.log(err);
        });

        db.query('SELECT * FROM order_ WHERE order_id = ? ', [order_id]).then((res) => {
            console.log(res);
        }).catch((err) => {
            console.log(err);
        });


        db.query("SELECT * FROM product").then((res) => {
            console.log(res);
        }).catch((err) => {
            console.log(err);
        });
    }
};

