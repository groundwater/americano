util   = require 'util'

class User
  
  constructor: (@db,@_cards)->
    
  _make: (@id,@email,@password)->
  
  _init: (user_id,next)->
    
    # Initialize Properties from Database
    @db.query 'SELECT * from user', (err,rows)=>
      row       = rows.pop()
      @email    = row.email
      @password = row.password
      @id       = user_id
      next()
    
  save: (next)->
    @db.query 'UPDATE user SET email=? WHERE id=?',
      [@email,@id],
      (err,rows)->
        next(err) if next
    
  # Foreign Keys
  cards: (cb)->
    @_cards.FindByUser @id, cb

module.exports = (app) ->
  
  db  = app.guides.sql.main
  
  # Callback
  Load: (user_id,callback) ->
    user = new User(db,app.models.cards)
    user._init user_id, (err)->
      callback err, user
      
  New: (cb)->
    db.query 'INSERT INTO user (id) VALUES (NULL)', (err,result)->
      if err then cb err
      user = new User(db,app.models.cards)
      user.id = result.insertId
      cb null, user

