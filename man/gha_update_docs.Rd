% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gha_update_docs.R
\name{gha_update_docs}
\alias{gha_update_docs}
\title{Create a GitHub action that documents and checks your package}
\source{
\href{https://github.com/r-lib/actions/tree/master/examples}{r-lib/actions}
}
\usage{
gha_update_docs(
  pkg = ".",
  overwrite = TRUE,
  platform = "macOS",
  version = "latest"
)
}
\arguments{
\item{pkg}{Path to a (subdirectory of an) R package.}

\item{overwrite}{Overwrite the action if it was already present.}

\item{platform}{Platform to use for deploying the package. See \strong{Details}}

\item{version}{Version of the platform. See \strong{Details}.}
}
\value{
A GitHub Action on \code{.github/workflows}.
}
\description{
The GitHub action created would document your package (see \code{\link[=update_docs]{update_docs()}}),
would check it and would deploy the package on a gh-pages branch.
}
\details{
Check \url{https://github.com/actions/runner-images} to see the available
options.
}
\examples{
\dontrun{
# With Ubuntu 20.04
gha_update_docs(platform = "ubuntu", version = "20.04")
}

}
\seealso{
\code{\link[=update_docs]{update_docs()}}, \code{\link[=gha_pkgdown_branch]{gha_pkgdown_branch()}}
}
