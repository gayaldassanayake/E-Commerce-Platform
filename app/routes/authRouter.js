const express = require('express');

const authController = require('../controllers/authController');
const registerValidation = require('../validation/registerValidation');
const loginValidation = require('../validation/LoginValidation');

const isAuth = require('../utils/isAuth');

const router = express.Router();

router.get('/signup', authController.getRegisterAction);
router.post('/signup', registerValidation , authController.postRegisterAction);
router.get('/login', authController.getLoginAction);
router.post('/login', loginValidation, authController.postLoginAction);
router.post('/logout', authController.postLogoutAction);

module.exports = router;