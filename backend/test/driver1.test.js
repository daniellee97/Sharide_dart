const app = require('../app');
const request = require('supertest');
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');
// let server = app.listen(3000, () => {
//     console.log("Listening to port 3000")
// })

// "license_no", "name", "address", "sjsu_email", "phone_no", "joined_date", "password", "avail"]
let collName = 'driver'
let uri = 'drivers'

// test sample drivers
describe('TEST /' + uri, function() {

    let sjsu_email_test = 'testDriver@sjsu.edu'
    let password_test = 'samplePasswordTestDriver'


    let sampleObject = {
        license_no: '80090',
        name: 'test driver name',
        address: 'test Address',
        sjsu_email: sjsu_email_test,
        phone_no: 6667778888,
        joined_date: '11/24/2021',
        password: password_test,
        avail: 'no'
    }

    let listingQueryGet = {
        sjsu_email: sjsu_email_test,
        password: password_test
    }

    let listingQueryUpdateAvail = {
        sjsu_email: sjsu_email_test,
        avail: 'yes'
    }

    let listingQueryDelete = {
        sjsu_email: sjsu_email_test
    }


    testCreateSampleItem(collName, uri, sampleObject)

    it('test get newly created object ' + collName, (done) => {
        request(app)
        .post('/' + uri + "/logIn")
        .send(listingQueryGet)
        .expect(200, done)
    })

    // Not working for some reason
    it('test update newly created object ' + collName, (done) => {
        request(app)
        .post('/' + uri)
        .send(listingQueryUpdateAvail)
        .expect(200, done)
    })

    it('test delete newly created object ' + collName, (done) => {
        request(app)
        .delete('/' + uri)
        .send(listingQueryDelete)
        .expect(200, done)
    })

    // server.close();

});
