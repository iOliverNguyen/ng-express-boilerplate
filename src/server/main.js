var express = require('express');
var http = require('http');
var path = require('path');

var app = require('./app');
app.use(express.static(path.join(__dirname, 'public')));

http.createServer(app).listen(app.get('port'), function() {
  console.log('Server is listening on port ' + app.get('port'));
});
