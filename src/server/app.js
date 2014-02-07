var express = require('express');
var app = express();
module.exports = app;

var path = require('path');
var config = require('./config.json');


// Connect to mongodb
var mongoose = require('mongoose');

var dbname = config.dbname;
process.argv.forEach(function(val, index) {
  if (val.indexOf('--dbname=') === 0) {
    dbname = val.slice('--dbname='.length);
  }
});

mongoose.connect('mongodb://' + config.dbserver + '/' + dbname);


// Setup application configuration
global.kRootDirPath = __dirname;

app.set('port', process.env.PORT || 80);
app.set('views', path.join(__dirname, 'views'));

app.use(app.router);
app.use(express.cookieParser());
app.use(express.cookieParser(config.secret));
app.use(express.favicon());
app.use(express.json());
app.use(express.logger('dev'));
app.use(express.methodOverride());
app.use(express.urlencoded());
app.use(express.session({
  secret: config.secret
}));


// Development only
if (app.get('env') == 'development') {
  app.use(express.errorHandler());
}


// Setup router
var router = require('./routes');
router.setup(app);
