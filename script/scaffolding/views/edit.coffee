Template = require '../../template'

render = (template)->  
  $ = template.next
  
  $ '<% include ../header %>'
  $ '<form method="<%= method %>" action="<%= action %>">'
  $ '  <input type="text" name="{_}" placeholder="{_}" value="<%= {model}.{_} %>">', 'props'
  $ '  <input type="hidden" name="_csrf" value="<%= token %>">'
  $ '  <input type="submit" value="Submit">'
  $ '</form>'
  $ '<a href="/user/<%= user.id %>">Cancel</a>'
  $ '<% include ../footer %>'

struct=
  values:
    model: if process.argv[2] then process.argv[2] else throw 'Please Specify a Model'
  props:   if process.argv[3] then process.argv[3].split(',') else []

render new Template struct
