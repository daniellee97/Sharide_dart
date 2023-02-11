const express = require('express')
const http = require('http')
const bodyParser = require('body-parser');

const app = express()

const port = 3000

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}))

app.use("/cars", require("./RestAPI/car"))
app.use("/customers", require("./RestAPI/customer"));
app.use("/documents", require("./RestAPI/document"))
app.use("/drivers", require("./RestAPI/driver"))
app.use("/locations", require("./RestAPI/location"))
app.use("/payments", require("./RestAPI/payment"))
app.use("/trips", require("./RestAPI/trip"))


app.get("/", (req, res)  => {
    res.send("Hello ")
})

app.listen(port, () => {
    console.log("Server running", port)
})

app.get('/user', function(req, res) {
    res.status(200).json({ name: 'john' });
  });

// module.exports = {app}