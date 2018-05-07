concat          = require 'gulp-concat'
filter          = require 'gulp-filter'
gif             = require 'gulp-if'
gulp            = require 'gulp'
gutil           = require 'gulp-util'
livereload      = require 'gulp-livereload'
mainBowerFiles  = require 'main-bower-files'
plumber         = require 'gulp-plumber'
sourcemaps      = require 'gulp-sourcemaps'
uglify          = require 'gulp-uglify'
rev             = require 'gulp-rev'

module.exports = (gulp, config) ->
  gulp.task 'compile:vendor', ->
    gulp.src mainBowerFiles()
    .pipe plumber()
    .on 'error', gutil.log
    .pipe filter '**/*.js'
    .pipe concat config.output.vendor
    .pipe gif config.minify, uglify()
    .pipe sourcemaps.init()
    .pipe sourcemaps.write()
    .pipe gif not config.output.disable_cache_busting, rev()
    .pipe gulp.dest config.output.script
    .pipe gif not config.output.disable_cache_busting, rev.manifest({
      base: config.output.path,
      path: config.output.path + '/rev-manifest.json',
      merge: true
    })
    .pipe gif not config.output.disable_cache_busting, gulp.dest config.output.path
    .pipe livereload()
