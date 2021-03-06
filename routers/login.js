const express = require('express');
const crypto = require('crypto');
const connection = require('./mysqldb');
//路由对象
let router = express.Router();
//中间件,登录了无法访问注册登录页面
function checklogout(req,res,next){
    if(req.session.user){
        res.redirect('/')
    }else{
        next();
    }
}
//登录页面
router.get('/',checklogout, function (req, res) {
    res.locals.user = req.session.user;
    res.render('login');
})
//登录
router.post('/login', function (req, res) {
    let encryption = crypto.createHmac('sha256','jie').update(req.body.password).digest('hex');
    connection.query(`select * from user where username = "${req.body.username}" and password = "${encryption}"`, function (error, results, fields) {
        if (error) throw error;
        if (results.length >= 1) {
            req.session.user = {
                id: results[0].user_id,
                username: results[0].username,
                header: results[0].header,
                sex: results[0].sex,
                self: results[0].self,
            }
            res.locals.user = req.session.user;
            res.redirect('/');
        } else {
            res.redirect('/loginPage');
        }
    })
})
//退出登录
router.get('/logout', function (req, res) {
    req.session.user = '';
    res.redirect('/loginPage');
})
//导出路由对象
module.exports = router;