util = require 'util'

str  = require 'string'
mu   = require 'mu2'

mu.root = __dirname + '/templates'

props = process.argv[3].split(',')
name  = process.argv[2]

fmt   = (m) -> (props.map (_)-> util.format m, _).join ', '

temp=
  Card: str(name).capitalize()
  card: name
  make: fmt '@%s'
  save:
    sql : fmt '%s=?'
    vars: fmt '@%s'
    rows: fmt 'rows.%s'

m = ''
t = mu.compileAndRender 'model.coffee', temp
t.on 'data', (data)->
  process.stdout.write data
t.on 'end', -> console.log m

sql=
  model: name
  rows: fmt '\n  `%s` varchar(255) DEFAULT NULL'

o = ''
s = mu.compileAndRender 'model.sql', sql
s.on 'data', (data)->
  o += data

s.on 'end', -> console.log o
