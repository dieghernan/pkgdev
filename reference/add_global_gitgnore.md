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
#> ✔ Setting active project to "/tmp/RtmpcBf5A7/file1df950f64c42".
#> ✔ Adding ".Rproj.user" to .gitignore.
#> ✔ Adding ".Rhistory" to .gitignore.
#> ✔ Adding ".Rapp.history" to .gitignore.
#> ✔ Adding ".RData" to .gitignore.
#> ✔ Adding ".Rdata" to .gitignore.
#> ✔ Adding ".Ruserdata" to .gitignore.
#> ✔ Adding "*-Ex.R" to .gitignore.
#> ✔ Adding "/*.tar.gz" to .gitignore.
#> ✔ Adding "/*.Rcheck/" to .gitignore.
#> ✔ Adding ".Rproj.user/" to .gitignore.
#> ✔ Adding "vignettes/*.html" to .gitignore.
#> ✔ Adding "vignettes/*.pdf" to .gitignore.
#> ✔ Adding ".httr-oauth" to .gitignore.
#> ✔ Adding "*_cache/" to .gitignore.
#> ✔ Adding "/cache/" to .gitignore.
#> ✔ Adding "*.utf8.md" to .gitignore.
#> ✔ Adding "*.knit.md" to .gitignore.
#> ✔ Adding ".Renviron" to .gitignore.
#> ✔ Configuring core.excludesFile: ~/.gitignore
#> ✔ Creating the global (user-level) gitignore: ~/.gitignore
#> ✔ Adding ".Rproj.user", ".Rhistory", ".RData", ".httr-oauth", ".DS_Store", and
#>   ".quarto" to /home/runner/.gitignore.
#> Warning: cannot open file '.gitignore': No such file or directory
#> Error in file(con, "r"): cannot open the connection
# }
```
