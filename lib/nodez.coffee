## Either ##

class Either
  
class Left extends Either
  constructor: (@message)->
  map:     -> @
  flatMap: -> @

class Right extends Either
  constructor: (@value)->
  map:     (f)-> Right @value
  flatMap: (f)-> f @value

## Options ##

class Option

class Some extends Option
  constructor: (@value)->
  map:     (f)-> Some f @value
  flatMap: (f)-> f @value

class None extends Option
  map:     -> None
  flatMap: -> None

## Future ##

class Failure

class Future
  
  map: (@atob)->
    new Future (@callback)=>
  
  flatMap: (@atofb)->
    new Future (@callback)=>

  constructor: (fb)->
    fb (@result)=>
      if @atob 
        @callback @atob result
      else if @atofb
        (@atofb result).map @callback

