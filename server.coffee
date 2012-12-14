# Import Environment
PORT      = process.env.PORT      || 8888
SECRET    = process.env.SECRET    || console.warn 'Please Set Application Secret'
MYSQL_URL = process.env.MYSQL_URL || console.warn 'Please Set MySQL URL'
REDIS_URL = process.env.REDIS_URL || console.warn 'Please Set Redis URL'
MONGO_URL = process.env.MONGO_URL || console.warn 'Please Set Mongo URL'
APP_KEY   = process.env.NODEFLY_KEY
APP_NAME  = process.env.NODEFLY_NAME
APP_HOST  = process.env.NODEFLY_HOST

# NodeFly APM #
if APP_KEY
  nodefly = require 'nodefly'
  nodefly.profile APP_KEY, [APP_NAME,APP_HOST]
  console.log 'Starting NodeFly Profiler with Key %s and Name "%s - %s"', APP_KEY, APP_NAME, APP_HOST

# Native Imports
url     = require 'url'
path    = require 'path'

# Module Imports
express = require 'express'
mysql   = require 'mysql'
redis   = require 'redis'
mongo   = require 'mongodb'

# Local Imports
config  = require './config/app'
models  = require './app/models'
routes  = require './app/routes'

# Initialize External Resources
redis_config = url.parse REDIS_URL
mongo_config = url.parse MONGO_URL

mysql_db = {} #mysql.createConnection MYSQL_URL
redis_db = {} #redis.createClient redis_config.port, redis_config.hostname
mongo_db = {} #new mongo.Server mongo_config.hostname, mongo_config.port

redis_db.on 'error',   -> console.warn 'Redis Reconnecting'
redis_db.on 'connect', -> console.warn 'Redis Connected'

# Setup Application Defaults
options= 
  secret: SECRET
  public: path.join __dirname, '/public'
  views : path.join __dirname, '/app/views'

# Attach Guides (External Resources)
guides =
  
  sql : 
    main: mysql_db
  
  redis : 
    main: redis_db
  
  mongo : 
    main: mongo_db

# Listen
app = config models, routes, guides, options
app.listen PORT

# Emit Logs
console.log 'Server Listening on Port %d', PORT
