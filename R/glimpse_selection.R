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


# Get or evaluate selected expression
get_from_text <- function(txt) {
  e <- parent.frame()
  # Trim and remove leading/trailing spaces and newlines
  txt <- trimws(txt, which = "both")
  # Try to get()
  if( exists(txt, envir = e) ) {
    return( get(txt, envir = e) )
  } else {
    errmsg <- paste("cannot find object ", dQuote(txt))
    # Try to parse
    r1 <- try(parse(text=txt), silent = TRUE)
    if(inherits(r1, "try-error")) {
      err <- append(errmsg, paste("cannot parse text", dQuote(txt), ":", r1))
      stop("\n", paste(paste("-", err), collapse="\n"))
    }
    # Try to evaluate
    r2 <- try(eval(r1), silent = TRUE)
    if(inherits(r2, "try-error")) {
      err <- append(errmsg, paste("cannot evaluate expresssion", sQuote(r1), ":", r2))
      stop("\n", paste(paste("-", err), collapse="\n"))
    }
    return(r2)
  }
}

