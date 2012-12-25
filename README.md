# Americano

> Americano is coffee-script on rails.

Americano is _not_ a framework.
There is no Americano module to include in your project,
you are free to write your app however you like.
What Americano does do however is generate a lot of code you can further customize.

Americano is about sensible defaults.

## Goals

### Code Generation

- Generate basic MVC scaffolding from a model description

### Development Mode

A development mode should exist that aids rapid development.
Changes in code should be reflected immediately in the application.

- re-compile and reload code on changes
- use un-combined stylus in debug mode
- use un-combined require.js scripts

### Release Mode

Release mode is all about efficiency.
Resources should be combined when possible.
Static assets are pre-compiled to Javascript, CSS and HTML.

- combine and compact require.js code
- compile and compact stylus code into a single `.css` file

### Database

Databases need to be upgraded,
so migrations should be generated that can be tested and then applied in production.

- generate database migrations

### Vendor Code

It shouldn't be a nightmare to include Twitter Bootstrap,
and other 3rd party projects that require small tweaks or customizations.

- allow compilation of vendor code

## Overview

### Layout

    app/                    <- only MVC code
        models/             <- database wiring
        views/              <- logic-less templates
        routes/             <- request handlers
    
    client/                 <- compiled client resources
        less/               <- LESS stylesheets
        coffee/             <- coffee scripts for browser
    
    config/                 <- all application defaults
        router.coffee       <- routes configuration
        config.coffee       <- application configuration
    
    db/                     <- database schemas and migrations
    lib/                    <- shared modules
    script/                 <- scripts and tools
    test/                   <- all tests
    vendor/                 <- third party code
    
    assets.json             <- Rude assets file
    package.json            <- standard Node.js package
    server.coffee           <- imports application environment
    
    [M/C]akefile            <- provides application targets
    
    # Possibly Not Checked Into Git #
    
    Procfile                <- define runnable processes
    public/                 <- symlink to assets directory
    tmp/                    <- temporary files
    
    # Definitely Not Checked Into Git #
    
    .env                    <- environment configurations

### Rails

Americano gets you going quickly by generating boiler plate.

    $ script/generate-scaffolding $MODEL $PROP1,$PROP2

For example, generate `user` scaffolding with:
    
    $ script/generate-scaffolding user fname,lname,email
    [INFO] Wrote app/views/users
    [INFO] Wrote app/models/users.coffee
    [INFO] Wrote db/migrations/20121224100855-user.js
    [INFO] Wrote app/routes/users.coffee
    [INFO] Appended user to config/router.coffee
    [INFO] Appended user to app/routes/index.coffee
    [INFO] Appended user to app/models/index.coffee
    

### Imports

The `lib` module is symbolically linked into
`node_modules` and directly accessible via

    require('lib/SUB_MODULE_NAME')

The `lib` module should include all your application-independent code.
The `lib` module itself should export _no_ content, only submodules.
Submodules should be independent of each other.

### Makeable Targets

Makeable targets should ready the application for running,
but never actually run the application.
It is encouraged to create more targets as necessary,
but the following targets are _always_ expected.

    clean              <- delete all generated files
    develop            <- ready app for development
    release            <- ready app for production

Each target should work with the given Procfile.
If necessary, the Procfile can be auto-generated.

The `release` target should combine and compact public scripts,
style sheets, and perform other necessary optimizations.

The `develop` target should auto-restart on changes to source code,
and be debugger friendly.
There should be no code compaction, and no optimizations.

## Deployment

The application can and _should_ be deployed directly from the Git repository.
Environment variables are expected to be provided for attached resources,
and other deployment-dependent settings.

