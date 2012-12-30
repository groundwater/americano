{connect}  = require 'lib'

module.exports = (app,routes)->
  
  authed   = connect.auth
  redirect = connect.redirect
  
  ## Example Routes ##
  #
  # app.get  '/',                   authed, routes.index
  # app.get  '/login',                      routes.login
  
  app.get '/',                              redirect '/docs'

