var path = require('path');

function wrap(app) {

  if (app.get('env') !== 'development') {
    return app;
  }

  function cat(fn) {
    return function(req, res, next) {
      try {
        fn.apply(global, arguments);

      } catch (e) {
        console.error(e);
        console.error(e.stack);

        res.send(500, 'Server Error');
      }
    };
  }

  var o = {};
  ['get', 'post', 'put', 'delete'].forEach(function(m) {
    o[m] = (function(app, fn) {
      return function() {
        fn.apply(app, [].map.call(arguments, function(a) {
          return typeof a == 'function' ? cat(a) : a;
        }));
      };
    })(app, app[m]);
  });

  return o;
}

function serveAppView(file) {
  return function(req, res) {
    res.sendfile(path.join(global.kRootDirPath, 'appviews', file));
  };
}

function setup(app) {
  app = wrap(app);

  app.get('/', serveAppView('index.html'));
  app.get('/login', serveAppView('login.html'));
  app.get('/register', serveAppView('register.html'));
}

module.exports.setup = setup;
