module.exports = (app) ->
  
  user: 
    test: ->
      app.mysql.query('SELECT COUNT(1)')

