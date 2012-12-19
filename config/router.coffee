module.exports = (app,routes)->
  
  # RAILS: Routes
  app.get '/',                  routes.index
  app.get '/mysql',             routes.mysql
  app.get '/node',              routes.node
  app.get '/redis',             routes.redis
  app.get '/mongo',             routes.mongo
  app.get '/all',               routes.all
  app.get '/block',             routes.block
  app.get '/multisql',          routes.multisql
