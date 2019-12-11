const path = require('path');

const express = require('express');

const customerController = require('../controllers/customerController');
const testController = require('../controllers/test');

const router = express.Router();

router.get('/', customerController.indexAction);
router.get('/test',testController.testAction);
router.get('/cart',customerController.cartAction)

module.exports = router;