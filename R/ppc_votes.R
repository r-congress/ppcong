#' Votes
#'
#' Get Recent Votes
#'
#' @inheritParams ppc_members
#' @examples
#' \dontrun{
#' ## get votes from only the house
#' hv <- ppc_votes("house")
#'
#' ## get votes from the house and the senate
#' hsv <- ppc_votes("both")
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
#' @return A data frame of congressional votes information
#' @export
ppc_votes <- function(chamber = c("both", "house", "senate"), api_key = NULL, raw = FALSE) {
  ppc_request(ppc_votes_call(chamber), api_key, raw = raw)
}

ppc_votes_call <- function(chamber = c("both", "house", "senate")) {
  ppc_base() %P% match.arg(chamber) %P% "/votes/recent.json"
}

ppc_parse_votes <- function(r) {
  ppc_parse_votes_ <- function(x) {
    if (length(x[["votes"]]) == 0) return(tibble::tibble())
    tibble::as_tibble(cbind(cbind(
      cbind(x$votes[sapply(x$votes, is.atomic)],
        `names<-`(x$votes$democratic, "d_" %P% names(x$votes$democratic))),
      `names<-`(x$votes$republican, "r_" %P% names(x$votes$republican))),
      `names<-`(x$votes$independent, "i_" %P% names(x$votes$independent))))
  }
  headers <- ppc_headers(r)
  d <- ppc_parse_votes_(ppc_parse_results(r))
  attr(d, "headers") <- headers
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }
  d
}
