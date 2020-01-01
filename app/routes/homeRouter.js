const express = require('express');

const customerController = require('../controllers/customerController');
const ACL = require('../utils/isAuth');

const router = express.Router();

router.get('/', ACL.userAuthentication, customerController.indexAction);
router.get ('/track_order', ACL.userAuthentication, customerController.track_orderAction);
router.get ('/checkout', ACL.userAuthentication, customerController.checkoutAction); // methna post ekak dmmoth hodi from cart interface//
router.post('/track_order_details', ACL.userAuthentication, customerController.order_detailsActionPost);

router.get('/cart', ACL.userAuthentication, customerController.cartAction)
// router.get('/addtocart/:product/:varient/:price',ACL.userAuthentication,customerController.addToCart)
router.post('/product/:product/:varient',customerController.addToCart2);
// router.post.cart = {
//     params: ['param1', 'param2'],
//     controller: customerController.addToCart2
// }
module.exports = router;