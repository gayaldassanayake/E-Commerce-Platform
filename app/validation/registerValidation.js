const { check } = require('express-validator');


module.exports = [
    check('name')
    .notEmpty().withMessage('Please Enter a Name')
    .isAlpha().withMessage('Name should not contain other than letters'),

    check('username')
    .notEmpty().withMessage('Please enter a username')
    .isLength({ min: 5}).withMessage('Username must contain more than 5 charactors')
    .custom(value => {
        return Customer.checkUsernameExist(value)
        .then(value => {
            if (value.length) { 
                throw new Error("Username is Already taken");
            }
        })
        .catch(err => {
            if (err) {
                console.error(err);
            }
        });

    }),

    check('email')
    .isEmail().withMessage('Not a valid email')
    .custom((value, { req }) => {
        return Customer.checkEmailExist(value)
        .then(value => {
            if (value.length) {
                throw new Error("Account Exist from this email !");
            } 
        })
        .catch(err => {
            if (err) {
                console.error(err);
            }
        });

    }),
    
    check('password')
    .isLength({ min: 5}).withMessage('Password must contain more than 5 charactors')
    .matches(/\d/).withMessage('Password must contain a number'),

    check('telephoneNumber','Please Enter a telephone number')
    .notEmpty()
    .isNumeric()
    .isLength({ min: 10}),

    check('confirmPassword')
    .custom((value,  { req }) => {
        if (value !== req.body.password) {
            throw new Error("Passwords doesn't match !");
        }
        return true;
    })
];