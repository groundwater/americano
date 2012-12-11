url     = require 'url'

# Module Imports
express = require 'express'
mysql   = require 'mysql'
redis   = require 'redis'
mongo   = require 'mongodb'

# Local Imports
config  = require './config/app'

# Import Environment
PORT      = process.env.PORT      || 8888
SECRET    = process.env.SECRET    || console.warn('Please Set Application Secret')
MYSQL_URL = process.env.MYSQL_URL || console.warn('Please Set MySQL URL')
REDIS_URL = process.env.REDIS_URL || console.warn('Please Set Redis URL')
MONGO_URL = process.env.MONGO_URL || console.warn('Please Set Mongo URL')

# Setup Application
app = express()

# Setup External Resources
redis_config = url.parse(REDIS_URL)
mongo_config = url.parse(MONGO_URL)

mysql_db = mysql.createConnection(MYSQL_URL)
redis_db = redis.createClient(redis_config.port, redis_config.hostname)
mongo_db = new mongo.Server(mongo_config.hostname, mongo_config.port)

redis_db.on 'error',   -> console.warn 'Redis Reconnecting'
redis_db.on 'connect', -> console.warn 'Redis Connected'

# Configure Application and Routes
settings = 
  secret: SECRET
  public: __dirname + '/public'
  views : __dirname + '/app/views'
  mysql : mysql_db
  redis : redis_db
  mongo : mongo_db

config(app,settings)

# Run Application
app.listen(PORT)

# Emit Logs
console.log 'Server Listening on Port %d', PORT
