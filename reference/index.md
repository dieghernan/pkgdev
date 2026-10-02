# Package index

## Package overview

Learn about **pkgdev** and find related helpers.

- [`pkgdev`](https://dieghernan.github.io/pkgdev/reference/pkgdev-package.md)
  [`pkgdev-package`](https://dieghernan.github.io/pkgdev/reference/pkgdev-package.md)
  : pkgdev: Helpers to Develop Packages with GitHub Actions

## Package maintenance helpers

Run the maintenance workflow with
[`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
and manage ignore files with
[`add_global_gitgnore()`](https://dieghernan.github.io/pkgdev/reference/add_global_gitgnore.md).

- [`add_global_gitgnore()`](https://dieghernan.github.io/pkgdev/reference/add_global_gitgnore.md)
  :

  Add a global `.gitignore` file to a package

- [`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
  : Document your package

## Documentation rendering helpers

Render **Quarto** documents and README files, or precompute **R
Markdown** and **Quarto** vignettes.

- [`build_qmd()`](https://dieghernan.github.io/pkgdev/reference/build_qmd.md)
  [`build_readme_qmd()`](https://dieghernan.github.io/pkgdev/reference/build_qmd.md)
  : Build Quarto files for a package
- [`precompute_vignette()`](https://dieghernan.github.io/pkgdev/reference/precompute.md)
  [`precompute_vignette_all()`](https://dieghernan.github.io/pkgdev/reference/precompute.md)
  : Precompute vignettes

## Documentation checking helpers

Check generated Rd titles for sentence case and trailing periods.

- [`check_rd_titles()`](https://dieghernan.github.io/pkgdev/reference/check_rd_titles.md)
  : Inspect Rd file titles

## GitHub Actions workflow helpers

Create workflows to check packages, update documentation and deploy
**pkgdown** sites.

- [`gha_check_full()`](https://dieghernan.github.io/pkgdev/reference/gha_check_full.md)
  : Create a GitHub Actions workflow that checks your package regularly

- [`gha_pkgdown_branch()`](https://dieghernan.github.io/pkgdev/reference/gha_pkgdown_branch.md)
  :

  Create a GitHub Actions workflow that builds a
  [pkgdown](https://CRAN.R-project.org/package=pkgdown) site

- [`gha_update_docs()`](https://dieghernan.github.io/pkgdev/reference/gha_update_docs.md)
  : Create a GitHub Actions workflow that documents and checks your
  package
