 exports.get404 = (req, res, next) => {
    res.status(404).render('404', {
        pageTitle: 'Page Not Found', 
        path: '',
    });
};

exports.get404Admin = (req, res, next) => {
    res.status(404).render('404_admin', {
        pageTitle: 'Page Not Found', 
        path: '',
    });
};