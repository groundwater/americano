# Routes are analogous to MVC controllers
#
# The main application is injected as part of the
# application boot process.
module.exports = (app)->

  redirect: (to)->
    (req,res)->
      res.redirect to

  users: require('./users')(app)
