const express = require('express');

const adminAuthController = require('../controllers/adminAuthController');
const adminAddValidation = require('../validation/adminAddValidation');
const loginValidation = require('../validation/LoginValidation');
const ACL = require('../utils/isAuth');

const router = express.Router();

router.get('/add_admin',adminAuthController.getAdminRegisterAction);
router.post('/add_admin',adminAddValidation,adminAuthController.postRegisterAction);
router.get('/login',adminAuthController.view_loginAction);
router.post('/login', loginValidation, adminAuthController.postLoginAction);
router.post('/logout', adminAuthController.postLogoutAction);
// router.get('/signup', ACL.userAuthentication, authController.getRegisterAction);
// router.post('/signup', ACL.userAuthentication,registerValidation , authController.postRegisterAction);
// router.get('/login', ACL.userAuthentication, authController.getLoginAction);
// router.post('/login', ACL.userAuthentication, loginValidation, authController.postLoginAction);
// router.post('/logout', ACL.userAuthentication, authController.postLogoutAction);

module.exports = router;