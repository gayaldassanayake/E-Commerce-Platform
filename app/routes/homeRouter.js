const express = require('express');

const customerController = require('../controllers/customerController');
const ACL = require('../utils/isAuth');

const router = express.Router();

router.get('/', ACL.userAuthentication, customerController.indexAction);
router.get ('/track_order', ACL.userAuthentication, customerController.track_orderAction);
router.get ('/checkout', ACL.userAuthentication, customerController.checkoutAction); // methna post ekak dmmoth hodi from cart interface//
router.post('/track_order_details', ACL.userAuthentication, customerController.order_detailsActionPost);

router.get('/cart', ACL.userAuthentication, customerController.cartAction)


module.exports = router;