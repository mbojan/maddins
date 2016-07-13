#' Glimpse at Object Selected in the Editor
#'
#' Select an object name in the RStudio code editor. Executing these addins will
#' run \code{dplyr::glimpse} or \code{utils::str} on that object showing its
#' content in a compact way in the Console.
#'
#' @name glimpse_selection
NULL

#' @rdname glimpse_selection
#' @export
glimpse_selection <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text
  o <- get_from_text(text)
  cat("Glimpse of", sQuote(text), ":\n")
  dplyr::glimpse(o)
}


#' @rdname glimpse_selection
#' @export
str_selection <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text
  o <- get_from_text(text)
  cat("Structure of", sQuote(text), ":\n")
  utils::str(o)
}


get_from_text <- function(objname) {
  # Has a white space?
  if( grepl("[[:space:]]", objname) )
    stop("selection contains a white space")
  # Try to get()
  if( exists(objname) ) {
    return( get(objname) )
  } else {
    stop("cannot find object with name: ", objname)
  }
}

