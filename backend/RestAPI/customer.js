const express = require('express');
const { ObjectId } = require('mongodb');

const customer = express.Router()

var MongoDB = require('../mongoDB');
const { getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument } = require('./CRUDOps');
var collName = "customers"
const customer_columns = ["name", "sjsu_email", "password", "address", "phone_no", "joined_date"]

customer.post("/logIn", (req, res) => {
    let listingQuery = {
        sjsu_email: req.body.sjsu_email,
        password: req.body.password
    }

    getOneDocument(MongoDB, collName, listingQuery, res)
    
})


customer.get("/", (req, res) => {
    getAllDocuments(MongoDB, collName, res)
    
})

customer.get("/getById/:id", async (req, res) => {
    let listingQuery = {_id: ObjectId(req.params.id) }

    getOneDocument(MongoDB, collName, listingQuery, res)

})

customer.put("/", async (req, res) => {
    createOneDocument(MongoDB, collName, customer_columns, req, res)

})

customer.post("/", (req, res) => {
    // update customer
    let listingQuery = {_id: ObjectId(req.body.id) }

    updateOneDocumentWithAnyValues(MongoDB, collName, listingQuery, customer_columns, req, res)
})

customer.delete("/", (req, res) => {
    let listingQuery = {
        sjsu_email: req.body.sjsu_email,
    }

    deleteOneDocument(MongoDB, collName, listingQuery, res)

})

customer.delete("/deleteAll", (req, res) => {
    deleteAllDocument(MongoDB, collName, res)

})


module.exports = customer;