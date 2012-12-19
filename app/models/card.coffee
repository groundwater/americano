util = require 'util'

class Card
  
  constructor: (@db,@models)->
  
  make: (@id,@name,@user_id)->
  
  save: (next)->
    @db.query 'UPDATE card SET name=?, user=? WHERE id=?',
      [@name,@user_id,@id],
      (err,rows)->
        next(err) if next
  
  ## INFO: Foreign Keys ##
  
  # Singular Many-to-One Relationship
  user: (cb)->
    @models.user.Load @id, cb

module.exports = (app) ->
  
  models = app.models
  guides = app.guides
  
  db     = guides.sql.main
  
  # Load an Existing Object from the Database
  Load: (card_id,next) ->
    card = new Card db,models
    db.query 'SELECT * from card', (err,rows)=>
      return next err             if err
      return next 'Too Many Rows' if rows.length > 1
      row = rows.pop()
      card.make card_id,row.name,row.user
      next()
  
  # Create a New Object and Allocate a Primary Key    
  New: (cb)->
    db.query 'INSERT INTO card (id) VALUES (NULL)', (err,result)->
      return cb err if err
      card    = new Card db,models
      card.id = result.insertId
      cb null, card
  
  FindByUser: (user_id,next)->
    cards = []
    db.query 'SELECT * FROM card WHERE user=?', [user_id], (err,rows)->
      if err then return next err
      rows.forEach (row)->
        card = new Card db,models
        card.make row.id, row.name, row.user
        cards.push card
      next null, cards if next
    
