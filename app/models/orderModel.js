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

    static saveOrder(state, delivery_method, payment_method, address_no, road_name, city, country, delivery_person, date) {
        return db.query('INSERT INTO order_ (state, delivery_method, payment_method, address_no, road_name, city, country, delivery_person_id, date_) VALUES (?,?,?,?,?,?,?,?,?)',
            [state, delivery_method, payment_method, address_no, road_name, city, country, delivery_person, date]
        );
    }

    static findByOrderID(order_id) {
        return new Promise((resolve) => {
            resolve(db.query('SELECT * FROM order_ WHERE order_id = ? ', [order_id]))
        }).catch((err) => {
            console.log(err);
        });
    }

    static findOrderDetailsByOrderID(order_id) {
        return new Promise((resolve) => {
            resolve(db.query('SELECT * FROM order_details WHERE order_id = ? ', [order_id]))
        }).catch((err) => {
            console.log(err);
        });
    }

    static findOrderItemsByOrderID(order_id) {
        return new Promise((resolve) => {
            resolve(db.query('SELECT * FROM order_items_view WHERE order_id = ? ', [order_id]))
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

