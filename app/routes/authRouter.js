const express = require('express');
const Customer = require('../models/customerModel');


const authController = require('../controllers/authController');
const { check } = require('express-validator');
const registerValidation = require('../validation/registerValidation');

const router = express.Router();

router.get('/signup', authController.getRegisterAction);
router.post('/signup', registerValidation , authController.postRegisterAction);
router.get('/login', authController.getLoginAction);
router.post('/login', authController.postLoginAction);
router.post('/logout', authController.postLogoutAction);

module.exports = router;