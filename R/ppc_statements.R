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
ppc_statements <- function(offset = 0, api_key = NULL, raw = FALSE) {
  ppc_make_req(ppc_statements_call(offset), api_key, raw = raw)
}

ppc_statements_call <- function(offset = 0) {
  if (offset == 0) {
    offset <- ""
  } else {
    offset <- paste0("?offset=", offset)
  }
  ppc_base() %P% "statements/latest.json" %P% offset
}
