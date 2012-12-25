module.exports = (app,routes)->
  
  connect  = app.lib.connect
  
  authed   = connect.auth
  redirect = connect.redirect
  
  # RAILS: Routes
  app.get  '/',                   authed, routes.index
  app.get  '/login',                      routes.login

