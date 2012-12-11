module.exports = (app)->

  index: (req,res) ->
    res.render 'index.ejs'
  
  login: (req,res) ->
    
    render =
      name: app.models.user.name()
      
    res.render 'login.ejs', render

  register: (req,res) ->
    res.render 'register.ejs'

