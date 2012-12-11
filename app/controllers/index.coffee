module.exports = (app)->

  index: (req,res) ->
    app.models.user.test()
    res.render 'index.ejs'

  login: (req,res) ->
    res.render 'login.ejs'

  register: (req,res) ->
    res.render 'register.ejs'

