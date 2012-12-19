crypto = require 'crypto'

async  = require 'async'

module.exports = (app)->
  
  ## ----/Add Ons/---- ##
  logs = []
  push = (item)-> logs.push item
  
  db    = app.guides.sql.main
  redis = app.guides.redis.main
  mongo = app.guides.mongo.main
  
  mysql_call = (next)->
    db.query 'SELECT COUNT(1)', next

  redis_call = (next)->
    redis.set 'KEY', 'Value'
    redis.get 'KEY', next

  mongo_call = (next)->
    doc = 
      message: 'Hello World'
    mongo.insert doc, {}, next
    
  node_call = ->
    crypto.createDiffieHellman(100)
  ## ----/END/---- ##
  
  block: (req,res) ->
    
    [1..20].forEach (next)->
      process.nextTick -> 
        crypto.createDiffieHellman(150)
    
    res.send 'Done'
  
  multisql: (req,res)->
    db.query 'SELECT SLEEP(.01)', ->
      db.query 'SELECT SLEEP(.1)', ->
        db.query 'SELECT SLEEP(1)', ->
          res.send 'DONE'
  
  index: (req,res) ->
    res.send 'Ok'
  
  mysql: (req,res) ->
    node_call()
    mysql_call ->
      res.send 'Done'
    
  all: (req,res) ->
    push req
    node_call()
    redis_call ->
      mysql_call ->
        mongo_call ->
          res.send 'Done'
    
  node: (req,res) ->
    node_call()
    res.send 'Done'
  
  redis: (req,res) ->
    node_call()
    redis_call -> res.send 'Done'
    
  mongo: (req,res) ->
    node_call()
    mongo_call -> 
      res.send 'Done'
