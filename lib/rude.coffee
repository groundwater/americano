rude = (require 'rude').config()

module.exports = (options={})->
  
  regex = options.regex || /!\[(.*?)\]/gi
  
  prepare: (data)->
    data.replace regex, (match,$1,offset)->
      rude $1.trim()
    
