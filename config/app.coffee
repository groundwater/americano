rude    = require 'rude'
express = require 'express'
ejs     = require 'ejs'

html    = require 'lib/html'

router  = require './router'

# Create and configure an express application
# based on the provided routes, guides, models, library
# and other options
module.exports = (models,routes,guides,lib,options)->
  
  # Setup Application
  app = express()
  
  # Configure Templates
  ejs.open  = '{{'
  ejs.close = '}}'
  
  # Define Configuratinos
  cookieSessionOptions =
    secret: options.secret
  
  # Do Configurations
  app.set 'views', options.views
  app.use express.logger()
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.cookieSession( cookieSessionOptions  )
  app.use express.csrf()
  app.use '/assets', express.static( options.public )
  
  # Template Defaults
  app.locals.title = options.title || 'My Application'
  
  # Use Rude Asset Management
  app.locals.rude  = rude.config()
  app.locals.html  = html
  
  # Attach Library
  app.lib    = lib
  
  # Attach MVC
  app.guides = guides
  app.models = models(app)
  app.router = router(app,routes app)
  
  # Return Application
  app
