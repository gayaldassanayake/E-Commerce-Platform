const path = require('path');

const express = require('express');

const customerController = require('../controllers/customerController');
const testController = require('../controllers/test');

const router = express.Router();

router.get('/', customerController.indexAction);
router.get('/login',customerController.loginAction);
router.get ('/signup',customerController.signupAction);
router.get('/test',testController.testAction);


module.exports = router;