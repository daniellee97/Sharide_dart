const app = require('../app');
const request = require('supertest');
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');
let server = app.listen(3000, () => {
    console.log("Listening to port 3000")
})

let collName = 'tripProcessing'
let uri = 'tripProcessing'

describe('TEST /uri', function() {

    let driver_email_test = 'driverTest@sjsu.edu'
    let customer_email_test = 'customerTest@sjsu.edu'

    let sampleObject = {
        driver_email: driver_email_test,
        customer_email: customer_email_test
    }

    let listingQueryGet = {
        driver_email: driver_email_test,
        customer_email: customer_email_test
    }

    let listingQueryForCustomer = {
        customer_email: customer_email_test
    }

    let listingQueryForDriver = {
        driver_email: driver_email_test
    }


    let listingQueryDelete = {
        driver_email: driver_email_test,
        customer_email: customer_email_test
    }

    testCreateSampleItem(collName, uri, sampleObject)

    it('test get newly created object ' + collName, (done) => {
        request(app)
        .post('/' + uri + "/get")
        .send(listingQueryGet)
        .expect(200, done)
    })

    it('test get newly created object for customer' + collName, (done) => {
        request(app)
        .post('/' + uri + "/forCustomer")
        .send(listingQueryForCustomer)
        .expect(200, done)
    })

    it('test get newly created object for passenger' + collName, (done) => {
        request(app)
        .post('/' + uri + "/forDriver")
        .send(listingQueryForDriver)
        .expect(200, done)
    })

    it('test delete newly created object ' + collName, (done) => {
        request(app)
        .delete('/' + uri)
        .send(listingQueryDelete)
        .expect(200, done)
    })

    server.close();
});
