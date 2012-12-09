{spawn, exec} = require 'child_process'
path          = require 'path'
colors        = require 'colors'

colors.setTheme({
  info: 'green',
  data: 'grey'
});

PATH = process.env.PATH
PATH = __dirname + '/node_modules/.bin:' + PATH

run = (command,cwd)->
  console.log '[Exec]'.info, command.data
  
  body = command.split(' ')
  head = body.shift()
  opts = 
    'stdio':'inherit'
    env:{PATH:PATH}
    cwd:cwd || process.cwd()
  
  spawn head, body, opts

lessc = ()->
  run 'mkdir -p build/app/public'
  run 'lessc app/styles/main.less build/app/public/main.css'
  run 'make bootstrap', 'app/vendor/bootstrap'
  run 'cp -r app/vendor/bootstrap/bootstrap build/public/'

## Tasks ##

task 'bake', 'Build project', ->
  run 'coffee -c -l -b -o build/app app'
  run 'coffee -c -l -b -o build server.coffee'
  lessc()

task 'clean', 'Clean build directory', ->
  run 'rm -r build'

task 'taste', 'Run test suite', ->
  invoke 'bake'
  run 'mocha test --compilers coffee:coffee-script'

task 'mix', 'Continuous build mode for development', ->
  run 'echo Mixing Cake'
