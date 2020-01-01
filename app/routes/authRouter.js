const express = require('express');

const authController = require('../controllers/authController');
const registerValidation = require('../validation/registerValidation');
const loginValidation = require('../validation/LoginValidation');
const ACL = require('../utils/isAuth');

const router = express.Router();

router.get('/signup', ACL.userAuthentication, authController.getRegisterAction);
router.post('/signup', ACL.userAuthentication,registerValidation , authController.postRegisterAction);
router.get('/login', ACL.userAuthentication, authController.getLoginAction);
router.post('/login', ACL.userAuthentication, loginValidation, authController.postLoginAction);
router.post('/logout', ACL.userAuthentication, authController.postLogoutAction);

module.exports = router;