const AccessControls = require('../data/access_controls');
const errorController = require('../controllers/errorController');

exports.userAuthentication = (req, res, next) => {
    if (!req.session.isLoggedIn) {
        for (const [key, value] of Object.entries(AccessControls.guest)) { 
            if(req.url === value) {
                return next();
            }  
        }
        res.redirect(errorController.get404);
    }
    for (const [key, value] of Object.entries(AccessControls.Loggedin)) { 
        if(req.url === value) {
            return next();
        }
    } 
    res.redirect(errorController.get404);


}

