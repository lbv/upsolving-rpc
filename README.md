# Upsolving - RPC

A website (in Spanish) about algorithmic programming.

Some of the tools that I use to generate all of this:

* [node.js][node] and [npm][npm], to keep track of useful utilities.
* [Bower][bower] to maintain web dependencies (like `jquery` and so on).
* [Pandoc][pandoc] to generate the webpages from Markdown files. This with
  node's [pandoc filter][node-pandoc] is pretty much my ideal toolbox for
  generating documents.
* [Bootstrap][bootstrap] to provide a consistent look-and-feel without too
  much headaches.
* [Font Awesome][font-awesome] for good-looking iconography.
* [Less][less] for managing CSS styles.
* [CoffeeScript][coffee] for coding client-side scripts, as well as custom
  tools for my working environment.
* [Graphviz][graphviz] to generate graphs.
* [ditaa][ditaa] to generate more graphs.
* [tup][tup] to drive the generation of files. I *could* try other tools (like
  `make`, for example), but I don't know of any tool that works as good as
  `tup` for the task it was created for (generating stuff from other stuff).

Some instructions follow, mostly to help me remember, but also in case someone
gets curious or has some suggestions to improve my workflow.

## Setting up the environment

1. Clone the repository.
2. `npm install` (inside the project's root).
3. `bower install` (inside the project's root).
4. `tup init` (inside `website/`).

## Generating the website

Run `tup` from `website/`.

This generates two versions of the website: `website/_build_dev` and
`website/_build_prod`. The *dev* environment is the one I check locally and it
includes copies of all the dependencies I need (like *MathJax*, *jQuery*,
*Bootstrap*, etc), while the *prod* environment is the one I deploy into
GitHub pages and it makes use of CDNs and generates slightly optimized
versions of things like CSS files and JS files.

To start the webserver and check the website locally: `npm start`.

## Deploying to GitHub pages.

`make sync` from the project's root directory. Then `cd gh-pages` and do the
usual `git status; git add .; git push origin gh-pages`.

*Explanation:* In my local working directory I have a copy of my repo's
`gh-pages` branch under a directory called `gh-pages` (it's `.gitignore`d in
the project's root). Whenever I update my website with `tup`, the whole thing
I want to publish is under `website/_build_prod/htdocs`. The `Makefile`
contains a `sync` target that uses `rsync` to update `gh-pages/`. Then I go
into that directory and deploy.

[bootstrap]: http://getbootstrap.com/
[bower]: http://bower.io/
[coffee]: http://coffeescript.org/
[ditaa]: http://ditaa.sourceforge.net/
[font-awesome]: http://fontawesome.io/
[graphviz]: http://www.graphviz.org/
[less]: http://lesscss.org/
[node]: http://nodejs.org/
[node-pandoc]: https://github.com/mvhenderson/pandoc-filter-node
[npm]: https://npmjs.org/
[pandoc]: http://johnmacfarlane.net/pandoc/
[tup]: http://gittup.org/tup/
