Template = require '../template'

render = (template)->  
  $ = template.next
  
  $ ""
  $ "  # {model} CRUD"
  $ "  app.get  '/{model}s',                      routes.{model}s.list"
  $ "  app.get  '/{model}/make',                  routes.{model}s.make"
  $ "  app.post '/{model}/make',                  routes.{model}s.make_post"
  $ "  app.get  '/{model}/:id',                   routes.{model}s.show"
  $ "  app.get  '/{model}/:id/edit',              routes.{model}s.edit"
  $ "  app.post '/{model}/:id',                   routes.{model}s.edit_post"
  $ "  app.get  '/{model}',                       routes.redirect '/{model}s'"

struct=
  values:
    model: if process.argv[2] then process.argv[2] else throw 'Please Specify a Model'

render new Template struct
