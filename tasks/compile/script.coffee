coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
gif           = require 'gulp-if'
gutil         = require 'gulp-util'
livereload    = require 'gulp-livereload'
ngAnnotate    = require 'gulp-ng-annotate'
plumber       = require 'gulp-plumber'
replace       = require 'gulp-replace-task'
sourcemaps    = require 'gulp-sourcemaps'
uglify        = require 'gulp-uglify'
addSrc        = require 'gulp-add-src'

module.exports = (gulp, config) ->
  gulp.task 'compile:script', ->
    gulp.src config.input.coffee
    .pipe plumber()
    .on 'error', gutil.log
    .pipe gif config.input.replace.enabled, replace config.input.replace
    .pipe coffee
      bare: true
    .pipe addSrc.append(config.input.javascript)
    .pipe ngAnnotate()
    .pipe gif config.minify, uglify()
    .pipe concat config.output.application
    .pipe gif not config.output.disable_sourcemaps, sourcemaps.init()
    .pipe gif not config.output.disable_sourcemaps, sourcemaps.write()
    .pipe gulp.dest config.output.script
    .pipe livereload()
