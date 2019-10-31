const express = require('express');
const multer = require('multer');
const crypto = require('crypto');
const connection = require('./mysqldb');
const url = require("url");
const path = require('path');
//路由对象
let router = express.Router();
//上传配置
let storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname,'../', 'public', 'img', 'header'))
    },
    filename: function (req, file, cb) {
        var suffix = file.originalname.split('.')
        cb(null, file.fieldname + '-' + Date.now() + '.' + suffix[suffix.length - 1]);
    }
})
let upload = multer({storage: storage});
//中间件,登录了无法访问注册登录页面
function checklogout(req,res,next){
    if(req.session.user){
        res.redirect('/')
    }else{
        next();
    }
}
//注册页面
router.get('/',checklogout, function (req, res) {
    res.locals.user = req.session.user;
    res.render('register');
})
//注册
router.post('/register', upload.single('header'), function (req, res) {
    let userInfo = req.body;
    let encryption = crypto.createHmac('sha256','jie').update(userInfo.password1).digest('hex');
    connection.query(`INSERT into user(username,password,sex,header,descri) VALUES("${userInfo.username}","${encryption}","${userInfo.sex}","${req.file.filename}","${userInfo.self}")`, function (error, results, fields) {
        if (error) throw error;
        res.redirect('/loginPage');
    })
})
//注册账户是否重复验证
router.get('/usernameJudge', function (req, res) {
    let parseObj = url.parse(req.url, true);
    connection.query(`select count(*) from user where username = "${parseObj.query.username}"`, function (error, results, fields) {
        if (error) throw error;
        if (results[0]['count(*)'] >= 1) {
            res.send(true)
        } else {
            res.send(false)
        }
    })
})
//导出路由对象
module.exports = router;