util = require 'util'

class User
  constructor: (@db)->
    
    # Setup Uninitialized Properties
    @firstName = 'Bob'
    @lastName  = 'Smith'
    @userId    = 0
  
  _init: (user_id,next)->
    
    # Initialize Properties from Database
    # db.query('SELECT ... ')
    # next(  )
    
  save: (next)->
    
    # db.query('UPDATE ... ')
    # next()
  
  inspect: ->
    
    # List Local Properties
    util.format "%s %s", @firstName, @lastName

module.exports = (app) ->
  
  db = app.guides.sql.main
  
  # Callback
  Load: (user_id,callback) ->
    user = new User(db)
    user._init user_id, (err)->
      callback err,user
      
  New: ()->
    new User(db)

  Find: (query,callback)->
    # Find User by Query
