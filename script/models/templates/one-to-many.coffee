## Foreign Key References ##

  # Pluralize One-to-Many Relationships
  get_{{model}}s: (next)->
    @models.{{model}}s.FindBy{{Remote}} @id, next
  
  new_{{model}}: (next)->
    @models.{{model}}s.New (err,{{model}})->
      {{model}}.{{remote}}_id = @id
      next err, {{model}}
