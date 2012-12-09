express = require 'express'

module.exports = (app,config)->
  
  # Define Configuratinos
  cookieSessionOptions =
    secret: config.secret
  
  # Do Configurations
  app.set 'views', 'app/views'
  app.use express.logger()
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.cookieSession( cookieSessionOptions  )
  app.use express.csrf()
  app.use '/assets', express.static( config.public )

