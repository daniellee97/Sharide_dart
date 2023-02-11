const request = require('supertest');
const app = require('../app')

const testGetSampleItem = (collName, uri, objectId) => {
    it('test get sample ' + collName, (done) => {
        request(app)
        .get('/' + uri + '/' + objectId)
        .set('Accept', 'application/json')
        .expect(200, done);
    })
}

const testCreateSampleItem = (collName, uri, sampleObject) => {
    it('test create new ' + collName, (done) => {
        request(app)
        .put('/' + uri)
        .send(sampleObject)
        .expect(200, done)
    })

}

module.exports = {testGetSampleItem, testCreateSampleItem}