# Import Environment
PORT      = process.env.PORT      || 8888
SECRET    = process.env.SECRET    || console.warn 'Please Set Application Secret'
MYSQL_URL = process.env.MYSQL_URL || console.warn 'Please Set MySQL URL'
REDIS_URL = process.env.REDIS_URL || console.warn 'Please Set Redis URL'
MONGO_URL = process.env.MONGO_URL || console.warn 'Please Set Mongo URL'

#################
## NodeFly APM ##
#################

APP_KEY   = process.env.NODEFLY_KEY
APP_NAME  = process.env.NODEFLY_NAME
APP_HOST  = process.env.NODEFLY_HOST
if APP_KEY
  nodefly = require 'nodefly'
  nodefly.profile APP_KEY, [APP_NAME,APP_HOST]

#################
##     END     ##
#################

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
stdlib  = require './lib'

# Initialize External Resources
redis_config = url.parse REDIS_URL
mongo_config = url.parse MONGO_URL

mysql_db = mysql.createConnection MYSQL_URL
redis_db = redis.createClient redis_config.port, redis_config.hostname

mongo_server = new mongo.Server mongo_config.hostname, parseInt mongo_config.port
mongo_db     = new mongo.Db 'test', mongo_server, {w: 1}

redis_db.on 'error',   -> console.warn 'Redis Reconnecting'
redis_db.on 'connect', -> console.warn 'Redis Connected'

# Setup Application Defaults
options= 
  secret: SECRET
  public: path.join __dirname, '/public'
  views : path.join __dirname, '/app/views'

# Attach Guides (External Resources)
mongo_db.open (err,mongo_client)->
  throw err if err
  
  mongo_collection = new mongo.Collection(mongo_client, 'test')
  
  guides =
  
    sql : 
      main: mysql_db
  
    redis : 
      main: redis_db
  
    mongo : 
      main: mongo_collection 

  # Listen
  app = config models, routes, guides, stdlib, options
  app.listen PORT

  # Emit Logs
  console.log 'Server Listening on Port %d', PORT
