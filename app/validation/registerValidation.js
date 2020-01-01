const { check } = require('express-validator');


module.exports = [
    check('name')
    .isEmpty()
    .isAlpha()
    .withMessage('Name Should be non Empty'),
    check('email')
    .isEmpty()
    .withMessage('Email Field is Empty')
    .isEmail()
    .withMessage('Please enter a valid email !')
    .custom((value, { req }) => {
        if (value === 'gayal@gmail.com') {
            throw new Error('This email address is forbidden');
        }
        return true;
    }),
    check('password')
    .isEmpty()
    .isLength({min: 6})
    .withMessage("Should contain at least 6 characters")
    .isAlphanumeric()
    .withMessage("Should contain at least a Letter and Number")
];