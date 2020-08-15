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
    database: "sistem_kontrol"
});
db.connect((err) => {
    if (err) throw err
    console.log('koneksi database berhasil')
})
app.use(cors())
app.use(bodyParser.json())
app.use(express.static(path.join(__dirname, '/../web/build/web')))
app.use(express.urlencoded({ extended: true }))
app.get('/', (req, res) => {
    res.render('index')
})

app.get('/sensor', (req, res) => {
    db.query('select temp,hum,air,press from sensor order by id desc limit 1', (err, result, field) => {
        res.send(result)
    })
})
app.get('/relay', (req, res) => {
    db.query(`select ${req.query.id} from relay`, (err, result, field) => {
        res.send(result)
    })
})
app.get('/jadwal', (req, res) => {
    db.query('select timestamp from jadwal', (err, result, field) => {
        res.send(result)
    })
})
app.post('/nodemcu', (req, res) => {
    var temp = req.body.temp
    var hum = req.body.hum
    var press = req.body.press
    var air = req.body.air
    db.query(`insert into sensor (temp,hum,press,air) value (${temp},${hum},${press},${air})`)
    res.send('OK')
})
app.post('/jadwal', (req, res) => {
    console.log(req.body)
    db.query(`insert into jadwal (timestamp) value (${req.body.timestamp})`)
    res.send('OK')
})
app.listen(3000, console.log('Server Started'))