require('./test/devlogs').modeInfo();

var express = require('express');
var path = require('path');
var http = require('http');

var app = require('./app');
app.use(express.static(path.join(__dirname, 'public')));

// In development, we want to serve assets, src and vendor files from src directory
app.use('/assets', express.static(path.resolve(__dirname, '../assets')));
app.use('/src', express.static(path.resolve(__dirname, '../../src')));
app.use('/vendor', express.static(path.resolve(__dirname, '../../vendor')));

http.createServer(app).listen(app.get('port'), function() {
  console.log('Server is listening on port ' + app.get('port'));
});
