const getAllDocuments = async (database, collName, res) => {
    ;(await database)
        .collection(collName)
        .find({})
        .toArray().then(result => res.json(result))
}

const getOneDocument = async (database, collName, listingQuery, res) => {
    ;(await database).collection(collName).findOne(listingQuery)
    .then( result => {
        res.json(result)
    })

}

const createOneDocument = async (database, collName, schema_columns, req, res) => {
    const newDocument = {}
    for (let i =0; i < schema_columns.length; i++) {
        let property = schema_columns[i]
        newDocument[property ] = req.body[property] ? req.body[property] : ""
    }
    
    (await database).collection(collName).insertOne(newDocument)
    .then(result => {
        res.send("Inserted new document " + result.insertedId)
    })
}


const updateOneDocumentWithAnyValues = async (database, collName, listingQuery, schema_columns, req, res) => {
    // update car
    ;(await database).collection(collName).findOne(listingQuery)
    .then(async (document) => {

        console.log("Found document " + document)

        let setDocument = {}

        for (let i =0; i < schema_columns.length; i++) {
            let property = schema_columns[i]
            setDocument[property] = req.body[property] ? req.body[property] : document[property]
        }
        
        let newDocument = {
            $set: setDocument
        }
        
        ;(await database).collection(collName).updateOne(listingQuery, newDocument);

        res.send("Updated the document")
    })
}

const deleteOneDocument = async (database, collName, listingQuery, res) => {
    ;(await database).collection(collName).deleteOne(listingQuery);
    res.send("Deleted one document")
}

const deleteAllDocument = async (database, collName, res) => {
    ;(await database).collection(collName).deleteMany({});
    res.send("Deleted all document")
}

module.exports =  {getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument};