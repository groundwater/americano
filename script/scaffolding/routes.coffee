Template = require '../template'

render = (template)->  
  $ = template.next
  
  $ "  {model}s: require('./{model}s')(app)"

struct=
  values:
    model: if process.argv[2] then process.argv[2] else throw 'Please Specify a Model'

render new Template struct
