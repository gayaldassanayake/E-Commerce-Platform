const express = require('express');

const productController = require('../controllers/productController');
const adminController = require('../controllers/adminController');

const router = express.Router();

router.get('/add-product', productController.getAddProduct);
router.post('/add-product', productController.postAddProduct);
router.get('/',adminController.admin_dashboardAction);
router.get('/view_category',adminController.view_categoryAction);
router.post('/view_category_details',adminController.view_category_detailsAction);
router.get('/view_product',adminController.view_productAction);

module.exports = router;
