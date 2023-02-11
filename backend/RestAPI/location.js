const express = require('express')
const { ObjectId } = require('mongodb');

const location = express.Router()
var MongoDB = require('../mongoDB');
const { getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument } = require('./CRUDOps');
var collName = "locations"
const location_columns = ["latitude", "longtitude", "landmark_city", "landmark_state", "landmark_country", "landmark_name"]


location.get("/", (req, res) => {
    getAllDocuments(MongoDB, collName, res)
})

location.get("/:id", (req, res) => {
    let listingQuery = {_id: ObjectId(req.params.id) }

    getOneDocument(MongoDB, collName, listingQuery, res)
})

location.put("/", (req, res) => {
    createOneDocument(MongoDB, collName, location_columns, req, res)
})

location.post("/", (req, res) => {
    // update location
    let listingQuery = {_id: ObjectId(req.body.id) }

    updateOneDocumentWithAnyValues(MongoDB, collName, listingQuery, location_columns, req, res)
})

location.delete("/", (req, res) => {
    let listingQuery = {_id: ObjectId(req.body.id)}
    deleteOneDocument(MongoDB, collName, listingQuery, res)
})

location.delete("/deleteAll", (req, res) => {
    deleteAllDocument(MongoDB, collName, res)
})

module.exports = location;