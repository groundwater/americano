# Markdown

Americano can render markdown and present them as website pages.

These pages for example are stored in the `docs` directory of the Americano project.

By default, URLs are mapped to paths in the file system.

    /docs       -> /docs/index.md
    /docs/about -> /docs/about.md or /docs/about/index.md

If a markdown document cannot be found,
it the markdown middleware will fall through to the next handler in the
middleware chain.

Express will always handle routes specified by `app.get` before markdown documents.

## Templates

Markdown documents are converted to body HTML and passed into a template.
You specify the markdown template when adding the markdown middleware

    app.use markdown( template: 'index.ejs' )

The template will receive an object with the `body` attribute set to the 
rendered HTML of the markdown document.

    