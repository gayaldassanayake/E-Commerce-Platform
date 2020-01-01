const express = require('express');

const searchController = require('../controllers/searchController');
const ACL = require('../utils/isAuth');

const router = express.Router();

router.get('/search_results',  ACL.userAuthentication, searchController.getSearchResults);

module.exports = router;
