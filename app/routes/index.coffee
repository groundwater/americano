module.exports = (app)->

  index: (req,res) ->
    render = 
      users: [
        app.models.users.New()
        app.models.users.Load(0)
      ]
    
    res.render 'index.ejs', render

