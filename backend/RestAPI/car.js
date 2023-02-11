const { ObjectId } = require('mongodb');
const express = require('express')
const car = express.Router()

var MongoDB = require('../mongoDB');
var collName = "cars"
const car_columns = ["driver_id", "plate_no", "make", "model", "year", "color"]

const { getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument } = require('./CRUDOps');

car.get("/", async (req, res) => {

    getAllDocuments(MongoDB, "cars", res)

})

car.get("/:id", async (req, res) => {
    let listingQuery = {_id: ObjectId(req.params.id) }

    getOneDocument(MongoDB, collName, listingQuery, res)

})

car.put("/", async (req, res) => {
    createOneDocument(MongoDB, collName, car_columns, req, res)

})

car.post("/", async (req, res) => {
    // update car
    let listingQuery = {_id: ObjectId(req.body.id) }

    updateOneDocumentWithAnyValues(MongoDB, collName, listingQuery, car_columns, req, res)

})

car.delete("/", async (req, res) => {
    
    let listingQuery = {_id: ObjectId(req.body.id)}
    deleteOneDocument(MongoDB, collName, listingQuery, res)

})

car.delete("/deleteAll", async (req, res) => {
    deleteAllDocument(MongoDB, collName, res)
})

module.exports = car;