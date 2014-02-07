common = require './common'
expect = require('chai').expect
request = require('supertest')(common.localhost)

describe 'Sample', ->

  describe 'index.html', ->
    it 'should have AppCtrl in responsed html', (done) ->
      request.get('/')
      .expect(200)
      .end (err, res)->
        expect(res.text).match RegExp 'AppCtrl'
        done()
