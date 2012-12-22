#!/usr/bin/env coffee

util = require 'util'
fs   = require 'fs'

str  = require 'string'
mu   = require 'mu2'

mu.root = __dirname + '/templates'

props = process.argv[3].split(',')
name  = process.argv[2]

fmt   = (m) -> (props.map (_)-> util.format m, _).join ', '
set   = (m) -> (props.map (_)-> util.format m, _, _).join '\n'

temp=
  Card: str(name).capitalize()
  card: name
  make: set '    @%s = row.%s'
  save:
    sql : fmt '%s=?'
    vars: fmt '@%s'
    rows: fmt 'rows.%s'

model_out = ''
model_template = mu.compileAndRender 'model.coffee', temp
model_template.on 'data', (data)->
  model_out += data
model_template.on 'end', -> 
  file = 'app/models/' + name + '.coffee'
  fs.writeFileSync file, model_out
  console.log '[INFO] Wrote', file

sql=
  model: name
  rows: fmt "\n    %s: { type: 'string' }"

lpad = (str, padChar, totalLength)->
  str = str.toString()
  neededPadding = totalLength - str.length;
  if neededPadding < 0 then neededPadding = 1
  for i in [0...neededPadding]
    str = padChar + str
  str

formatDate = (date)->
  [
    date.getUTCFullYear(),
    lpad(date.getUTCMonth() + 1, '0', 2),
    lpad(date.getUTCDate(),      '0', 2),
    lpad(date.getUTCHours(),     '0', 2),
    lpad(date.getUTCMinutes(),   '0', 2),
    lpad(date.getUTCSeconds(),   '0', 2)
  ].join('')

sql_out = ''
sql_template = mu.compileAndRender 'migration.js', sql
sql_template.on 'data', (data)->
  sql_out += data
sql_template.on 'end', -> 
  d = new Date()
  time = formatDate(d)
  file = 'db/migrations/' + time + '-' + name + '.js'
  fs.writeFileSync file, sql_out
  console.log '[INFO] Wrote', file
