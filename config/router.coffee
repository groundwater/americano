{connect}  = require 'lib'

module.exports = (app,routes)->
  
  authed   = connect.auth
  redirect = connect.redirect
  
  ## Example Routes ##
  #
  # app.get  '/',                   authed, routes.index
  # app.get  '/login',                      routes.login
  
  app.get '/',                              redirect '/docs'

  # page CRUD
  app.get  '/pages',                      routes.pages.list
  app.get  '/page/make',                  routes.pages.make
  app.post '/page/make',                  routes.pages.make_post
  app.get  '/page/:id',                   routes.pages.show
  app.get  '/page/:id/edit',              routes.pages.edit
  app.post '/page/:id',                   routes.pages.edit_post
  app.get  '/page',                       redirect '/pages'

