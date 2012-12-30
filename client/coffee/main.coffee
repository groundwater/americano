# The main project module that initializes 
# all page behaviour
define ['jquery','scripts/config','pjax','scripts/spinner'], ($,config,pjax,spinner)->

  ##################
  # Site Code Here #
  ##################
  
  # PJAX #
  target    = document.getElementById('spin')
  container = '#pjax-container'
  
  $(document).pjax '#pjax-container a', container
  $(document).on 'pjax:start', (event)->
    $(container).addClass 'loading'
    spinner.spin(target)
  $(document).on 'pjax:end', (event)->
    $(container).removeClass 'loading'
    setTimeout ->
      spinner.stop()
    ,300
  
  