const app = require('../app');
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');
app.listen(3000, () => {
    console.log("Listening to port 3000")
})

let collName = 'trip'
let uri = 'trips'

describe('TEST /uri', function() {
    let sampleObjectId = "63b3c9b894bc544af70bf43c"

    let sampleObject = {
        driver_id: '03',
        customer_id: '05',
        start_location_id: '1',
        end_location_id: '123',
        payment_id: '1840',
        car_id: '3223232',
        trip_requested_timestamp: '09:34:02',
        trip_start_timestamp: '09:45:11',
        wait_time: 18, 
        trip_status: 'completed'
    }

    testGetSampleItem(collName, uri, sampleObjectId)

    testCreateSampleItem(collName, uri, sampleObject)

});
