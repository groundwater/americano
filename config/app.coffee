rude    = require 'rude'
express = require 'express'
ejs     = require 'ejs'

html    = require 'lib/html'
models  = require 'app/models'

routes  = require './routes'

module.exports = (defaults)->
  
  # Setup Application
  app = express()
  
  # Configure Templates
  ejs.open  = '{{'
  ejs.close = '}}'
  
  # Define Configuratinos
  cookieSessionOptions =
    secret: defaults.secret
  
  # Do Configurations
  app.set 'views', defaults.views
  app.use express.logger()
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.cookieSession( cookieSessionOptions  )
  app.use express.csrf()
  app.use '/assets', express.static( defaults.public )
  
  # Use Rude Asset Management
  app.locals.rude  = rude.config()
  app.locals.html  = html
  app.locals.title = defaults.title || 'My Application'
  
  # Attach Valvues (External Resources)
  valves =
    mysql: defaults.mysql
    redis: defaults.redis
    mongo: defaults.mongo
  
  # Attach MVC
  app.valves = valves
  app.routes = routes(app)
  app.models = models(app)

  # Return Application
  app
