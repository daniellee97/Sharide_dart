const app = require('../app');
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');
let server = app.listen(3000, () => {
    console.log("Listening to port 3000")
})

let collName = 'customer'
let uri = 'customers'

// test sample customers
describe('TEST /customers', function() {
    let sampleObjectId = "63ad4b97a9584d1da1237b7b"

    let sampleObject = {
        name: 'Sample student',
        sjsu_email: 'sampleStudent@sjsu.edu',
        password: 'samplePassword',
        address: '1 Washington Square',
        phone_no: 6667778888,
        joined_date: '11/24/2001' 
    }

    testGetSampleItem(collName, uri, sampleObjectId)

    testCreateSampleItem(collName, uri, sampleObject)

    server.close();
});
