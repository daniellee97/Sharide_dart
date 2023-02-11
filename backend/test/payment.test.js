const app = require('../app');
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');
app.listen(3000, () => {
    console.log("Listening to port 3000")
})

let collName = 'payment'
let uri = 'payments'

describe('TEST /uri', function() {
    let sampleObjectId = "63b39f6939efba391d819a61"

    let sampleObject = {
        customer_id: '01020202',
        type: 'normal test',
        base_rate: '1',
        tip_amount: '123',
        total_amount: '1840',
        transaction_id: '3223232'
    }

    testGetSampleItem(collName, uri, sampleObjectId)

    testCreateSampleItem(collName, uri, sampleObject)

});
