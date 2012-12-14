rude    = require 'rude'
express = require 'express'
ejs     = require 'ejs'

html    = require 'lib/html'
models  = require 'app/models'

router  = require './router'

module.exports = (model,routes,valves,options)->
  
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
  
  # Use Rude Asset Management
  app.locals.rude  = rude.config()
  app.locals.html  = html
  app.locals.title = options.title || 'My Application'
  
  # Attach MVC
  app.valves = valves
  app.router = router(app,routes app)
  app.models = models(app)

  # Return Application
  app
