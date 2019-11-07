
#' Committees
#'
#' Lists of Committees
#'
#' @inheritParams ppc_members
#' @examples
#' \dontrun{
#' ppc_votes()
#' }
#' @details To get lists of recent statements published on congressional websites, use the following URI structure. This request returns the 20 most recent results and supports pagination using multiples of 20.
#' @export
ppc_committees <- function(congress = "116", chamber = c("joint", "house", "senate"),
                           api_key = NULL, raw = FALSE) {
  ppc_request(ppc_committees_call(congress, chamber), api_key, raw)
}

## build the call URL
ppc_committees_call <- function(congress = "116", chamber = c("joint", "house", "senate")) {
  stopifnot(
    is_congress_number(congress)
  )
  ppc_base() %P% as_congress_number(congress) %P% "/" %P% match.arg(chamber) %P% "/committees.json"
}

ppc_parse_committees <- function(r) {
  headers <- ppc_headers(r)
  d <- ppc_parse_results(r)[["committees"]][[1]]
  attr(d, "headers") <- headers
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }
  tibble::as_tibble(d)
}
