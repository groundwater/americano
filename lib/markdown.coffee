fs         = require 'fs'
Path       = require 'path'

{Markdown} = require 'node-markdown'

rude       = (require 'rude').config()

# This markdown middleware renders markdown documents
# that match against an incoming URL
module.exports = (options={})->
  
  base_dir  = options.base_dir  || 'docs'
  base_path = options.base_path || '/docs'
  extension = options.extension || '.md'
  indexname = options.indexname || 'index'
  template  = options.template
  override  = options.override  || false
  ruderegex = options.regex     || /¿(.*?)\?/gi
  
  prepare   = (data)->
    data.replace ruderegex , (match,$1,offset)->
      rude $1.trim()
  
  # Resolve markdown data with the following protocol
  getData   = (path,callback)->
    
    # Try the exact path
    fs.exists path, (exists)->
      
      # Exact path matched
      if exists
        
        # Check if the exact path is a file or directory
        fs.stat path, (err,stat)->
          return callback err if err
          
          # Return the file directly
          if stat.isFile()
            fs.readFile path, callback
          
          # Try resolving the default index file in the directory
          else if stat.isDirectory()
            index = Path.join path, indexname + extension
            getData index, callback
      
      # Exact path did not match
      else
        
        # If path contains no file extension,
        # try again with the default extension,
        # otherwise fail
        
        len = path.length - extension.length + 1
        if (path.indexOf extension) == len
          callback true
        else
          getData path + extension, callback
  
  (req,res,next)->
    
    # Capture URLs that match `base_path`
    if (req.path.indexOf base_path) == 0
      
      name = req.path.substr base_path.length
      file = Path.resolve Path.join base_dir, name
      
      # Get markdown data based on resolution protocol
      getData file, (err,data)->
        
        return next() if err
        
        prepared = prepare data.toString()
        
        # Render markdown
        markdown = Markdown prepared
            
        # Wrap markdown in express template
        if template
          render=
            body: markdown
          res.render template, render
        else
          res.send 200, markdown
    
    # Non-matched URLs are passed to the next middleware
    else
      next()

