const express = require('express');

const productController = require('../controllers/productController');
const adminController = require('../controllers/adminController');

const router = express.Router();

router.get('/add-product', productController.getAddProduct);
router.post('/add-product', productController.postAddProduct);
router.get('/',adminController.admin_dashboardAction);
router.get('/view_category',adminController.view_categoryAction);
router.get('/view_product',adminController.view_productAction);
router.get('/report',adminController.reportAction);
router.get('/report/top_sold_products/',adminController.top_sold_productsAction);

module.exports = router;
