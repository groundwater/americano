module.exports = (app)->
  
  # Create local references to guides
  db = app.guides.sql.main
  
  edit: (req,res)->
    app.models.pages.Load req.params.id, (err,page)->
      return res.send 500 if err
      
      render =
        method: 'POST'
        action: '/page/' + page.id
        page: page
        token: req.session._csrf
        cancel: '/page/' + page.id
        
      res.render 'pages/edit.ejs', render
  
  edit_post: (req,res)->
    app.models.pages.Load req.params.id, (err,page)->
      return res.send 500, err if err
      
      page.make req.body
      page.save (err)->
        return res.send 500, err if err
        
        res.redirect '/page/' + req.params.id
    
  list: (req,res)->
    app.models.pages.Range 0, -1, (err,pages)->
      return res.send 500 if err
      
      render=
        pages:pages
      
      res.render 'pages/list.ejs', render
  
  show: (req,res)->
    app.models.pages.Load req.params.id, (err,page)->
      return res.send 500, err if err
      render=
        page: page
      res.render 'pages/show.ejs', render

  make: (req,res)->
    render = 
      method: 'POST'
      action: '/page/make'
      page: app.models.pages.Struct()
      token: req.session._csrf
      cancel: '/pages'
    res.render 'pages/edit.ejs', render

  make_post: (req,res)->
    app.models.pages.New (err,page)->
      return res.send 500, err if err
      
      page.make req.body
      page.save (err)->
        return res.send 500, err if err
        
        res.redirect '/page/' + page.id

