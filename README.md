# General

The skeleton of this thesis manuscript was greatly inspired by the ones of Tom Cornebize, Clément Mommessin and Millian Poquet, which in turn are inspired by Raphaël Bleuse, David Beniamine and David Glesser.

Links:
- [Template repository](https://github.com/Ezibenroc/thesis-template)
- [Tom Cornebize's thesis repository](https://github.com/Ezibenroc/thesis)
- [Continuous integration plots](https://cornebize.net/thesis/)

The makefile provides convenient recipes to build the whole thesis or unique chapters, to check for missing refs, unreferenced labels or uncited references.
Feel free to hack the template however you like.

To build your own thesis you can use the provided [Dockerfile](Dockerfile), or do it by yourself with:
  - `(GNU)make` (for the Makefile),
  - `texlive` (the full one is provided by Nix, just to be safe).

# Adding your work

This template contains only the introduction and conclusion chapter.
To add a new chapter you'll need to:
- Add a `.tex` file corresponding to your chapter (obviously)
- Add an include line in `thesis.tex` (around lines 290)
- Add a macro definition in `macros.include.default.tex`
- Add a recipe for this chapter in the `Makefile`

A lot of convenient macros are defined in `macros.local.tex`. Feel free to add your own.  It is also possible to add a
watermark by replacing `\watermarkfalse` by `\watermarktrue` in this file (useful if you wish to use continuous
integration and have your manuscript automatically uploaded online).


# Continuous Integration

Using GitHub actions (see the [.github](.github) directory), both the thesis and the slides are compiled automatically
whenever a new commit is pushed. The build is done with a [Docker image](https://hub.docker.com/r/ezibenroc/orgmode_latex)
constructed with the provided [Dockerfile](Dockerfile).

The resulting PDF as well as some plots with basic statistics are deployed on GitHub pages (see the gh-pages branch).
