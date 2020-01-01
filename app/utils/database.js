const mysql = require('mysql2');
// const { database } = require('./config')
// const config = require('./config')

const { database } = require('./config')

const pool = mysql.createPool({
    host: database.host,
    user: database.user,
    database: database.name,
    password: database.password,
    port: database.port
});

const connection = mysql.createConnection({
    host: database.host,
    user: database.user,
    database: database.name,
    password: database.password,
    port: database.port
  });


exports.getConnection=() =>{
    return connection;
}

// const pool = mysql.createPool(config.database);

function read(table, parameters) {

    return new Promise((resolve, reject) => {
        
        var conditions = '';
        var limit = '';
        var orderby = '';
        var fieldsStr = '*';
        var bindparam = [];

        if (parameters['conditions']) {
            var conditionArr = []
            for (var field in parameters['conditions']) {
                if (parameters['conditions'].hasOwnProperty(field)) {
                    conditionArr.push(field + ' = ?');
                    bindparam.push(parameters['conditions'][field]);
                }
            }
            conditions = conditionArr.join(' AND ');
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

        if (parameters['fields']) {
            fieldsStr = parameters['fields'].join(', ');
        }


        var sql = `SELECT ` + fieldsStr + ` FROM ${table}` + conditions + orderby + limit;

        console.log(sql)
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

exports.insert = (table, parameters) => {

    return new Promise((resolve, reject) => {

        var fields = '';
        var values = [];
        var bindparam = [];
        var fieldsArr = [];

        for (var field in parameters) {
            if (parameters.hasOwnProperty(field)) {
                fieldsArr.push(field);
                values.push('?');
                bindparam.push(parameters[field]);
            }
        }

        fields = fieldsArr.join(', ');
        values = values.join(', ');
        // fields = fieldsArr.join(', ');

        var sql = `INSERT INTO ${table} (` + fields + ') VALUES (' + values + ')';

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

exports.update = (table, primaryKeys, parameters) => {

    return new Promise((resolve, reject) => {

        var conditionsArr = [];
        var parametersArr = [];
        var bindparam = [];

        for (var field in parameters) {
            if (parameters.hasOwnProperty(field)) {
                parametersArr.push(field + ' = ?');
                bindparam.push(parameters[field]);
            }
        }

        for (var key in primaryKeys) {
            if (primaryKeys.hasOwnProperty(key)) {
                conditionsArr.push(key + ' = ?');
                bindparam.push(primaryKeys[key]);
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
    console.log(sql,parameters)
    return new Promise((resolve, reject) => {
        pool.execute(sql, parameters, function (err, results, fields) {
            if (err) {
                console.error(err)
                reject(err);
            }
            else {
                resolve(results);
            }
        });
    })
}


exports.read = read;
// exports.insert = insert;
// exports.update = update;
// exports.query = query;

// module.exports = pool.promise();


/*
===============================================================================================

DEVELOPER GUIDE

    read(table_name[string],paramter[Object])

    parameter[object] =>
        {conditions:[Object Array],     //  conditions for WHERE clause as key:value pairs
            fields:[string Array]       //  coloum names needed to be fetched if need to be specified
            limit: [int]                //  limit no. of results
            orderby: String             //  order by ASC | DESC
        }


    insert(table_name, parameter[object])

    parameter[object] =>
        {
            key:value           // Coloum_name:value pairs which are need to be inserted.
        }


    update(table_name,selection[object],parameter[object])

    selection[object] =>
        {
            key1:value1,                //  conditions to WHERE cluase as key:value pairs
            key2:value2
        }

    parameter[object] =>
        {
            key1:value1,                //  parameters to UPDATE as key:value pairs
            key2:value2
        }

    query(sql[String],bind_parameters[Array])
*/