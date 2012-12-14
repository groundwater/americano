# Example Coffee Script App

## Goals

- build entire project from a `make` target
- app can be deployed with `git push`
    - via `make release`
- release bundles resources
    - css and js combined to a single compact file
    - require.js compacted to a single file
- compiles stylus
- compiles coffee script
- Makefile friendly
    - updating a less file triggers a re-compile of the changed files
- developer friendly
    - can run with a _watch_ command to re-compile on save
- forward and reverse database migrations
    - auto migrations for development
    - controlled migrations for production
    - read database parameters from environment
- test-driven-development friendly

## Files

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
    script/                 <- administrative script
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

