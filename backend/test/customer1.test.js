const app = require('../app');
const request = require('supertest');
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');
// let server = app.listen(3000, () => {
//     console.log("Listening to port 3000")
// })

let collName = 'customer'
let uri = 'customers'

// test sample customers
describe('TEST /customers', function() {

    let sjsu_email_test = 'sampleStudentTest123@sjsu.edu'
    let password_test = 'samplePasswordTest'

    let sampleObject = {
        name: 'Sample student',
        sjsu_email: sjsu_email_test,
        password: password_test,
        address: '1 Washington Square',
        phone_no: 6667778888,
        joined_date: '11/24/2001' 
    }

    let listingQueryGet = {
        sjsu_email: sjsu_email_test,
        password: password_test
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

    it('test delete newly created object ' + collName, (done) => {
        request(app)
        .delete('/' + uri)
        .send(listingQueryDelete)
        .expect(200, done)
    })


    // server.close();
});
