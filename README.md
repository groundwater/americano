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

- `server.coffee` is the main entry point of the application.
    The server file is the main dependency injector,
    and initializes modules from environment variables.

- `app/` directory contains the bulk of the application.
    No components in the `app` directory will be statically accessible.

    - `app.coffee` configures the application.
        This file accepts its configuration,
        and makes no attempt to read any configurations from the environment.

    - `routes.coffee` is the main router.
        Its only job is to link HTTP routes to controllers.
        There is no business logic.

    - `controllers` directory contains HTTP request controllers.
        Each controllers exists as a top-level name exposed by the `controllers` module.

    - `views` contains templates for the controllers, in any template language.

    - `lib` contains re-usable application components.

    - `styles` contains compilable stylesheets, such as `LESS`.
        Files here are compiled to `build/public/css`, 
        and accessible from `/assets/css`

    - `scripts` contains compilable browser scripts, such as coffee scripts.
        Files here are compiled to `build/public/js`,
        and accessible from `/assets/js`

    - `vendor` contains 3rd party libraries that _must_ be stored in the project.
        Each vendor app can be linked in a unique way.
        The linkage should be added to the appropriate `Makefile`.

- `public` contains raw assets to be statically served at runtime.
    This directory is merged with statically compiled assets,
    so care must be taken to avoid namespace collisions.
    
    - it is _very_ likely this directory is just a symlink to `build/public`
    - this directory _may_ be directly read from nginx, or another static web-server
    - _all_ assets in this directory are assumed publicly cacheable

- `Procfile` must contain all necessary information to start the application.

- `Makefile` must contain at minimum the `install` command,
    which when invoked readies the application for start.

- `build` is the output of the build process.
    This directory is _optional_ however,
    as a means of conveniently organizing all the compiled components together.

## Deployment

The application can and _should_ be deployed directly from the Git repository.

### Deployment Procedure

Upon triggering a deployment,
the target branch will be unpacked to a directory and built with:

- `make install`
- `sudo nf export -o /etc/init -e ${ENV_FILE} -u ${USER}`


