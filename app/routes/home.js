const path = require('path');

const express = require('express');

const customerController = require('../controllers/customerController');
const testController = require('../controllers/test');

const router = express.Router();

router.get('/', customerController.indexAction);
router.get('/login',customerController.loginAction);
router.get ('/signup',customerController.signupAction);
router.get ('/track_order', customerController.track_orderAction);
router.get ('/checkout',customerController.checkoutAction); // methna post ekak dmmoth hodi from cart interface//
router.post('/track_order_details',customerController.order_detailsActionPost);

router.get('/test',testController.testAction);


module.exports = router;