execSync = (require 'execSync').stdout
{format} = require 'util'

info = -> console.log '[INFO]', format.apply null, arguments
fail = -> console.log '[FAIL]', format.apply null, arguments
warn = -> console.log '[WARN]', format.apply null, arguments
done = -> console.log '[DONE]', format.apply null, arguments

rm = (node)   -> execSync format 'rm -r %s', node
ln = (from,to)-> execSync format 'ln -sfn `pwd`/%s %s', from, to
mkdir = (dir)    -> execSync format 'mkdir -p %s', dir

pub = (path)->
  'tmp/public/' + path

task 'build:develop', 'Build project for development', (options)->
  info 'Building Development Bundle'
  
  ln 'Procfile.develop', 'Procfile'
  
  mkdir 'tmp/public'
  mkdir 'tmp/public/styles'
  mkdir 'tmp/public/scripts'
  
  ln 'client/templates',                      'tmp/public/templates'
  
  ln 'components/requirejs/require.js',         pub 'require.js'
  ln 'components/jquery/jquery.js',             pub 'jquery.js'
  ln 'components/jquery-pjax/jquery.pjax.js',   pub 'pjax.js'
  ln 'components/spin.js/spin.js',              pub 'spin.js'
  ln 'components/requirejs-text/text.js',       pub 'scripts/text.js'
  
  ln 'vendor/bootstrap',                        pub 'bootstrap'
  
  ln 'tmp/public',                            'public'

task 'build:release', 'Build project for release', (options)->
  info 'Building Release Bundle'

task 'clean', 'Clean all temporary data', (options)->
  rm 'tmp'
  rm 'Procfile'
  rm 'build'
  rm 'public'
