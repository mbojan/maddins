#' Glimpse at Object Selected in the Editor
#'
#' Select an object name in the RStudio code editor. Executing these addins will
#' run \code{dplyr::glimpse} or \code{utils::str} on that object showing its
#' content in a compact way.
#'
#' @name glimpse_selection
NULL

#' @rdname glimpse_selection
#' @export
glimpse_selection <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text
  dplyr::glimpse(get(text))
}


#' @rdname glimpse_selection
#' @export
str_selection <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text
  o <- get_or_not(text)
  cat("Staring at", text, ":\n")
  utils::str(o)
}



get_or_not <- function(objname) {
  # Has white space?
  if( grepl("[[:space:]]", objname) )
    stop("selection contains a white space")
  # Try to get()
  tr <- try( get(objname) )
  if( inherits(tr, "try-error") ) {
    stop("cannot find object with name: ", objname)
  } else {
    return(tr)
  }
}
