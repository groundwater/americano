rude    = require 'rude'
express = require 'express'
ejs     = require 'ejs'

html    = require 'lib/html'
models  = require 'app/models'

routes  = require './routes'

module.exports = (app,config)->
  
  # Configure Templates
  ejs.open  = '{{'
  ejs.close = '}}'
  
  # Define Configuratinos
  cookieSessionOptions =
    secret: config.secret
  
  # Do Configurations
  app.set 'views', config.views
  app.use express.logger()
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.cookieSession( cookieSessionOptions  )
  app.use express.csrf()
  app.use '/assets', express.static( config.public )
  
  # Use Rude Asset Management
  app.locals.rude  = rude.config()
  app.locals.html  = html
  app.locals.title = config.title || 'My Application'
  
  # Attach Databases
  app.mysql = config.mysql
  app.redis = config.redis
  app.mongo = config.mongo
  
  # Attach MVC
  app.models = models(app)
  app.routes = routes(app)

