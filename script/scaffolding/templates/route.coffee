module.exports = (app)->
  
  # Create local references to guides
  db = app.guides.sql.main
  
  edit: (req,res)->
    app.models.{{model}}s.Load req.params.id, (err,{{model}})->
      return res.send 500 if err
      
      render =
        method: 'POST'
        action: '/{{model}}/' + {{model}}.id
        {{model}}: {{model}}
        token: req.session._csrf
        cancel: '/{{model}}/' + {{model}}.id
        
      res.render '{{model}}s/edit.ejs', render
  
  edit_post: (req,res)->
    app.models.{{model}}s.Load req.params.id, (err,{{model}})->
      return res.send 500, err if err
      
      {{model}}.make req.body
      {{model}}.save (err)->
        return res.send 500, err if err
        
        res.redirect '/{{model}}/' + req.params.id
    
  list: (req,res)->
    app.models.{{model}}s.Range 0, -1, (err,{{model}}s)->
      return res.send 500 if err
      
      render=
        {{model}}s:{{model}}s
      
      res.render '{{model}}s/list.ejs', render
  
  show: (req,res)->
    app.models.{{model}}s.Load req.params.id, (err,{{model}})->
      return res.send 500, err if err
      render=
        {{model}}: {{model}}
      res.render '{{model}}s/show.ejs', render

  make: (req,res)->
    render = 
      method: 'POST'
      action: '/{{model}}/make'
      {{model}}: app.models.{{model}}s.Struct()
      token: req.session._csrf
      cancel: '/{{model}}s'
    res.render '{{model}}s/edit.ejs', render

  make_post: (req,res)->
    app.models.{{model}}s.New (err,{{model}})->
      return res.send 500, err if err
      
      {{model}}.make req.body
      {{model}}.save (err)->
        return res.send 500, err if err
        
        res.redirect '/{{model}}/' + {{model}}.id

