const app = require('../app');
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');

app.listen(4000, () => {
    console.log("Listening to port 3000")
})


let collName = 'car'
let uri = 'cars'
// test sample cars
describe('TEST /cars', function() {
    let sampleObjectId = '63a5284875efc5c33b0716d4'

    let sampleObject = {
        driver_id: 11333,
        plate_no: '393B-349C',
        make: 'Hyundai',
        model: 'Camry',
        year: 2019,
        color: 'red'
    }

    testGetSampleItem(collName, uri, sampleObjectId )

    testCreateSampleItem(collName, uri, sampleObject)

});
