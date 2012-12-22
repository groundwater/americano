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
  # index: (req,res) ->
  #   
  #   user_id = parseInt req.session.user
  #   
  #   # Pass renderable content into template
  #   app.models.users.Load user_id, (e,user)->
  #     return res.send err,500 if e
  #     
  #     render=
  #       user: user
  #     
  #     # Render a template from the `views` directory
  #     res.render 'index.ejs', render
  # 
  # login: (req,res) ->
  #   
  #   # Set the name of the logged in user
  #   app.models.users.New (err,user)->
  #     return res.send err,500 if err
  #     
  #     user.fname = 'Bob'
  #     user.lname = 'Smith'
  #     
  #     req.session.user = user.id
  #     
  #     user.save ->
  #       
  #       # Redirect after login
  #       res.redirect '/'
