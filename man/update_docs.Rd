% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update_docs.R
\name{update_docs}
\alias{update_docs}
\title{Document your package}
\usage{
update_docs(
  pkg = ".",
  url_update = TRUE,
  create_codemeta = TRUE,
  create_cff = TRUE,
  build_readme = TRUE,
  verbose = TRUE,
  precompute = TRUE,
  opt_imgs = TRUE,
  opt_dir = c("pkgdown/favicon", "man/figures", "vignettes"),
  opt_ext = "png$|jpg$",
  opt_overwrite = TRUE,
  add_contributors = TRUE,
  ...
)
}
\arguments{
\item{pkg}{Path to a (subdirectory of an) R package.}

\item{url_update}{Logical, do you want to update urls with
\code{\link[urlchecker:url_update]{urlchecker::url_update()}}?}

\item{create_codemeta}{Logical, do you want to create
a codemeta file with \code{\link[codemetar:write_codemeta]{codemetar::write_codemeta()}}?}

\item{create_cff}{Logical, do you want to create
a CITATION.cff file with \code{\link[cffr:cff_write]{cffr::cff_write()}}?}

\item{build_readme}{Logical, build \code{README.Rmd} with
\code{\link[devtools:build_rmd]{devtools::build_readme()}}}

\item{verbose}{Display informative messages on the console}

\item{precompute}{Logical, detect and precompute vignettes? See also
\code{\link[=precompute_vignette]{precompute_vignette()}}.}

\item{opt_imgs}{Logical. Optimize images with \code{\link[resmush:resmush_dir]{resmush::resmush_dir()}}?}

\item{opt_dir, opt_ext, opt_overwrite}{See \code{dir}, \code{ext} and \code{overwrite} in \code{\link[resmush:resmush_dir]{resmush::resmush_dir()}}.}

\item{add_contributors}{Logical. Would add contributors using
\code{\link[allcontributors:add_contributors]{allcontributors::add_contributors()}}.}

\item{...}{Additional arguments to functions}
}
\value{
invisible, or some messages on \code{verbose = TRUE}.
}
\description{
Run routine checks on the package:
\itemize{
\item Clean DESCRIPTION with \code{\link[usethis:tidyverse]{usethis::use_tidy_description()}}
\item Compress the data of the paths \code{"./data"} and \code{"./R"} using
\code{\link[tools:checkRdaFiles]{tools::resaveRdaFiles()}}.
\item Style code with \code{\link[styler:style_pkg]{styler::style_pkg()}}
\item Check urls with \code{\link[urlchecker:url_check]{urlchecker::url_check()}}
\item Roxygenise with \code{\link[roxygen2:roxygenize]{roxygen2::roxygenise()}}
\item Precompute vignettes if present
(see \url{https://ropensci.org/blog/2019/12/08/precompute-vignettes/})
\item Rebuild \code{README.Rmd} (if present) with \code{\link[devtools:build_rmd]{devtools::build_readme()}}
\item Optimize images with \code{\link[resmush:resmush_dir]{resmush::resmush_dir()}}
\item Write codemeta.json with \code{\link[codemetar:write_codemeta]{codemetar::write_codemeta()}}
\item Write CITATION.cff with \code{\link[cffr:cff_write]{cffr::cff_write()}}
}
}
\details{
This function tries to update and clean the package following a mix of
best practices (e.g. checking the urls, roxygenise and rebuilding the
\code{README}) and some other discretionary practices I like to have in a package,
as the \code{tidyverse} approach for the \code{DESCRIPTION} file and overall code
and the use of \code{codemeta.json}.
}
\examples{
\dontrun{

update_docs()
}

}
\seealso{
\code{\link[usethis:tidyverse]{usethis::use_tidy_description()}}, \code{\link[styler:style_pkg]{styler::style_pkg()}},
\code{\link[urlchecker:url_check]{urlchecker::url_check()}}, \code{\link[roxygen2:roxygenize]{roxygen2::roxygenise()}},
\code{\link[devtools:build_rmd]{devtools::build_readme()}}, \code{\link[codemetar:write_codemeta]{codemetar::write_codemeta()}},
\code{\link[tools:checkRdaFiles]{tools::resaveRdaFiles()}}
}
