
#' Parse data
#'
#' Converts ProPublica API response into a tibble (data frame)
#'
#' @param r Reponse from ProPublica API
#' @return A tibble with headers attribute
#' @examples
#' \dontrun{
#' ## get votes data–return the raw response object
#' v <- ppc_votes("senate", raw = TRUE)
#'
#' ## convert response object into data frame
#' ppc_parse_data(v)
#' }
#' @return A data frame of congressional information
#' @export
ppc_parse_data <- function(r) {
  UseMethod("ppc_parse_data")
}

#' @export
ppc_parse_data.ppc_votes <- function(r) {
  ppc_parse_votes(r)
}

#' @export
ppc_parse_data.ppc_members <- function(r) {
  ppc_parse_members(r)
}

#' @export
ppc_parse_data.ppc_statements <- function(r) {
  ppc_parse_statements(r)
}

#' @export
ppc_parse_data.ppc_committees <- function(r) {
  ppc_parse_committees(r)
}

#' @export
ppc_parse_data.ppc_bills <- function(r) {
  ppc_parse_bills(r)
}

#' @export
ppc_parse_data.default <- function(r) {
  ppc_parse_default(r)
}



##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##                                helpers                                     ##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

ppc_endpoint <- function(u) {
  if ("endpoint" %in% names(attributes(u))) {
    return(attr(u, "endpoint"))
  }
  if (is.list(u) && "url" %in% names(u)) {
    u <- u[["url"]]
  }
  tfse::regmatches_first(u,
    "(?<=/)(statements|members|committees|bills|votes|nominations|floor_updates|lobbying)")
}

ppc_parse_results <- function(r) {
  x <- tryCatch(ppc_response_parsed(r)[["results"]],
    error = function(e) tibble::tibble())
  if (is.null(x)) {
    x <- tibble::tibble()
  }
  x
}

ppc_request_timestamp <- function(headers) {
  tryCatch(as.POSIXct(headers$Date,
    format = "%a, %d %b %Y %H:%M:%S",
    tz = tfse::regmatches_first(headers$Date, "[[:alpha:]]+$")),
    error = function(e) as.POSIXct(NA_character_))
}

ppc_headers <- function(r) {
  h <- strsplit(rawToChar(r$headers), "\r\n(?=\\S+:)", perl = TRUE)[[1]]
  status <- grep("HTTP", h, value = TRUE)[1]
  h <- grep("^\\S+: \\S+", h, value = TRUE)
  x <- as.list(sub("^\\S+: ", "", h))
  `names<-`(x, sub(": .*", "", h))
}

ppc_parse_default <- function(r) {
  headers <- ppc_headers(r)
  d <- ppc_parse_results(r)
  attr(d, "headers") <- headers
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }
  tibble::as_tibble(d)
}
