const express = require('express')
const { ObjectId } = require('mongodb');

const trip = express.Router()
var MongoDB = require('../mongoDB');
const { getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument } = require('./CRUDOps');
var collName = "trips"
const trip_columns = ["driver_email", "customer_email", "start_location_id", "end_location_id", "payment_id", "car_id", "trip_requested_timestamp", "trip_start_timestamp", "wait_time", "trip_status"]

trip.get("/", (req, res) => {
    getAllDocuments(MongoDB, collName, res)
})

trip.get("/:id", (req, res) => {
    let listingQuery = {_id: ObjectId(req.params.id) }

    getOneDocument(MongoDB, collName, listingQuery, res)
})

trip.put("/", (req, res) => {
    createOneDocument(MongoDB, collName, trip_columns, req, res)
})

trip.post("/", (req, res) => {
    // update trip
    let listingQuery = {_id: ObjectId(req.body.id) }

    updateOneDocumentWithAnyValues(MongoDB, collName, listingQuery, trip_columns, req, res)
})

trip.delete("/", (req, res) => {
    let listingQuery = {_id: ObjectId(req.body.id)}
    deleteOneDocument(MongoDB, collName, listingQuery, res)
})

trip.delete("/deleteAll", (req, res) => {
    deleteAllDocument(MongoDB, collName, res)
})

module.exports = trip;