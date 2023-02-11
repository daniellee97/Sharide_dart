const express = require('express')
const { ObjectId } = require('mongodb');

const document = express.Router()
var MongoDB = require('../mongoDB');
const { getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument } = require('./CRUDOps');
var collName = "documents"
const document_columns = ["driver_id", "doc_name", "doc_category", "document_code", "expiration_date"]

document.get("/", (req, res) => {
    getAllDocuments(MongoDB, collName, res)
})

document.get("/:id", (req, res) => {
    let listingQuery = {_id: ObjectId(req.params.id) }

    getOneDocument(MongoDB, collName, listingQuery, res)

})

document.put("/", (req, res) => {
    createOneDocument(MongoDB, collName, document_columns, req, res)
})

document.post("/", (req, res) => {
    // update document
    let listingQuery = {_id: ObjectId(req.body.id) }

    updateOneDocumentWithAnyValues(MongoDB, collName, listingQuery, document_columns, req, res)
})

document.delete("/", (req, res) => {
    let listingQuery = {_id: ObjectId(req.body.id)}
    deleteOneDocument(MongoDB, collName, listingQuery, res)

})

document.delete("/deleteAll", (req, res) => {
    deleteAllDocument(MongoDB, collName, res)

})

module.exports = document;