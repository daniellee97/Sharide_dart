const express = require('express')
const { ObjectId } = require('mongodb');

const tripProcessing = express.Router()
var MongoDB = require('../mongoDB');
const { getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument } = require('./CRUDOps');
var collName = "tripProcessing"
const trip_columns = ["driver_email", "customer_email"]

tripProcessing.get("/", (req, res) => {
    getAllDocuments(MongoDB, collName, res)
})

// get object using both emails
tripProcessing.post("/get", (req, res) => {
    let listingQuery = {driver_email: req.body.driver_email,
                        customer_email: req.body.customer_email}

    getOneDocument(MongoDB, collName, listingQuery, res)
})

// for driver
tripProcessing.post("/forDriver", (req, res) => {
    let listingQuery = {driver_email: req.body.driver_email}

    getOneDocument(MongoDB, collName, listingQuery, res)
})

// for passenger
tripProcessing.post("/forCustomer", (req, res) => {
    let listingQuery = {customer_email: req.body.customer_email}

    getOneDocument(MongoDB, collName, listingQuery, res)
})



tripProcessing.get("/:id", (req, res) => {
    let listingQuery = {_id: ObjectId(req.params.id) }

    getOneDocument(MongoDB, collName, listingQuery, res)
})

tripProcessing.put("/", (req, res) => {
    createOneDocument(MongoDB, collName, trip_columns, req, res)
})

tripProcessing.post("/", (req, res) => {
    // update trip req and res
    let listingQuery = {_id: ObjectId(req.body.id) }

    updateOneDocumentWithAnyValues(MongoDB, collName, listingQuery, trip_columns, req, res)
})

tripProcessing.delete("/", (req, res) => {
    
    let listingQuery = {
        driver_email: req.body.driver_email,
        customer_email: req.body.customer_email
    }
    deleteOneDocument(MongoDB, collName, listingQuery, res)
})

tripProcessing.delete("/forDriver", (req, res) => {
    
    let listingQuery = {
        driver_email: req.body.driver_email
    }
    deleteOneDocument(MongoDB, collName, listingQuery, res)
})

tripProcessing.delete("/forCustomer", (req, res) => {
    
    let listingQuery = {
        customer_email: req.body.customer_email
    }
    deleteOneDocument(MongoDB, collName, listingQuery, res)
})



tripProcessing.delete("/deleteAll", (req, res) => {
    deleteAllDocument(MongoDB, collName, res)
})

module.exports = tripProcessing;