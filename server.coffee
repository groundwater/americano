# Import Environment
PORT      = process.env.PORT      || 8888
SECRET    = process.env.SECRET    || console.warn 'Please Set Application Secret'

#################
##     END     ##
#################

# Native Imports
url     = require 'url'
path    = require 'path'

# Module Imports
express = require 'express'

# Local Imports
config  = require './config/app'
models  = require './app/models'
routes  = require './app/routes'

# Initialize External Resources

# Setup Application Defaults
options= 
  secret: SECRET
  public: path.join __dirname, '/public'
  views : path.join __dirname, '/app/views'

# Attach Guides (External Resources)
guides =

# Listen
app = config models, routes, guides, stdlib, options
app.listen PORT

# Emit Logs
console.log 'Server Listening on Port %d', PORT
