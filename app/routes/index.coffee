util  = require 'util'

async = require 'async'

module.exports = (app)->

  index: (req,res) ->
    
    app.models.users.New (err,user)->
      throw err if err
        
      app.models.cards.New (err,card)->
        throw err if err
          
        user.email = 'test'
        user.save (err)->
          console.log err if err
     
        card.name  = 'BOB'
        card._user = user.id
        card.save (err)->
          console.log err if err
    
        render = 
          user: user
    
        user.cards (err,cards)->
          render.cards = util.inspect cards
          
          res.render 'index.ejs', render

