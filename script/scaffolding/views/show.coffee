Template = require '../../template'

render = (template)->  
  $ = template.next
  
  $ '<% include ../header %>'
  $ '<ul>'
  $ '    <li><%= {model}.{_} %></li>', 'props'
  $ '</ul>'
  $ '<a href="/{model}/<%= {model}.id %>/edit">Edit</a>'
  $ '<a href="/{model}s">List</a>'
  $ '<% include ../footer %>'

struct=
  values:
    model: if process.argv[2] then process.argv[2] else throw 'Please Specify a Model'
  props:   if process.argv[3] then process.argv[3].split(',') else []

render new Template struct
