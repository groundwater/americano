Template = require '../../template'

render = (template)->  
  $ = template.next
  
  $ '<% include ../header %>'
  $ '<form method="<%= method %>" action="<%= action %>" class="form-horizontal">'
  $ '  <div class="control-group">'\
  + '    <label class="control-label" for="input{_}">{_}</label>'\
  + '    <div class="controls">'\
  + '      <input type="text" name="{_}" placeholder="{_}" value="<%= {model}.{_} %>">'\
  + '    </div>'\
  + '  </div>', 'props'
  $ '  <input type="hidden" name="_csrf" value="<%= token %>">'
  $ '  <div class="control-group">'
  $ '    <div class="controls">'
  $ '      <button type="submit" class="btn-primary">Submit</button>'
  $ '      <a class="btn"href="<%= cancel %>">Cancel</a>'
  $ '    </div>'
  $ '  </div>'
  $ '</form>'
  $ '<% include ../footer %>'

struct=
  values:
    model: if process.argv[2] then process.argv[2] else throw 'Please Specify a Model'
  props:   if process.argv[3] then process.argv[3].split(',') else []

render new Template struct
