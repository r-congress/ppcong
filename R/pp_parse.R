

ppc_endpoint <- function(u) {
  if (is.list(u)) {
    u <- u[["url"]]
  }
  ep <- tfse::regmatches_first(u, "(?<=congress/v\\d{1}/).*(?=\\.json$)")
  gsub("^(both|house|senate)/|/(recent|latest|search)$", "", sub("^\\d+/", "", ep))
}


ppc_parse_default <- function(r) {
  ## parsing: get response headers
  headers <- ppc_headers(r)

  ## parsing: convert returned JSON data into tibble
  d <- ppc_parse_results(r)

  ## parsing: store headers as attribute
  attr(d, "headers") <- headers

  ## parsing: add request timestamp variable
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }

  ## return parsed data
  tibble::as_tibble(d)
}



ppc_parse_statements <- function(r) {
  ## parsing: get response headers
  headers <- ppc_headers(r)

  ## parsing: convert returned JSON data into tibble
  d <- ppc_parse_results(r)

  ## parsing: store headers as attribute
  attr(d, "headers") <- headers

  ## parsing: add request timestamp variable
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }

  ## return parsed data
  tibble::as_tibble(d)
}

ppc_parse_votes_ <- function(x) {
  if (length(x[["votes"]]) == 0) return(tibble::tibble())
  tibble::as_tibble(cbind(cbind(
    cbind(x$votes[sapply(x$votes, is.atomic)],
      `names<-`(x$votes$democratic, "d_" %P% names(x$votes$democratic))),
    `names<-`(x$votes$republican, "r_" %P% names(x$votes$republican))),
    `names<-`(x$votes$independent, "i_" %P% names(x$votes$independent))))
}

ppc_parse_votes <- function(r) {
  ## parsing: get response headers
  headers <- ppc_headers(r)

  ## parsing: convert returned JSON data into tibble
  d <- ppc_parse_votes_(ppc_parse_results(r))

  ## parsing: store headers as attribute
  attr(d, "headers") <- headers

  ## parsing: add request timestamp variable
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }

  ## return parsed data
  d
}

ppc_parse_committees <- function(r) {
  ## parsing: get response headers
  headers <- ppc_headers(r)

  ## parsing: convert returned JSON data into tibble
  d <- ppc_parse_results(r)

  ## parsing: store headers as attribute
  attr(d, "headers") <- headers

  ## parsing: add request timestamp variable
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }

  ## return parsed data
  d
}

ppc_parse_bills <- function(r) {
  ## parsing: get response headers
  headers <- ppc_headers(r)

  ## parsing: convert returned JSON data into tibble
  d <- ppc_parse_results(r)

  ## parsing: store headers as attribute
  attr(d, "headers") <- headers

  ## parsing: add request timestamp variable
  if (nrow(d) > 0) {
    d$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }

  ## return parsed data
  d
}


ppc_parse_members <- function(r) {
  ## parsing: get response headers
  headers <- ppc_headers(r)

  ## parsing: convert returned JSON data into tibble
  d <- ppc_parse_results(r)

  if (nrow(d) == 0 ||
      !all(c("members", "congress", "chamber") %in% names(d))) {
    attr(d, "headers") <- headers
    return(d)
  }

  ## get members data and add results meta data
  m <- d$members[[1]]
  m$congress <- d$congress
  m$chamber <- d$chamber

  ## convert DOB to date class
  m$date_of_birth <- as.Date(m$date_of_birth)

  ## parsing: store headers as attribute
  attr(m, "headers") <- headers

  ## parsing: add request timestamp variable
  if (nrow(m) > 0) {
    m$ppc_request_timestamp <- ppc_request_timestamp(headers)
  }

  ## return as tibble
  tibble::as_tibble(m)
}


ppc_parse_results <- function(x) {
  tryCatch(jsonlite::fromJSON(rawToChar(r[["content"]]))[["results"]],
    error = function(e) tibble::tibble())
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


#' Parse data
#'
#' Converts ProPublica API response into a tibble (data frame)
#'
#' @param r Reponse from ProPublica API
#' @return A tibble with headers attribute
#' @export
ppc_parse_data <- function(r) {
  UseMethod("ppc_parse_data")
}

#' @export
ppc_parse_data.default <- function(r) {
  if (!"url" %in% names(r)) {
    return(r)
  }
  ep <- ppc_endpoint(r)
  ppc_parser <- switch(ep,
    `members` = ppc_parse_members,
    `votes` = ppc_parse_votes,
    `statements` = ppc_parse_statements,
    `committees` = ppc_parse_committees,
    `bills` = ppc_parse_bills,
    ppc_parse_default
  )
  ppc_parser(r)
}
