const express = require('express')
const { ObjectId } = require('mongodb');

const payment = express.Router()
var MongoDB = require('../mongoDB');
const { getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument } = require('./CRUDOps');
var collName = "payments"
const payment_columns = ["customer_id", "type", "base_rate", "tip_amount", "total_amount", "transaction_id"]

payment.get("/", (req, res) => {
    getAllDocuments(MongoDB, collName, res)
})

payment.get("/:id", (req, res) => {
    let listingQuery = {_id: ObjectId(req.params.id) }

    getOneDocument(MongoDB, collName, listingQuery, res)
})

payment.put("/", (req, res) => {
    createOneDocument(MongoDB, collName, payment_columns, req, res)
})

payment.post("/", (req, res) => {
    // update payment
    let listingQuery = {_id: ObjectId(req.body.id) }

    updateOneDocumentWithAnyValues(MongoDB, collName, listingQuery, payment_columns, req, res)
})

payment.delete("/", (req, res) => {
    let listingQuery = {_id: ObjectId(req.body.id)}
    deleteOneDocument(MongoDB, collName, listingQuery, res)
})

payment.delete("/deleteAll", (req, res) => {
    deleteAllDocument(MongoDB, collName, res)
})

module.exports = payment;