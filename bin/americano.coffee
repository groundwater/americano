#!/usr/bin/env coffee

Path = require 'path'
cp   = require 'child_process'

{stdout,stderr} = process

commander = require 'commander'

commander.version '0.0.0'
commander
  .command( 'mixin' )
  .usage( '[model] [prop1,prop2,prop3]' )
  .action (model,properties,command)->
    nargs = arguments.length
    if nargs < 3
      stdout.write arguments[nargs-1].help()
    else
      exec = Path.join __dirname, '../script/generate-scaffolding'
      proc = cp.spawn exec, [model,properties], {stdio:'inherit'}
  
commander
  .command('status')
  .action ->
    cp.exec 'git status', (err,stdout,stderr)->
      console.log stdout
  
commander.parse process.argv