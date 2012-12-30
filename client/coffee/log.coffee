# A logger class that can switch in and out of debugging mode
define ->
  
  logLevel  = 0
  logLevels = 
    'debug' : 0
    'info'  : 5
    'warn'  : 10
    'error' : 50
    'fatal' : 100
  
  ## Loggers ##
  
  debug: (string)->
    if logLevel <= 0
      console.log string
  
  info: (string)->
    if logLevel <= 5
      console.log string

  warn: (string)->
    if logLevel <= 10
      console.log string

  error: (string)->
    if logLevel <= 50
      console.log string

  fatal: (string)->
    if logLevel <= 100
      console.log string
  
  # Dynamically Set the Log Level
  setLevel: (level)->
    if logLevels[level]
      logLevel = logLevels[level]
    else
      warn 'Unknown Log Level ' + level
