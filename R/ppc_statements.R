#' Statements
#'
#' Get Recent Congressional Statements
#'
#' @param date Day from which statements should be collected; should follow the
#'   format of YYYY-MM-DD.
#' @inheritParams ppc_members
#' @examples
#' \dontrun{
#' ## get all statements from may 7th, 2018
#' may72018 <- ppc_statements("2018-05-07")
#' }
#' @return A data frame of congressional statements information
#' @export
ppc_statements <- function(date = NULL, api_key = NULL, raw = FALSE) {
  ppc_statements_all_day(date, api_key, raw)
}

ppc_statements_ <- function(date = NULL, offset = 0, api_key = NULL, raw = FALSE) {
  ppc_request(ppc_statements_call(date, offset), api_key, raw)
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


ppc_parse_statements <- function(r) {
  headers <- ppc_headers(r)
  d <- ppc_parse_results(r)
  attr(d, "headers") <- headers
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }
  tibble::as_tibble(d)
}
