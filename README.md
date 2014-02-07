# ng-blank-boilerplate

> A boilerplate project to kickstart new AngularJs & Node projects.


## Introduction

Angular Blank Boilerplate is a boilerplate project to kickstart new AngularJs & Node projects. Supports Bootstrap 3, AngularJS, Express, MongoDB, Karma, Mocha, Coffee and LESS with source map. It also works well with Node Inspector and Node Theseus.


## Quick Start

Install Node.js. Start MongoDB. Make sure that MongoDB is running on its default port (27017). Then:

```sh
$ sudo npm -g install grunt-cli karma bower
$ npm install
$ bower install
$ grunt watch
```

Open another terminal and:
```sh
$ grunt watchtest
```

That's all. Happy coding.


## Motivation
The project was originally forked from [ng-boilerplate](http://joshdmiller.github.io/ng-boilerplate).

ng-boilerplate is a good boilerplate project to start with AngularJs. But it copys JavaScript files to new directory when watching them, rather than serve files directly from source. This makes we unable to live edit code using Chrome DevTools and even Node Inspector: change is made on built files and will lose when we rebuild files.

In order to support Coffee Script (and maybe other languages in next versions) while not make the project become messy, we created "map" task (come with
grunt-watch-change). It helps us clean only generated JS files while keep others untouch.

Another feature we add is the ability to compile only changed file, rather than compile a group of files. Thanks to "watchchange" task.

We also added a lot of features as we writing code. Hope that you will find them useful some day in your development progress.


## Features
- Supports Bootstrap 3, AngularJs, Express, MongoDB, Coffee, Karma and Mocha. Easily to config and start new project.
- Auto compile Coffee files when changed. Only compile the changed files.
- Auto restart server everytime you make change to server files. Run `grunt watch`. (Server restarting may be disabled with `norestart`).
- Auto run unit tests everytime you make change to test files. Run `grunt watchtest` in parallel with `grunt watch`. Optional `grunt watchtest:server` and `grunt watchtest:client`. Run the changed server test files only.
- Copy files to `dist` directory when you are ready to deploy application. Run `grunt build; grunt dist`.
- Copy files to `bin` directory when you are ready to compile, minify source and deploy application. Run `grunt build; grunt compile`.
- Support source map for LESS file.
- Better log and stack trace output.
- Support node-inspector with `save-live-edit` option. Run `grunt inspector`.
- Support node-theseus. Run `grunt theseus`.


## Useful Commands

```sh
$ grunt
$ grunt clean
$ grunt build
$ grunt dist
$ grunt compile
$ grunt test

$ grunt watch
$ grunt watchtest

$ grunt inspector
$ grunt theseus
```

If you want to use node-inspector with 'save-live-edit' enabled, use `grunt inspector` instead of `grunt watch`. This will not restart 'express' server everytime you make change to server files.
