# Routes are analogous to MVC controllers
#
# The main application is injected as part of the
# application boot process.
module.exports = (app)->
  
  # Create local references to guides
  db    = app.guides.sql.main
  redis = app.guides.redis.main
  mongo = app.guides.mongo.main
  
  # Routes are decoupled from express paths
  index: (req,res) ->
    
    # Pass renderable content into template
    render = 
      user: req.session.user
      
    # Render a template from the `views` directory
    res.render 'index.ejs', render
  
  login: (req,res) ->
    
    # Set the name of the logged in user
    req.session.user = 'bob'
    
    # Redirect after login
    res.redirect '/'
