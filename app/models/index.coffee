crypto = require 'crypto'

module.exports = (app) ->
  
  demo: 
    slowquery: (seconds,cb) ->
      app.valves.mysql.query 'SELECT SLEEP(?)', [seconds], cb
