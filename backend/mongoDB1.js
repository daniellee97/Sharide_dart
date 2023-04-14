const { MongoClient, ServerApiVersion } = require('mongodb');
require("dotenv").config()

const temp = MongoClient.connect(process.env.DATABASE_URL)

const temp1 = MongoClient.connect(process.env.DATABASE_URL).close()
function getDb() {
    return temp.then(db => 
        db.db("FinalProjectDB")
    ).then(database => {return database});

}

function getConnect() {
    return temp;
}

module.exports = getDb();