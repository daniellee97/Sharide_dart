var app = require("./app")
var MongoDb = require("./mongoDB")

var server = app.listen(3000, () => console.log("listening on port 3000"))
