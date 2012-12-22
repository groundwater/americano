util = require 'util'

# The actual model class whose instances correspond
# to individual rows in the database
class {{Card}}
  
  # This method should not be modified
  constructor: (@db,@models)->
  
  # Setup properties by passing them in after construction
  make: (row)->
    @id = row.id
{{make}}
  
  # Save to the database
  # This can be called multiple times
  save: (next)->
    @db.query 'UPDATE {{card}} SET {{save.sql}} WHERE id=?',
      [{{save.vars}}, @id],
      (err,rows)->
        next(err) if next

  ## Foreign Key References ##

# Provide the equivalent of class methods
# to lookup and create new models
module.exports = (app) ->
  
  # Create local references to guides
  models = app.models
  guides = app.guides
  sql_db = guides.sql.main
  
  # Load an Existing Object from the Database
  Load: ({{card}}_id,next) ->
    {{card}} = new {{Card}} sql_db,models
    sql_db.query 'SELECT * from {{card}} WHERE id=?', [{{card}}_id], (err,rows)=>
      return next err             if err
      return next 'Result Empty'  if rows.length == 0
      return next 'Too Many Rows' if rows.length > 1
      row = rows.pop()
      {{card}}.make row
      next null, {{card}}
  
  # Create a New Object and Allocate a Primary Key    
  New: (next)->
    sql_db.query 'INSERT INTO {{card}} (id) VALUES (NULL)', (err,result)->
      return next err if err
      {{card}}    = new {{Card}} sql_db,models
      {{card}}.id = result.insertId
      next null, {{card}}
  
  ## Foreign Key Lookups ##
