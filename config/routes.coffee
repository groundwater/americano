controllers = require '../app/controllers'

module.exports = (app)->
  app.get '/',         controllers.index
  app.get '/login',    controllers.login
  app.get '/register', controllers.register
