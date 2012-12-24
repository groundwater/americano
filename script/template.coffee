class Template
  
  constructor: (@struct)->
    
  write: ->
    console.log.apply this, arguments
  
  join: (del,lines)->
    lines.join del
  
  each: (line,list)->
    out = []
    @struct[list].forEach (item)=>
      line_ = @line line
      token = new RegExp '{_}', 'g'
      line_ = line_.replace token, item
      out.push line_
    out
  
  line: (line)->
    Object.keys(@struct.values).forEach (key)=>
      
      value = @struct.values[key]
      token = new RegExp '{' + key + '}', 'g'
      line  = line.replace token, value
    
    line
  
  next: =>
    len = arguments.length
    
    if len==1
      @write @line.apply @, arguments
    else if len==2
      @write @join '\n', @each.apply @, arguments
    else if len==3
      @write @join arguments[2], @each.apply @, arguments

module.exports = Template
