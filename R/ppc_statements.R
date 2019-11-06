#' Statements
#'
#' Get Recent Congressional Statements
#'
#' @inheritParams ppc_members
#' @examples
#' \dontrun{
#' ppc_votes()
#' }
#' @details To get lists of recent statements published on congressional websites, use the following URI structure. This request returns the 20 most recent results and supports pagination using multiples of 20.
#' @export
ppc_statements <- function(date = NULL, api_key = NULL, raw = FALSE) {
  ppc_statements_all_day(date, api_key, raw)
}

ppc_statements_ <- function(date = NULL, offset = 0, api_key = NULL, raw = FALSE) {
  ppc_make_req(ppc_statements_call(date, offset), api_key, raw)
}

ppc_statements_call <- function(date, offset) {
  if (is.null(date)) {
    date <- Sys.Date()
  }
  if (inherits(date, "POSIXct")) {
    date <- format(date, "%Y-%m-%d")
  }
  date <- as.character(date)
  if (offset == 0) {
    offset <- ""
  } else {
    offset <- paste0("?offset=", offset)
  }
  ppc_base() %P% "statements/date/" %P% date %P% ".json" %P% offset
}


ppc_statements_count <- function(x) {
  if (is.data.frame(x)) {
    return(nrow(x))
  }
  x <- rawToChar(x$content)
  sum(gregexpr("\"member_id\":", x)[[1]] > 0)
}

ppc_statements_all_day <- function(x, api_key, raw) {
  f <- 0
  d <- list()
  while (ppc_statements_count(d[[length(d) + 1L]] <- ppc_statements_(x, f, api_key, raw)) > 19) {
    f <- f + 20
  }
  headers <- lapply(d, attr, "headers")
  d <- do.call("rbind", d)
  attr(d, "headers") <- d
  d
}
