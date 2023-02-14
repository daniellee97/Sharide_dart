const app = require('../app');
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');
let server = app.listen(3000, () => {
    console.log("Listening to port 3000")
})

let collName = 'document'
let uri = 'documents'

// test sample document
describe('TEST /' + uri, function() {
    let sampleObjectId = "63aeb4943324972da5df09a0"

    let sampleObject = {
        driver_id: '01020202',
        doc_name: 'sample doc name',
        doc_category: 'sample category',
        document_code: '011111',
        expiration_date: '11/20/2050',
    }

    testGetSampleItem(collName, uri, sampleObjectId)

    testCreateSampleItem(collName, uri, sampleObject)

    server.close();
});
