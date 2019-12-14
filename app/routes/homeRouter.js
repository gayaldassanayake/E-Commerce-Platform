const express = require('express');

const isAuth = require('../utils/isAuth');

const customerController = require('../controllers/customerController');
const testController = require('../controllers/testController');

const router = express.Router();

router.get('/', customerController.indexAction);
router.get ('/track_order', customerController.track_orderAction);
router.get ('/checkout', isAuth, customerController.checkoutAction); // methna post ekak dmmoth hodi from cart interface//
router.get('/test',testController.testAction);
router.get('/cart', isAuth, customerController.cartAction);


module.exports = router;