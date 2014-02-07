var common = require('./common');
var expect = require('chai').expect;
var request = require('supertest')(common.localhost);

describe('Application', function() {

  var cookie = 0;
  before(function(done) {
    done();
  });

  describe('index.html', function() {
    it('should be 200 OK', function(done) {
      request.get('/')
      .expect(200)
      .end(function(err, res) {
        if (err) {
          return done(err);
        }
        done();
      });

    });
  });
});
