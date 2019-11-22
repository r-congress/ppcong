
#' Bills
#'
#' Search Bills
#'
#' @param query keyword or phrase
#' @inheritParams ppc_members
#' @examples
#' \dontrun{
#' ## get information on legislation about health care
#' hc <- ppc_bills("health care")
#' }
#' @return A data frame of congressional bills information
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
  ppc_base() %P% "bills/search.json?query=" %P% utils::URLencode(query)
}

ppc_parse_bills <- function(r) {
  headers <- ppc_headers(r)
  d <- ppc_parse_results(r)[["bills"]][[1]]
  if (is.null(d)) {
    d <- tibble::tibble()
  }
  attr(d, "headers") <- headers
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }
  tibble::as_tibble(d)
}
