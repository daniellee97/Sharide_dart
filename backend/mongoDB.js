const { MongoClient, ServerApiVersion } = require('mongodb');
require("dotenv").config()

function getDb() {
    return MongoClient.connect(process.env.DATABASE_URL).then(db => 
        db.db("FinalProjectDB")
    ).then(database => {return database});

}

module.exports = getDb();