# Configure non-requireJS modules such as
# twitter bootstrap, and jquery
requirejs.config
  paths:
    'jquery'    : '/assets/jquery'
    'bootstrap' : '/assets/bootstrap/js/bootstrap'
    'pjax'      : '/assets/pjax'
    'spin'      : '/assets/spin'
  shim:
    'bootstrap' : ['jquery']
    'pjax'      : ['jquery']
    'spin'      : ['jquery']

# Initialize the main module, along with twitter bootstrap
require [ 
  'jquery'
  'bootstrap'
  'main'
  'log'
], ($,bootstrap,main,log) ->
  log.info 'RequireJS Initialized'
  
  # This loads the main module, 
  # so you should not have to edit this file
