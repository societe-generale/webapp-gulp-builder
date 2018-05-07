module.exports = (gulp, config) ->
  require('./script.coffee') gulp, config
  require('./jade.coffee') gulp, config
  require('./less.coffee') gulp, config
  require('./loopback-services.coffee') gulp, config
  require('./template.coffee') gulp, config
  require('./vendor.coffee') gulp, config

  gulp.task 'compile', [
    'compile:script'
    'compile:less'
    'compile:jade'
    'compile:template'
    'compile:vendor'
    'compile:loopback'
  ]
