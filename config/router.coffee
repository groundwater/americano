module.exports = (app,routes)->
  
  # RAILS: Routes
  app.get '/',                  routes.index
