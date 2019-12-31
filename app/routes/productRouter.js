const path = require('path');

const express = require('express');

const productController = require('../controllers/productController');

const router = express.Router();

router.get('/:id', productController.viewProduct);
// router.get('/:id', shopController.shopCategoryAction);

module.exports = router;