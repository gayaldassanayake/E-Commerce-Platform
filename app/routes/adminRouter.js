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

router.post('/report/top_sold_products/',adminController.top_sold_productsPOSTAction);

router.get('/add_product/',adminController.addProductAction);
router.post('/add_product/',adminController.addProductPostAction);

router.get('/add_category/',adminController.addCategoryAction);
router.post('/add_category/',adminController.addCategoryPostAction);

module.exports = router;
