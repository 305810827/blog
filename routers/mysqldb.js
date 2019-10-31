const mysql =require('mysql');
//配置数据库连接
let connection =mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'root',
    database:'blog'
})
//连接数据库
connection.connect();

module.exports = connection;