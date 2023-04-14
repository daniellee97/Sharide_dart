const app = require('../app');
const MongoDB = require("../mongoDB")
const { testGetSampleItem, testCreateSampleItem } = require('./testOps');


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

