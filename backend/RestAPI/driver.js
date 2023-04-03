const express = require('express')
const { ObjectId } = require('mongodb');

const driver = express.Router()
var MongoDB = require('../mongoDB');
const { getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument } = require('./CRUDOps');
var collName = "drivers"
const driver_columns = ["license_no", "name", "address", "sjsu_email", "phone_no", "joined_date", "password", "avail"]

driver.post("/logIn", (req, res) => {
    let listingQuery = {
        sjsu_email: req.body.sjsu_email,
        password: req.body.password
    }

    getOneDocument(MongoDB, collName, listingQuery, res)
    
})

driver.get("/avail", (req, res) => {
    let listingQuery = {
        "avail": "yes"
    }

    getOneDocument(MongoDB, collName, listingQuery, res)
    
})

driver.get("/", (req, res) => {
    getAllDocuments(MongoDB, collName, res)
})

driver.get("/:id", async (req, res) => {
    let listingQuery = {_id: ObjectId(req.params.id) }

    getOneDocument(MongoDB, collName, listingQuery, res)

})

driver.put("/", (req, res) => {
    createOneDocument(MongoDB, collName, driver_columns, req, res)
})

driver.post("/", (req, res) => {
    // update driver
    let listingQuery = {_id: ObjectId(req.body.id) }

    let filter = {sjsu_email: req.body.email}

    updateOneDocumentWithAnyValues(MongoDB, collName, filter, driver_columns, req, res)
})

driver.delete("/", (req, res) => {
    let listingQuery = {_id: ObjectId(req.body.id)}
    deleteOneDocument(MongoDB, collName, listingQuery, res)
})

driver.delete("/deleteAll", (req, res) => {
    deleteAllDocument(MongoDB, collName, res)
})


module.exports = driver;