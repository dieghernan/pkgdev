# build_qmd() errors when a file does not exist

    Code
      build_qmd("missing.qmd", path = pkg)
    Condition
      Error in `build_qmd()`:
      ! Can't find input file.
      x Missing: 'missing.qmd'

# build_readme_qmd() errors when README.qmd is missing

    Code
      build_readme_qmd(path = pkg)
    Condition
      Error in `build_readme_qmd()`:
      ! Can't find a Quarto README source file.
      i Expected 'README.qmd' or 'inst/README.qmd'.

# build_readme_qmd() errors when root and inst README.qmd exist

    Code
      build_readme_qmd(path = pkg)
    Condition
      Error in `build_readme_qmd()`:
      ! Found multiple Quarto README source files.
      x Keep only one of 'README.qmd' or 'inst/README.qmd'.

