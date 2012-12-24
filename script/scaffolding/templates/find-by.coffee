## Foreign Key Lookups ##
  
  FindBy{{Remote}}: ({{remote}}_id,next)->
    {{model}}s = []
    db.query 'SELECT * FROM {{model}} WHERE {{remote}}=?', [{{remote}}_id], (err,rows)->
      if err then return next err
      rows.forEach (row)->
        {{model}} = new {{Model}} db,models
        {{model}}.make row
        {{model}}s.push {{model}}
      next null, {{model}}s if next
