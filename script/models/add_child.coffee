#!/usr/bin/env coffee

util = require 'util'
fs   = require 'fs'

str  = require 'string'
mu   = require 'mu2'

mu.root = __dirname + '/templates'

parent = process.argv[2]
child  = process.argv[3]

fmt   = (m) -> (props.map (_)-> util.format m, _).join ', '
set   = (m) -> (props.map (_)-> util.format m, _, _).join '\n'

temp =
  remote: parent
  Remote: str(parent).capitalize()
  model:  child
  Model:  str(child).capitalize()

a = (temp,next)->
  model_out = ''
  model_template = mu.compileAndRender 'find-by.coffee', temp
  model_template.on 'data', (data)->
    model_out += data
  model_template.on 'end', -> 
    next model_out

b = (temp,next)->
  model_out = ''
  model_template = mu.compileAndRender 'many-to-one.coffee', temp
  model_template.on 'data', (data)->
    model_out += data
  model_template.on 'end', -> 
    next model_out

c = (temp,next)->
  model_out = ''
  model_template = mu.compileAndRender 'one-to-many.coffee', temp
  model_template.on 'data', (data)->
    model_out += data
  model_template.on 'end', -> 
    next model_out

a temp, (one)->
  b temp, (two)->
    file = 'app/models/' + child + '.coffee'
    m = fs.readFileSync file, 'utf8'
    x = m.replace '## Foreign Key Lookups ##', one
    y = x.replace '## Foreign Key References ##', two
    fs.writeFileSync file, y

c temp, (one)->
  file = 'app/models/' + parent + '.coffee'
  m = fs.readFileSync file, 'utf8'
  x = m.replace '## Foreign Key References ##', one
  fs.writeFileSync file, x

