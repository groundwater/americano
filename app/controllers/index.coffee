opts = 
  title: 'MyApp'

module.exports.index = (req,res) ->
  res.render 'index.ejs', opts

module.exports.login = (req,res) ->
  res.render 'login.ejs', opts

module.exports.register = (req,res) ->
  res.render 'register.ejs', opts
