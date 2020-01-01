const { check } = require('express-validator');

module.exports = [
    check('name')
    .isAlpha()
    .withMessage('Name Should be non Empty'),
    check('username')
    .isAlpha()
    .withMessage('Username Should be non Empty'),
    check('password')
    .isLength({min: 6})
    .withMessage("Should contain at least 6 characters")
    .matches(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})/,"i")
    .withMessage("Should contain at least a Letter and Number")
    .custom((value, { req }) => {
        if (value != req.body.repassword) {
            throw new Error('Password Fields do not match');
        }
        return true;
    })
];