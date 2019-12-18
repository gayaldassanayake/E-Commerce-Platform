const path = require('path');

const express = require('express');

const shopController = require('../controllers/shopController');

const router = express.Router();

router.get('/', shopController.shopAction);
router.get('/:id', shopController.shopCategoryAction);

module.exports = router;