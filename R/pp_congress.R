
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
#' h116 <- pp_congress(congress = "116", chamber = "house")
#' }
#' @seealso \url{https://projects.propublica.org/api-docs/congress-api/}
#' @export
pp_congress <- function(congress = "116",
                        chamber = "senate",
                        api_key = NULL,
                        raw = FALSE) {

  ## make request
  r <- curl::curl_fetch_memory(
    pp_congress_call(congress, chamber),
    pp_congress_handle(api_key)
  )

  ## check status / print warning if status!=200
  pp_check_status(r)

  ## if raw then return response object
  if (raw) {
    return(r)
  }

  ## parsing: get response headers
  headers <- pp_headers(r)

  ## parsing: convert returned JSON data into tibble
  d <- pp_parse_data(r)

  ## parsing: store headers as attribute
  attr(d, "headers") <- headers

  ## parsing: add request timestamp variable
  if (nrow(d) > 0) {
    d$pp_request_timestamp <- pp_request_timestamp(headers)
  }

  ## return data
  d
}
