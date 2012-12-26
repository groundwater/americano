fs         = require 'fs'
path       = require 'path'

{Markdown} = require 'node-markdown'

# This markdown middleware renders markdown documents
# that match against an incoming URL
module.exports = (options={})->
  
  base_dir  = options.base_dir  || 'docs'
  base_path = options.base_path || '/'
  extension = options.extension || '.md'
  template  = options.template
  override  = options.override  || false
  
  (req,res,next)->
    
    # Capture URLs that match `base_path`
    if (req.path.indexOf base_path) == 0
      
      rel  = req.path.substr base_path.length
      name = rel + extension
      file = path.resolve path.join base_dir, name
      
      fs.exists file, (exists)->
        
        # Matched a markdown document
        if exists
          
          fs.readFile file, (err,data)->
            return res.send 500, err if err
            
            # Render markdown
            markdown = Markdown data.toString()
            
            # Wrap markdown in express template
            if template
              render=
                body: markdown
              res.render template, render
            else
              res.send 200, markdown
        
        else
          
          # Possibly fall through to the next middleware
          if override
            res.send 404
          else
            next()
      
    else
      next()

