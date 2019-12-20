const { check  } = require('express-validator/check');


module.exports = [
    check('name','Please Enter a name with only letters')
    .isEmpty()
    .isAlpha(),
    check('email')
    .isEmpty() 
    .isEmail()
    .withMessage('Please enter a valid email !')
    .custom((value, { req }) => {
        if (value === 'gayal@gmail.com') {
            throw new Error('This email address is forbidden');
        }
        return true;
    }),
    check('password')
    .isLength({min: 6})
    .withMessage("Should contain at least 6 characters")
    .isAlphanumeric()
    .withMessage("Should contain at least a Letter and Number")
];