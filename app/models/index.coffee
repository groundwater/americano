crypto = require 'crypto'

module.exports = (app) ->
  
  # RAILS: Models
  users: require('./user')(app)  
