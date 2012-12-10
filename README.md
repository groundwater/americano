# Example Coffee Script App

## Goals

- build entire project from `make install`
- app can be deployed with `git push`
    - via `make install && nf export`
- compiles less
- compiles coffee script
- Makefile friendly
    - updating a less file triggers a re-compile of the changed files
- developer friendly
    - can run with a _watch_ command to re-compile on save

## Files

### Layout

    app/                    <- only MVC code
        models/             <- database wiring
        views/              <- logic-less templates
        controllers/        <- request handlers
    config/                 <- all application defaults
        routes.coffee       <- routes configuration
        config.coffee       <- application configuration
    db/                     <- database schemas and migrations
    lib/                    <- shared modules
    public/                 <- directly accessible
    scripts/                <- administrative script
    test/                   <- all tests
    vendor/                 <- third party code
    
    assets.json             <- Rude assets file
    package.json            <- standard Node.js package
    server.coffee           <- imports application environment
    
    [M/C]akefile            <- provides application targets
    
    # Possibly Not Checked Into Git #
    
    Procfile                <- 
    tmp/                    <- temporary files

    # Definitely Not Checked Into Git #
    
    .env                    <- environment configurations

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

