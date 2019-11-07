
#' Bills
#'
#' Search Bills
#'
#' @param query keyword or phrase
#' @inheritParams ppc_members
#' @examples
#' \dontrun{
#' ppc_votes()
#' }
#' @details To get lists of recent statements published on congressional websites, use the following URI structure. This request returns the 20 most recent results and supports pagination using multiples of 20.
#' @export
ppc_bills <- function(query = "", api_key = NULL, raw = FALSE) {
  ppc_request(ppc_bills_call(query), api_key, raw)
}

## build the call URL
ppc_bills_call <- function(query) {
  stopifnot(
    is.character(query),
    length(query) == 1L
  )
  ppc_base() %P% "bills/search.json?query=" %P% URLdecode(query)
}

ppc_parse_bills <- function(r) {
  headers <- ppc_headers(r)
  d <- ppc_parse_results(r)[["bills"]][[1]]
  attr(d, "headers") <- headers
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }
  tibble::as_tibble(d)
}
