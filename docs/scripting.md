# Scripting

Client side scripting is important to the user experience.
It can also be a pain to develop, test, debug, and maintain.

Americano uses [bower][1] and [require.js][2] to help ease the headache of client side scripting.

By wrapping everything in _require_, we modularize our client code;
when it comes time for a production deployment,
we use [r.js][3] to compile our project to a single optimized file.

## Client Scripts

    client/
        coffee/
            config.coffee   <- config variables
            init.coffee     <- bootstrap script called by require
            log.coffee      <- logging utilities
            main.coffee     <- user code starts here

Vendor dependencies from _bower_ or other sources are linked in via a cake task,
typically a build task such as `build:develop` or `build:release`.

### Goodies

The markdown module supports [pjax][4], 
and we have configured the `client/coffee/main` script to boot the pjax code.


[1]: https://github.com/twitter/bower
[2]: http://requirejs.org/
[3]: https://github.com/jrburke/r.js
[4]: https://github.com/defunkt/jquery-pjax
