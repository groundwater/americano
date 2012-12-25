auth = (req,res,next)->
  
  if !req.session
    res.redirect '/login'
  else if !req.session.user
    res.redirect '/login'
  else
    next()

redirect = (to)-> 
  (req,res)-> res.redirect to

module.exports= 
  auth: auth
  redirect: redirect
