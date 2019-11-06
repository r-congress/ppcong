#' Votes
#'
#' Get Recent Votes
#'
#' @inheritParams ppc_members
#' @examples
#' \dontrun{
#' ppc_votes()
#' }
#' @details By tradition, the Speaker of the House votes at his or her
#'   discretion, and typically does not vote. When the Speaker does vote, the
#'   official source data from the Clerk of the House includes that information,
#'   but when the Speaker does not vote, the data provided by the Clerk does not
#'   include that information. In those cases, ProPublica adds a record showing
#'   the Speaker as not voting and increases the total number of lawmakers not
#'   voting by one (both in the Speaker's party and overall). In those cases,
#'   the not voting totals provided by the API for House votes will not match
#'   the Clerk's totals.
#' @export
ppc_votes <- function(chamber = c("both", "house", "senate"), api_key = NULL, raw = FALSE) {
  ppc_make_req(ppc_votes_call(chamber), api_key, raw = raw)
}

ppc_votes_call <- function(chamber = c("both", "house", "senate")) {
  ppc_base() %P% match.arg(chamber) %P% "/votes/recent.json"
}


