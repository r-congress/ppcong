pp_parse_data <- function(r) {
  ## parse json data
  results <- tryCatch(jsonlite::fromJSON(rawToChar(r$content))$results,
    error = function(e) NULL)
  if (length(results) == 0 ||
      !all(c("members", "congress", "chamber") %in% names(results))) {
    return(tibble::tibble())
  }
  ## get members data and add results meta data
  members <- results$members[[1]]
  members$congress <- results$congress
  members$chamber <- results$chamber

  ## convert DOB to date class
  members$date_of_birth <- as.Date(members$date_of_birth)

  ## return as tibble
  tibble::as_tibble(members)
}

pp_request_timestamp <- function(headers) {
  tryCatch(as.POSIXct(headers$Date,
    format = "%a, %d %b %Y %H:%M:%S",
    tz = tfse::regmatches_first(headers$Date, "[[:alpha:]]+$")),
    error = function(e) as.POSIXct(NA_character_))
}

pp_headers <- function(r) {
  h <- strsplit(rawToChar(r$headers), "\r\n(?=\\S+:)", perl = TRUE)[[1]]
  status <- grep("HTTP", h, value = TRUE)[1]
  h <- grep("^\\S+: \\S+", h, value = TRUE)
  x <- as.list(sub("^\\S+: ", "", h))
  `names<-`(x, sub(": .*", "", h))
}

