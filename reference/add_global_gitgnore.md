# Add `.gitignore` to package

Adds a global `.gitignore` file to the package. The file is based on the
default `.gitignore` provided by GitHub.

## Usage

``` r
add_global_gitgnore(pkg = ".")
```

## Arguments

- pkg:

  Path to a (subdirectory of an) R package.

## Value

Invisibly returns `NULL` after writing a global `.gitignore` file.

## See also

- [`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)
  runs package maintenance tasks that call `add_global_gitgnore()`.

- [`usethis::use_git_ignore()`](https://usethis.r-lib.org/reference/use_git_ignore.html)
  adds entries to `.gitignore`.

- [`usethis::git_vaccinate()`](https://usethis.r-lib.org/reference/git_vaccinate.html)
  adds global Git ignore rules.

Package maintenance helpers:
[`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)

## Examples

``` r
# \dontrun{
add_global_gitgnore()
#> ✔ Setting active project to "/tmp/Rtmp0ckHnX/file1ad145fba36d".
#> ✔ Configuring core.excludesFile: ~/.gitignore
#> ✔ Creating the global (user-level) gitignore: ~/.gitignore
#> ✔ Adding ".Rproj.user", ".Rhistory", ".RData", ".httr-oauth", ".DS_Store", and
#>   ".quarto" to /home/runner/.gitignore.
#> Warning: cannot open file '.gitignore': No such file or directory
#> Error in file(con, "r"): cannot open the connection
# }
```
