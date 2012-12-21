util = require 'util'

# The actual model class whose instances correspond
# to individual rows in the database
class User

  # This method should not be modified
  constructor: (@db,@models)->
  
  # Setup properties by passing them in after construction
  make: (@id,@email,@password)->
  
  # Save to the database
  # This can be called multiple times
  save: (next)->
    @db.query 'UPDATE user SET email=? WHERE id=?',
      [@email,@id],
      (err,rows)->
        next(err) if next
    
  ## INFO: Foreign Keys ##
  
  # Pluralize One-to-Many Relationships
  cards: (cb)->
    @models.cards.FindByUser @id, cb

# Provide the equivalent of class methods
# to lookup and create new models
module.exports = (app) ->
  
  # Create local references to guides
  models = app.models
  guides = app.guides  
  db     = guides.sql.main
  
  # Load an Existing Object from the Database
  Load: (user_id,next) ->
    user = new User db,models
    db.query 'SELECT * from user', (err,rows)=>
      return next err             if err
      return next 'Too Many Rows' if rows.length > 1
      row = rows.pop()
      card.make user_id,row.email,row.password
      next()
  
  # Create a New Object and Allocate a Primary Key  
  New: (cb)->
    db.query 'INSERT INTO user (id) VALUES (NULL)', (err,result)->
      return cb err if err
      user    = new User db,models
      user.id = result.insertId
      cb null, user

