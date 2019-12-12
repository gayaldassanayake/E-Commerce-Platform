const path = require('path');

const express = require('express');

const customerController = require('../controllers/customerController');
const testController = require('../controllers/testController');

const router = express.Router();

router.get('/', customerController.indexAction);
router.get('/signup',customerController.getRegisterAction);
router.post('/signup',customerController.postRegisterAction);
router.get('/login', customerController.getLoginAction);
router.post('/login', customerController.postLoginAction);
router.post('/logout', customerController.postLogoutAction);
router.get('/test',testController.testAction);

module.exports = router;