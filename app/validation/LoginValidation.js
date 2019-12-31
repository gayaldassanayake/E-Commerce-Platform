const { check } = require('express-validator');

const Customer = require('../models/customerModel');


module.exports = [

    check('username')
    .notEmpty().withMessage('Please enter a username'),

    check('password')
    .notEmpty().withMessage('Please enter the password')
];