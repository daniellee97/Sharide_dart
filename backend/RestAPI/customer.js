const express = require('express');
const { ObjectId } = require('mongodb');

const customer = express.Router()

var MongoDB = require('../mongoDB');
const { getAllDocuments, getOneDocument, createOneDocument, updateOneDocumentWithAnyValues, deleteOneDocument, deleteAllDocument} = require('./CRUDOps');
var collName = "customers"
const customer_columns = ["name", "sjsu_email", "password", "address", "phone_no", "joined_date"]

const getCustomerAddress = async (database, collName, customerId, res) => {
    const listingQuery = { _id: new ObjectId(customerId) };
    const projection = { address: 1 };
    const customerDoc = await (await database).collection(collName).findOne(listingQuery, { projection });
  
    if (!customerDoc) {
      return res.status(404).send("Customer not found");
    }
    const address = customerDoc.address;
    res.send(address);
  }

customer.get("/:id/address", async (req, res) => {
    getCustomerAddress(MongoDB, collName, req.params.id, res);
  });

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
    let listingQuery = {_id: new ObjectId(req.params.id) }

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