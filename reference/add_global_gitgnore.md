# Add `.gitignore` to package

Adds a global `.gitgnore` file to the package. File based on default
`.gitignore` provided by GitHub.

## Usage

``` r
add_global_gitgnore(pkg = ".")
```

## Arguments

- pkg:

  Path to a (subdirectory of an) R package.

## Value

Invisible, and writes a global `.gitignore` file

## See also

[`usethis::use_git_ignore()`](https://usethis.r-lib.org/reference/use_git_ignore.html),
[`usethis::git_vaccinate()`](https://usethis.r-lib.org/reference/git_vaccinate.html)

## Examples

``` r
# \dontrun{
add_global_gitgnore()
#> ✔ Setting active project to "/tmp/RtmpE0IqQP/file1b24250f5ac2".
#> ✔ Configuring core.excludesFile: ~/.gitignore
#> ✔ Creating the global (user-level) gitignore: ~/.gitignore
#> ✔ Adding ".Rproj.user", ".Rhistory", ".RData", ".httr-oauth", ".DS_Store", and
#>   ".quarto" to /home/runner/.gitignore.
#> Warning: cannot open file '.gitignore': No such file or directory
#> Error in file(con, "r"): cannot open the connection
# }
```
