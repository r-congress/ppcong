
#' Get Congress data from ProPublica's API
#'
#' Retrieves congress data from api.propublica.org
#'
#' @param chamber Specify the chamber of Congress typically "house" or "senate";
#'   sometimes "both" or "joint"
#' @param congress The number of Congress of interest
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
#' @return A data frame of congressional members information
#' @export
ppc_members <- function(chamber = c("both", "house", "senate"),
                        congress = "116",
                        api_key = NULL,
                        raw = FALSE) {
  UseMethod("ppc_members")
}


#' @export
ppc_members.numeric <- function(chamber = c("both", "house", "senate"),
                                congress = "116",
                                api_key = NULL,
                                raw = FALSE) {
  cong <- as.character(chamber)
  if (is_chamber(congress)) {
    chamber <- congress
  } else {
    chamber <- "both"
  }
  congress <- cong
  ppc_members(chamber, congress, api_key, raw)
}

#' @export
ppc_members.default <- function(chamber = c("both", "house", "senate"),
                                congress = "116",
                                api_key = NULL,
                                raw = FALSE) {
  ## if congress number is provided first
  if (length(chamber) == 1 &&
      is_congress_number(chamber) &&
      tolower(congress) %in% c("house", "senate", "h", "s", "sen", "rep")) {
    cham <- congress
    congress <- chamber
    chamber <- cham
  } else if (length(chamber) == 1 && is_congress_number(chamber)) {
    congress <- chamber
    chamber <- "both"
  }
  stopifnot(
    is_chamber(chamber),
    is_congress_number(congress)
  )
  chamber <- switch(tolower(chamber[1]),
    b = 'both',
    both = 'both',
    h = 'house',
    rep = 'house',
    house = 'house',
    s = 'senate',
    sen = 'senate',
    senate = 'senate')
  if (chamber == "both") {
    h <- ppc_request(ppc_members_call("house", congress), api_key, raw)
    s <- ppc_request(ppc_members_call("senate", congress), api_key, raw)
    if (!raw) {
      hvars <- names(h)
      svars <- names(s)
      hv <- hvars[!hvars %in% svars]
      for (i in seq_along(hv)) {
        s[[hv[i]]] <- NA
      }
      sv <- svars[!svars %in% hvars]
      for (i in seq_along(sv)) {
        h[[sv[i]]] <- NA
      }
      return(rbind(h, s))
    }
    return(list(house = h, senate = s))
  }
  ppc_request(ppc_members_call(chamber, congress), api_key, raw)
}

## build the call URL
ppc_members_call <- function(chamber = c("house", "senate"), congress = "116") {
  ppc_base() %P% as_congress_number(congress) %P% "/" %P% match.arg(chamber) %P% "/members.json"
}

ppc_parse_members <- function(r) {
  headers <- ppc_headers(r)
  d <- ppc_parse_results(r)
  if (nrow(d) == 0 ||
      !all(c("members", "congress", "chamber") %in% names(d))) {
    attr(d, "headers") <- headers
    return(d)
  }
  m <- d[["members"]][[1]]
  if (is.null(m)) {
    m <- tibble::tibble()
  }
  attr(m, "headers") <- headers
  if (NROW(m) > 0) {
    m$congress <- d$congress
    m$chamber <- d$chamber
    m$date_of_birth <- as.Date(m$date_of_birth)
    m$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }
  tibble::as_tibble(m)
}
