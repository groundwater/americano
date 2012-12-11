controllers = require 'app/controllers'

module.exports = (app)->
  
  $ = controllers(app)
  
  app.get '/',         $.index
  app.get '/login',    $.login
  app.get '/register', $.register
