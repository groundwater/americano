crypto = require 'crypto'

module.exports = (app) ->
  
  user: 
    name: ->
      app.mysql.query('SELECT COUNT(1)')
      "Bob"
  
