## Foreign Key References ##
  
  get_{{remote}}: (cb)->
    @remotes.{{remote}}.Load @{{remote}}_id, cb
  
  set_{{remote}}: ({{remote}})->
    @{{remote}}_id = {{model}}.id
