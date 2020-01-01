const express = require('express');

const shopController = require('../controllers/shopController');
const ACL = require('../utils/isAuth');

const router = express.Router();

router.get('/', ACL.userAuthentication, shopController.shopAction);
router.get('/:id', ACL.userAuthentication, shopController.shopCategoryAction);

module.exports = router;