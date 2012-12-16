util = require 'util'

class Card
  
  constructor: (@db)->
    # Setup Uninitialized Properties
  
  _make: (@id,@name,@_user)->
  
  _init: (user_id,next)->
    
    # Initialize Properties from Database
    @db.query 'SELECT * from card', (err,rows)=>
      if err             then return next err
      if rows.length > 1 then return next 'Too Many Rows'
        
      row = rows.pop()
      
      @_make user_id, row.name, row.user
      
      next()
    
  save: (next)->
    @db.query 'UPDATE card SET name=?, user=? WHERE id=?',
      [@name,@_user,@id],
      (err,rows)->
        next(err) if next
  
  inspect: ->
    
    # List Local Properties
    util.format "%d %s", @id, @name
    
  # Foreign Keys
  user: (cb)->
    # 
    cb()
        

module.exports = (app) ->
  
  db = app.guides.sql.main
  
  # Callback
  Load: (card_id,callback) ->
    card = new Card(db)
    card._init card_id, (err)->
      callback err,user
      
  New: (cb)->
    db.query 'INSERT INTO card (id) VALUES (NULL)', (err,result)->
      if err then return cb err
      card = new Card(db)
      card.id = result.insertId
      cb null, card

  FindByUser: (user_id,callback)->
    cards = []
    db.query 'SELECT * FROM card WHERE user=?', [user_id], (err,rows)->
      if err then return callback err
      rows.forEach (row)->
        card = new Card(db)
        card._make row.id, row.name, row.user
        cards.push card
      callback null, cards if callback
    
