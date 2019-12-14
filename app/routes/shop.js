const path = require('path');

const express = require('express');

const customerController = require('../controllers/customerController');

const router = express.Router();

router.get('/', customerController.shopAction);
router.get('/:id', customerController.shopCategoryAction);

module.exports = router;