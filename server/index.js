var express = require('express')
var path = require('path')
var app = express()
var cors = require('cors')
var bodyParser = require('body-parser')
const cron = require('node-cron');
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
app.use(express.static(path.join(__dirname, '../web/build/web')))
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
    var relayId = req.query.id
    db.query(`select ${req.query.id} from relay`, (err, result, field) => {
        var state = result[0][relayId]
        if (state == 0) {
            res.send('0')
        }
        else {
            res.send('1')
        }
    })
})
app.get('/startrelay', (req, res) => {
    var relayId = req.query.id
    db.query(`select ${req.query.id} from relay`, (err, result, field) => {
        var state = result[0][relayId]
        if (state == 0) {
            db.query(`update relay set ${relayId} = 1`)
            res.send('1')
        }
        else {
            db.query(`update relay set ${relayId} = 0`)
            res.send('0')
        }
    })
})
app.get('/noderelay',(req,res)=>{
    db.query(`select relay1,relay2,relay3,relay4 from relay`,(err,result,field)=>{
        res.send(result[0])
    })
})
app.get('/poweroff', (req, res) => {
    console.log('got request')
    db.query(`update relay set relay1=0,relay2=0,relay3=0,relay4=0`, (err, result, field) => {
        console.log(result)
        res.send('OK')
    })
    
})
app.get('/jadwal', (req, res) => {
    db.query('select timestamp from jadwal', (err, result, field) => {
        res.send(result)
    })
})
app.get('/cekjadwal', (req, res) => {
    const minute = 60000
    var now = Date.now()
    var todo = now + (minute * 5)
    db.query(`select timestamp from jadwal where timestamp < ${todo} and timestamp > ${now}`,(_err,_result,_field)=> {
        if (_result.length > 0) {
            res.send(_result)
        }
        else res.send('NA')
    })
})

app.get('/nodemcu', (req, res) => {
    var temp = req.query.temp
    var hum = req.query.hum
    var press = req.query.press
    var air = req.query.air
    db.query(`insert into sensor (temp,hum,press,air) value (${temp},${hum},${press},${air})`)
    res.send('OK')
})
app.post('/jadwal', (req, res) => {
    console.log(req.body)
    db.query(`insert into jadwal (timestamp) value (${req.body.timestamp})`)
    res.send('OK')
})

cron.schedule('* * * * * *', () => {
    var now = Date.now()
    db.query(`delete from jadwal where timestamp < ${now}`)
});

app.listen(3000, console.log('Server Started'))