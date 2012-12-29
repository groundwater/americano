util = require 'util'

# The actual model class whose instances correspond
# to individual rows in the database
class Page
  
  # This method should not be modified
  constructor: (@db,@models)->
  
  # Setup properties by passing them in after construction
  make: (row)->
    @id = row.id if row.id
    @content = row.content
    @url = row.url
    @hash = row.hash
  
  # Save to the database
  # This can be called multiple times
  save: (next)->
    @db.query 'UPDATE page SET content=?, url=?, hash=? WHERE id=?',
      [@content, @url, @hash, @id],
      (err,rows)->
        next(err) if next

  inspect: ->
    util.format 'Page:', @id, @content, @url, @hash
  
  ## Foreign Key References ##

# Provide the equivalent of class methods
# to lookup and create new models
module.exports = (app) ->
  
  # Create local references to guides
  models = app.models
  guides = app.guides
  sql_db = guides.sql.main
  
  # Load an Existing Object from the Database
  Load: (page_id,next) ->
    page = new Page sql_db,models
    sql_db.query 'SELECT * FROM page WHERE id=?', [page_id], (err,rows)=>
      return next err             if err
      return next 'Result Empty'  if rows.length == 0
      return next 'Too Many Rows' if rows.length > 1
      row = rows.pop()
      page.make row
      next null, page
  
  # Create a New Object and Allocate a Primary Key    
  New: (next)->
    sql_db.query 'INSERT INTO page (id) VALUES (NULL)', (err,result)->
      return next err if err
      page    = new Page sql_db,models
      page.id = result.insertId
      next null, page
  
  Struct: -> 
    content:'' #content
    url:'' #url
    hash:'' #hash
  
  # Range starts from 0
  # For range maximum use -1
  Range: (id_min,id_max,next)->
    if id_max>0
      query  = 'SELECT * FROM page WHERE id>=? AND id<?'
      params = [id_min,id_max]
    else
      query  = 'SELECT * FROM page WHERE id>=?'
      params = [id_min]
    sql_db.query query, params, (err,rows)->
      console.log
      return next err if err
      pages = []
      rows.forEach (row)->
        page = new Page sql_db,models
        page.make row
        pages.push page
      next null, pages
  
  ## Foreign Key Lookups ##

