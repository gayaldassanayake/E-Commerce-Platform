const bcrypt = require('bcryptjs');

exports.hash = (password) => {

    const salt = bcrypt.genSaltSync(12);
    const hash = bcrypt.hashSync(password, salt);
    return hash;
}

exports.checkHashed = (password, hash) => {
    return bcrypt.compareSync(password , hash);
}
