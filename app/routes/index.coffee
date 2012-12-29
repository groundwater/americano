# Routes are analogous to MVC controllers
#
# The main application is injected as part of the
# application boot process.
{connect} = require 'lib'

module.exports = (app)->

  index: connect.TODO
  login: connect.TODO

  pages: require('./pages')(app)
