const app = require('../app');
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');
let server = app.listen(3000, () => {
    console.log("Listening to port 3000")
})

let collName = 'driver'
let uri = 'drivers'

// test sample drivers
describe('TEST /' + uri, function() {
    let sampleObjectId = "63aed1458b0c9cdb6d7c9a75"

    let sampleObject = {
        license_no:29229101,
        name: 'test driver name',
        address: 'test Address',
        sjsu_email: 'test sjsu email',
        phone_no: 6667778888,
        joined_date: '11/24/2021',
    }

    testGetSampleItem(collName, uri, sampleObjectId)

    testCreateSampleItem(collName, uri, sampleObject)

    server.close();

});
