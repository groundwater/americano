crypto = require 'crypto'

module.exports = (app) ->
  
  ## Include Models ##
  
  # e.g.
  # users: require('./user')(app)  

  pages: require('./pages')(app)
