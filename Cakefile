execSync = (require 'execSync').stdout
{format} = require 'util'

info = -> console.log '[INFO]', format.apply null, arguments
fail = -> console.log '[FAIL]', format.apply null, arguments
warn = -> console.log '[WARN]', format.apply null, arguments
done = -> console.log '[DONE]', format.apply null, arguments

rm = (node)   -> execSync format 'rm -r %s', node
ln = (from,to)-> execSync format 'ln -sfn `pwd`/%s %s', from, to
mk = (dir)    -> execSync format 'mkdir -p %s', dir

task 'build:develop', 'Build project for development', (options)->
  info 'Building Development Bundle'
  
  ln 'Procfile.develop', 'Procfile'
  
  mk 'tmp/public'
  mk 'tmp/public/styles'
  mk 'tmp/public/scripts'
  
  ln 'client/templates',                      'tmp/public/templates'
  
  ln 'vendor/requirejs/require.js',           'tmp/public/require.js'
  ln 'vendor/bootstrap',                      'tmp/public/bootstrap'
  ln 'vendor/jquery/jquery-1.8.2.min.js',     'tmp/public/scripts/jquery.js'
  ln 'vendor/text/text.js',                   'tmp/public/scripts/text.js'
  
  ln 'tmp/public',                            'public'

task 'build:release', 'Build project for release', (options)->
  info 'Building Release Bundle'

task 'clean', 'Clean all temporary data', (options)->
  rm 'tmp'
  rm 'Procfile'
  rm 'build'
  rm 'public'
