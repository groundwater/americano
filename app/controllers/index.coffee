module.exports.index = (req,res) ->
  res.render 'index.ejs'

module.exports.login = (req,res) ->
  res.render 'login.ejs'

module.exports.register = (req,res) ->
  res.render 'register.ejs'
