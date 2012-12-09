_rude    = require 'rude'
{format} = require 'util'

rude = _rude.config()

module.exports = 
  a : (href,text)->
    format '<a href="%s">%s</a>', rude(href), text||href
  img: (src,alt)->
    format '<img src="%s" alt="%s"/>', rude(src), alt||src

