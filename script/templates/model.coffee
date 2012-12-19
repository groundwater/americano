util = require 'util'

class {{Card}}
  
  constructor: (@db,@models)->
  
  make: (@id, {{make}})->
  
  save: (next)->
    @db.query 'UPDATE {{card}} SET {{save.sql}} WHERE id=?',
      [{{save.vars}}, @id],
      (err,rows)->
        next(err) if next

module.exports = (app) ->
  
  models = app.models
  guides = app.guides
  
  db     = guides.sql.main
  
  # Load an Existing Object from the Database
  Load: ({{card}}_id,next) ->
    {{card}} = new {{Card}} db,models
    db.query 'SELECT * from {{card}}', (err,rows)=>
      return next err             if err
      return next 'Integrity Violation - Too Many Rows' if rows.length > 1
      row = rows.pop()
      {{card}}.make {{card}}_id, {{save.rows}}
      next null, {{card}}
  
  # Create a New Object and Allocate a Primary Key    
  New: (next)->
    db.query 'INSERT INTO {{card}} (id) VALUES (NULL)', (err,result)->
      return next err if err
      {{card}}    = new {{Card}} db,models
      {{card}}.id = result.insertId
      next null, {{card}}
  
