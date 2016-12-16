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

#' @rdname glimpse_selection
#' @export
any_selection <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text
  o <- get_from_text(text)
  fun <- getOption("straddin.fun", "utils::str")
  cat("Calling", sQuote(fun), "on", sQuote(text), ":\n")
  do.call2(fun, list(o))
}

# do.call handling :: or :::
# http://stackoverflow.com/questions/10022436/do-call-in-combination-with
do.call2 <- function(what, args, ...){
  if(is.function(what)){
    what <- deparse(as.list(match.call())$what);
  }
  myfuncall <- parse(text=what)[[1]];
  mycall <- as.call(c(list(myfuncall), args));
  eval(mycall, ...);
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

