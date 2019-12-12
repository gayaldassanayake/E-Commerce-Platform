const path = require('path');

const express = require('express');

const customerController = require('../controllers/customerController');
const testController = require('../controllers/testController');

const router = express.Router();

router.get('/', customerController.indexAction);
router.get('/login', customerController.getLoginAction);
router.post('/login', customerController.postLoginAction);
router.get('/test',testController.testAction);

module.exports = router;