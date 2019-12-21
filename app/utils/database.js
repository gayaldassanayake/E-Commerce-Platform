const mysql = require('mysql2');
const config = require('./config')

const pool = mysql.createPool(config.database);


exports.read = (table, parameters) => {

    return new Promise((resolve, reject) => {
        
        var conditions = '';
        var limit = '';
        var orderby = '';

        if (parameters['conditions']) {
            conditions = parameters['conditions'].join(' =? AND ');
            conditions += ' =?';
        }
        if (conditions != '') {
            conditions = ' WHERE ' + conditions;
        }

        if (parameters['orderby']) {
            orderby = ' ORDER BY ' + parameters['orderby'];
        }

        if (parameters['limit']) {
            limit = ' LIMIT ' + parameters['limit'];
        }

        var sql = `SELECT * FROM ${table}` + conditions + orderby + limit;

        pool.execute(sql, parameters['parameters'], function (err, results, fields) {
            if (err) {
                reject(err);
            }
            else {
                resolve(results);
            }
        });
    })
}

exports.insert = (table, parameters) => {

    return new Promise((resolve, reject) => {

        var fields = '';
        var values = [];

        for (var i = 0; i < parameters['values'].length; i++) {
            values.push('?')
        }

        values = values.join(', ');
        fields = fields.join(', ');

        var sql = `INSERT INTO ${table} (` + fields + ') VALUES (' + values + ')';

        pool.execute(sql, parameters['values'], function (err, results, fields) {
            if (err) {
                reject(err);
            }
            else {
                resolve(results);
            }
        });
    })
}

exports.update = (table, primaryKeys, parameters) => {

    return new Promise((resolve, reject) => {

        var conditionsArr = [];
        var parametersArr = [];
        var bindparam = [];

        for (var field in parameters) {
            if (parameters.hasOwnProperty(field)) {
                parametersArr.push(field + ' = ?');
                bindparam.push(parameters[field].toString());
            }
        }

        for (var key in primaryKeys) {
            if (primaryKeys.hasOwnProperty(key)) {
                conditionsArr.push(key + ' = ?');
                bindparam.push(primaryKeys[key].toString());
            }
        }

        var parameterStr = parametersArr.join(', ');
        var conditions = conditionsArr.join(' AND ');

        var sql = `UPDATE ${table} SET ` + parameterStr + ' WHERE ' + conditions;
        console.log(sql);

        pool.execute(sql, bindparam, function (err, results, fields) {
            if (err) {
                reject(err);
            }
            else {
                resolve(results);
            }
        });
    })
}

exports.query = (sql, parameters) => {

    return new Promise((resolve, reject) => {
        pool.execute(sql, parameters, function (err, results, fields) {
            if (err) {
                reject(err);
            }
            else {
                resolve(results);
            }
        });
    })
}

module.exports = pool.promise();
// exports.read = read;
// exports.insert = insert;
// exports.update = update;
// exports.query = query;