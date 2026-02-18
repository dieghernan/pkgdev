# Create a GitHub action that documents and checks your package

The GitHub action created would document your package (see
[`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md)),
would check it and would deploy the package on a gh-pages branch.

## Usage

``` r
gha_update_docs(
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

A GitHub Action on `.github/workflows`.

## Details

Check <https://github.com/actions/runner-images> to see the available
options.

## See also

[`update_docs()`](https://dieghernan.github.io/pkgdev/reference/update_docs.md),
[`gha_pkgdown_branch()`](https://dieghernan.github.io/pkgdev/reference/gha_pkgdown_branch.md)

## Examples

``` r
# \dontrun{
# With Ubuntu 20.04
gha_update_docs(platform = "ubuntu", version = "20.04")
#> ✔ Adding "R-version" to .github/.gitignore.
#> Warning: cannot open file '/tmp/RtmpDbrkNX/file1ad534b1912b/.github/.gitignore': No such file or directory
#> Error in file(path, open = file_mode, encoding = "utf-8"): cannot open the connection
# }
```
