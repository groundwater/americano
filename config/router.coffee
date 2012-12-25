{connect}  = require 'lib'

module.exports = (app,routes)->
  
  authed   = connect.auth
  redirect = connect.redirect
  
  # RAILS: Routes
  app.get  '/',                   authed, routes.index
  app.get  '/login',                      routes.login

