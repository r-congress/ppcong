pp_parse_votes <- function(x) {
  if (length(x$results$votes) == 0) return(tibble::tibble())
  tibble::as_tibble(cbind(cbind(
    cbind(x$results$votes[dapr::vap_lgl(x$results$votes, is.atomic)],
      `names<-`(x$results$votes$democratic, "d_" %P% names(x$results$votes$democratic))),
    `names<-`(x$results$votes$republican, "r_" %P% names(x$results$votes$republican))),
    `names<-`(x$results$votes$independent, "i_" %P% names(x$results$votes$independent))))
}


pp_make_req <- function(url, api_key = NULL, raw = FALSE) {
  r <- curl::curl_fetch_memory(
    url,
    pp_congress_handle(pp_find_api_key())
  )
  if (raw) {
    return(r)
  }
  jsonlite::fromJSON(rawToChar(r$content))
}


pp_statements <- function(id, congress, raw = FALSE, api_key = NULL) {

  ## make request
  r <- curl::curl_fetch_memory(
    pp_statements_call(id, congress),
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

is_congress_id <- function(x) length(x) == 1 && is.character(x) && grepl("^[A-Z]\\d+$", x)

pp_statements_call <- function(id, congress) {
  stopifnot(
    is_congress_id(id),
    is_congress_number(congress)
  )
  pp_base() %P% "members/" %P% id %P% "/statements/" %P% as_congress_number(congress) %P% ".json"
}
