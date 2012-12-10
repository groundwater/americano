# Module Imports
express = require 'express'

# Local Imports
routes  = require './config/routes'
config  = require './config/app'

# Import Environment
PORT      = process.env.PORT      || 8888
SECRET    = process.env.SECRET    || 'abc123'
MYSQL_URL = process.env.MYSQL_URL || 'mysql://localhost/myapp'
REDIS_URL = process.env.REDIS_URL || 'redis://localhost'
MONGO_URL = process.env.MONGO_URL || 'mongo://localhost:27017'

# Setup Application
app = express()

# Configure Application and Routes
settings = 
  secret: SECRET
  public: __dirname + '/public'
  views : __dirname + '/app/views'

config(app,settings)
routes(app)

# Run Application
app.listen(PORT)

# Emit Logs
console.log 'Server Listening on Port %d', PORT
