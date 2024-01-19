#' Optimize images with reSmush.it API
#'
#' @rdname optimize_imgs
#'
#' @description
#'
#' Optimize images using the reSmush.it API <https://resmush.it/>.
#' reSmush.it is a FREE API that provides image optimization. reSmush.it limits
#' its use to PNG, JPG, GIF, BMP and TIF pictures up to 5MB.
#'
#' @source
#'
#' <https://resmush.it/features>
#'
#' @param path Path to the files to optimize.
#' @param outfile Output file. By default is `path`, i.e. overwrites the file
#'   provided.
#' @param qlty Integer between 0 and 100. Optimization level (JPG compression
#'   only).
#' @param dir Directory or list of directories to optimize.
#' @param ext Regex indicating the extension of the image files to be optimized.
#'
#' @return Writes optimized image files on disk.
#' @examples
#' \donttest{
#'
#' # A jpg file
#' myjpg <- system.file("img/example.jpg", package = "pkgdev")
#' destjpg <- tempfile(fileext = ".jpg")
#'
#' # Regular use
#' optimize_imgs(myjpg, destjpg)
#'
#' # Use qlty
#' optimize_imgs(myjpg, destjpg, qlty = 20)
#'
#' # With png
#' mypng <- system.file("img/example.png", package = "pkgdev")
#' destpng <- tempfile(fileext = ".png")
#' optimize_imgs(mypng, destpng)
#' }
#'
#' @export
#'
#'
optimize_imgs <- function(path, outfile = path, qlty = 92) {
  if (!file.exists(path)) {
    cli::cli_alert_info("{.file {path}} not found.")
    return(invisible())
  }

  # Send to reSmusht
  file <- httr::upload_file(path)
  file$name <- basename(path)

  resmushit <- httr::POST(paste0("http://api.resmush.it/?qlty=", qlty),
    body = list(files = file)
  )


  api_answer <- httr::content(resmushit)

  if ("error" %in% names(api_answer)) {
    cli::cli_alert_danger(
      "{.file {path}} couldn't be optimized by {.href https://resmush.it/}:",
    )

    cli::cli_bullets(c(
      "!" = "Error Code :{api_answer$error} {api_answer$error_long}",
      "i" = "{api_answer$generator}"
    ))

    return(invisible())
  }

  if (!"dest" %in% names(api_answer)) {
    cli::cli_alert_danger(
      paste(
        "Something went wrong with the API response.",
        "Check {.href https://resmush.it/status}"
      )
    )
    return(invisible())
  }

  # New and old sizes
  olds <- api_answer$src_size
  class(olds) <- "object_size"
  oldc <- format(olds, units = "auto")

  news <- api_answer$dest_size
  class(news) <- "object_size"
  newsc <- format(news, units = "auto")


  cli::cli_alert_success(
    paste(
      "Optimizing {.file {path}} with ratio {api_answer$percent}%",
      "(size {newsc}, was {oldc}). Output: {.file {outfile}}"
    )
  )

  ov <- httr::GET(api_answer$dest, httr::write_disk(outfile, overwrite = TRUE))


  return(invisible())
}

#' @rdname optimize_imgs
#' @export
#'
optimize_imgs_all <- function(dir = c("man/figures", "vignettes"),
                              ext = "png$|jpg$", qlty = 92) {
  # Get images
  find_imgs <- list.files(dir, pattern = ext, full.names = TRUE)

  if (length(find_imgs) == 0) {
    cli::cli_alert_info(
      paste(
        "No images for precomputing found in",
        "{.path {file.path(dir)}} with extension {.code {ext}}"
      )
    )
  } else {
    for (i in seq_len(length(find_imgs))) {
      optimize_imgs(path = find_imgs[i], qlty = qlty)
    }
  }
}
