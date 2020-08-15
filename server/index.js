var express = require('express')
var path = require('path')
var app = express()
var cors = require('cors')
var bodyParser = require('body-parser')
var mysql = require('mysql')
var db = mysql.createConnection({
    host: "127.0.0.1",
    user: "trial",
    password: "trial123",
    database: "sistemkontrol"
});
db.connect((err) => {
    if (err) throw err
    console.log('koneksi database berhasil')
})
app.use(cors())
app.use(bodyParser.json())
app.use(express.static(path.join(__dirname, '/../web/build/web')))
app.use(express.urlencoded({ extended: true }))
// app.set('view engine', 'ejs')
app.get('/', (req, res) => {
    // console.log(req.body)
    res.render('index')
})
app.post('/auth', (req, res) => {
    console.log(req)
    res.send("hai juga")
})
app.get('/test', (req, res) => {
    res.send('{"test":"hallo"}')
})
app.listen(3000, console.log('Server Started'))