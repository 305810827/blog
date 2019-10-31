const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session');
const router = require('./routers');

//创建服务应用
let app = express();
//ejs模板引擎配置
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
//静态路径
app.use(express.static(path.join(__dirname, 'public')));
//接受req.body参数配置
app.use(bodyParser.urlencoded({extended: true}));
//设置session
app.use(session({
    secret: 'mySession',
    cookie: {
        maxAge: 1000000,
        expires: Date.now() + 1000000
    }
}))

//找到routers文件下的index.js导出的函数,传入app
router(app);

app.listen('8002', function () {
    console.log("服务器在端口8002启动");
})