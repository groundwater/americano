express = require 'express'
routes  = require './app/routes'

# Import Environment

PORT   = process.env.PORT   || 8888
SECRET = process.env.SECRET || 'abc123'

# Define Configuratinos
cookieSessionOptions =
  secret: SECRET

# Setup Application
app = express()

app.set 'views', 'app/views'

app.use express.logger()
app.use express.compress()
app.use express.bodyParser()
app.use express.cookieParser()
app.use express.cookieSession( cookieSessionOptions  )
app.use express.csrf()
app.use '/assets', express.static( __dirname + '/public' )

# Add Routes
routes(app)

# Run Application
app.listen(PORT)
console.log 'Server Listening on Port %d', PORT
