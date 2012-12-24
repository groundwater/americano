Template = require '../../template'

render = (template)->  
  $ = template.next
  
  $ '<% include ../header %>'
  $ '<table>'
  $ '<% {model}s.forEach(function({model}){ %>'
  $ '    <tr>'
  $ '        <td><a href="/{model}/<%= {model}.id %>"><%= {model}.id %></a></td>'
  $ '        <td><%= {model}.{_} %></td>', 'props'
  $ '    </tr>'
  $ '<% }) %>'
  $ '</table>'
  $ '<a href="/{model}/make">New</a>'
  $ '<% include ../footer %>'

struct=
  values:
    model: if process.argv[2] then process.argv[2] else throw 'Please Specify a Model'
  props:   if process.argv[3] then process.argv[3].split(',') else []

render new Template struct
