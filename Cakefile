execSync = (require 'execSync').stdout
{format} = require 'util'

info = -> console.log '[INFO]', format.apply null, arguments
fail = -> console.log '[FAIL]', format.apply null, arguments
warn = -> console.log '[WARN]', format.apply null, arguments
done = -> console.log '[DONE]', format.apply null, arguments

cp = (from,to)-> execSync format 'cp -r %s %s', from, to
rm = (node)   -> execSync format 'rm -r %s', node
ln = (from,to)-> execSync format 'ln -sfn `pwd`/%s %s', from, to
lk = (from,to)-> execSync format 'ln -sfn %s %s', from, to
mkdir = (dir) -> execSync format 'mkdir -p %s', dir

pub = (path)-> 'tmp/public/' + path

components = ->
  ln 'components/requirejs/require.js',         pub 'require.js'
  ln 'components/jquery/jquery.js',             pub 'jquery.js'
  ln 'components/jquery-pjax/jquery.pjax.js',   pub 'pjax.js'
  ln 'components/spin.js/spin.js',              pub 'spin.js'
  ln 'components/requirejs-text/text.js',       pub 'scripts/text.js'
  ln 'vendor/bootstrap',                        pub 'bootstrap'

task 'build:develop', 'Build project for development', (options)->
  info 'Building Development Bundle'
  
  ln 'Procfile.develop', 'Procfile'
  ln 'lib',              'node_modules/lib'
  
  mkdir 'tmp/public'
  mkdir 'tmp/public/styles'
  mkdir 'tmp/public/scripts'
  
  ln 'client/templates',                      'tmp/public/templates'
  ln 'tmp/public',                            'public'
  
  components()

task 'build:release', 'Build project for release', (options)->
  info 'Building Release Bundle'
  
  cp 'Procfile.release', 'Procfile'
  
  mkdir 'tmp/public/scripts'
  mkdir 'build/public/scripts'
  
  lk 'build/public', 'public'
  
  components()
  
  execSync 'node_modules/.bin/coffee -c -o tmp/public/scripts client/coffee'
  execSync 'node_modules/.bin/r.js -o script/app.build.js >> cake.log 2>&1'
  
  mkdir 'build/app'
  mkdir 'build/public/styles'
  
  cp    'app/views',             'build/app/views'
  cp    'vendor/bootstrap',      'build/public'
  cp    'tmp/public/require.js', 'build/public'
  
  execSync 'node_modules/.bin/coffee -c -o build/app app'
  execSync 'node_modules/.bin/coffee -c -o build/config config'
  execSync 'node_modules/.bin/coffee -c -o node_modules/lib lib'
  execSync 'node_modules/.bin/coffee -c -o build server'
  execSync 'node_modules/.bin/stylus --compress --out build/public/styles client/stylus >> cake.log 2>&1'

task 'clean', 'Clean all temporary data', (options)->
  rm 'tmp'
  rm 'Procfile'
  rm 'build'
  rm 'public'
