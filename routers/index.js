const register = require('./register');
const login = require('./login');
const pubContent = require('./pubContent');
const connection = require('./mysqldb');
const url = require("url");
module.exports = function (app) {
    // 路由挂载
    // 首页
    app.get('/', function (req, res) {
        res.locals.user = req.session.user;
        let parseObj = url.parse(req.url, true);
        if(parseObj.query.id){
            connection.query(`select * from article,user where user.user_id=article.article_user_id and user.user_id=${parseObj.query.id} ORDER BY article.article_post_time DESC`, function (error, results, fields) {
                if (results.length != 0){
                    results[0].article_post_time = results[0].article_post_time.toLocaleString();
                }
                res.render('blog', {article: results});
            })
        }
        else{
            connection.query(`select * from article,user where user.user_id=article.article_user_id ORDER BY article.article_post_time DESC`, function (error, results, fields) {
                if (results.length != 0){
                    for(let i=0; i<results.length; i++){
                        results[i].article_post_time = results[i].article_post_time.toLocaleString();
                    }
                }
                res.render('blog', {article: results});
            })
        }
    })

    app.use('/registerPage',register);
    app.use('/loginPage',login);
    app.use('/pubContent',pubContent);
}