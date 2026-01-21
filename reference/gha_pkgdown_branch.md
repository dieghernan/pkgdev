# Create a GitHub action that builds a pkgdown site

The GitHub action created would deploy a pkgdown site of your package on
the gh-pages branch.

## Usage

``` r
gha_pkgdown_branch(
  pkg = ".",
  overwrite = TRUE,
  platform = "macOS",
  version = "latest"
)
```

## Source

[r-lib/actions](https://github.com/r-lib/actions/tree/master/examples)

## Arguments

- pkg:

  Path to a (subdirectory of an) R package.

- overwrite:

  Overwrite the action if it was already present.

- platform:

  Platform to use for deploying the package. See **Details**

- version:

  Version of the platform. See **Details**.

## Value

A GitHub Action on `<pkg>/.github/workflows`.

## Details

Check <https://github.com/actions/runner-images> to see the available
options.

## See also

[`gha_check_full()`](https://dieghernan.github.io/pkgdev/reference/gha_check_full.md)

## Examples

``` r
# \dontrun{
# With Ubuntu 20.04
gha_pkgdown_branch(platform = "ubuntu", version = "20.04")
#> ✔ Adding "R-version" to .github/.gitignore.
#> Warning: cannot open file '/tmp/RtmpQTPVsC/file1df831006708/.github/.gitignore': No such file or directory
#> Error in file(path, open = file_mode, encoding = "utf-8"): cannot open the connection
# }
```
