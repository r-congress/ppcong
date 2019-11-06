
#' Get Congress data from ProPublica's API
#'
#' Retrieves congress data from api.propublica.org
#'
#' @param congress The number of Congress of interest
#' @param chamber Either "house" or "senate"
#' @param api_key The actual API key string provided by ProPublica.
#' @param raw Logical indicating whether to return the raw response object. The
#'   default (FALSE) parses the content and returns a tibble data frame.
#' @return Depending on the raw parameter, this function returns a tibble data
#'   frame with member information or the response object returned by curl
#'
#' @details
#'
#' To apply for a ProPublica API use the following link:
#' \url{https://www.propublica.org/datastore/api/propublica-congress-api}.
#' Complete and submit the provided form to receive your API key.
#'
#' @examples
#' \dontrun{
#' ## get data on house for 116th congress (requires API key)
#' h116 <- ppc_congress(congress = "116", chamber = "house")
#' }
#' @seealso \url{https://projects.propublica.org/api-docs/congress-api/}
#' @export
ppc_members <- function(congress = "116",
                        chamber = c("house", "senate"),
                        api_key = NULL,
                        raw = FALSE) {
  ## process API request
  ppc_make_req(ppc_members_call(congress, chamber), api_key, raw)
}


## build the call URL
ppc_members_call <- function(congress = "116", chamber = c("house", "senate")) {
  stopifnot(
    is_congress_number(congress)
  )
  ppc_base() %P% as_congress_number(congress) %P% "/" %P% match.arg(chamber) %P% "/members.json"
}
