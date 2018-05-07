coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
gif           = require 'gulp-if'
gutil         = require 'gulp-util'
livereload    = require 'gulp-livereload'
ngAnnotate    = require 'gulp-ng-annotate'
order         = require 'gulp-order'
plumber       = require 'gulp-plumber'
replace       = require 'gulp-replace-task'
sourcemaps    = require 'gulp-sourcemaps'
uglify        = require 'gulp-uglify'
rev           = require 'gulp-rev'
addSrc        = require 'gulp-add-src'

module.exports = (gulp, config) ->
  gulp.task 'compile:script', ->
    gulp.src config.input.coffee
    .pipe plumber()
    .on 'error', gutil.log
    .pipe gif config.input.replace.enabled, replace config.input.replace
    .pipe coffee(config.coffee)
    .pipe addSrc.append(config.input.javascript)
    .pipe ngAnnotate(config.ngAnnotate)
    .pipe gif config.minify, uglify(config.uglify)
    .pipe order config.input.order or ['*']
    .pipe concat config.output.application
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
