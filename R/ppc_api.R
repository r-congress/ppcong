
ppc_request <- function(url, api_key, raw) {
  ## make request
  r <- curl::curl_fetch_memory(url, ppc_handle(api_key))

  ## check status / print warning if status!=200
  ppc_check_status(r)

  ## store url and endpoint info
  attr(r, "url") <- url
  attr(r, "endpoint") <- ppc_endpoint(url)

  ## set class
  class(r) <- c("ppc_" %P% ppc_endpoint(url), "list")

  ## if raw then return response object
  if (raw) {
    return(r)
  }

  ## parse and return
  ppc_parse_data(r)
}


ppc_check_status <- function(r) {
  if ("status_code" %in% names(r)) {
    r <- r$status_code
  }
  if (r == 200) {
    return(invisible(TRUE))
  }
  warning(switch(as.character(r),
    `400` = "400 	Bad Request - Your request is improperly formed",
    `403` = "403 	Forbidden - Your request did not include an authorization header",
    `404` = "404 	Not Found - The specified record(s) could not be found",
    `406` = "406 	Not Acceptable - You requested a format that isn't json or xml",
    `500` = "500 	Internal Server Error - We had a problem with our server. Try again later.",
    `503` = "503 	Service Unavailable - The service is currently not working. Please try again later."
  ), call. = FALSE)
  invisible(FALSE)
}

ppc_handle <- function(api_key = NULL) {
  ## initialize new handle
  h <- curl::new_handle()

  ## set api key header [and return handle]
  curl::handle_setheaders(h, `X-API-Key` = ppc_api_key(api_key))
}

#' Set ProPublica API key
#'
#' Stores ProPublica API key as an environment variable for current and/or
#' future sessions
#'
#' @param api_key The actual API key string provided by ProPublica..
#' @param set_renv Logical indicating whether to append the environment variable
#'   to the home directory's ".Renviron" file. This requires directory
#'   permission, but it will ensure that future sessions automatically find the
#'   token. The default is FALSE (do NOT set in ~/.Renviron).
#' @return the API key string
#' @examples
#'
#' ## this is not a real key
#' ppc_api_key("as9d78f6aayd9fy2fq378a9ds876fsas89d7f")
#'
#' @export
ppc_api_key <- function(api_key = NULL, set_renv = FALSE) {
  ## find environ var if not supplied
  api_key <- api_key %||% ppc_find_api_key()

  ## validate
  if (!(is.character(api_key) &&
    length(api_key) == 1 &&
    api_key != "")) {
    stop("This requires an API key. For more information see: " %P%
        "https://www.propublica.org/datastore/api/propublica-congress-api",
      call. = FALSE)
  }

  ## set if not
  if (Sys.getenv("PROPUBLICA_API_KEY") == "") {
    Sys.setenv(PROPUBLICA_API_KEY = api_key)
  }

  ## save for future sessions
  if (set_renv) {
    tfse::set_renv(PROPUBLICA_API_KEY = api_key)
  }

  ## return
  api_key
}

ppc_find_api_key <- function() {
  if ((key <- Sys.getenv("PROPUBLICA_API_KEY")) != "") {
    return(key)
  }
  key <- c(Sys.getenv(c("PP_API_KEY")),
    system("echo $PROPUBLICA_API_KEY", intern = TRUE),
    system("echo $PP_API_KEY", intern = TRUE))
  if (all(key == "")) {
    key <- ppc_find_config_key()
    return(key)
  }
  key[key != ""][1]
}



## specify/set propublica API version
ppc_set_version <- function(version = "v1") {
  if (!grepl("^v", version)) {
    version <- paste0("v", version)
  }
  options(congress116.ppc_version = version)
}

## this looks for api keys saved in config.yml files (which appears to be how
## ProPublicaR is implemented)
ppc_find_config_key <- function() {
  configs <- unique(c(Sys.getenv("R_CONFIG_FILE", "config.yml"), "config.yml",
    "../config.yml", "../../config.yml"), "../../../config.yml")
  configs <- configs[file.exists(configs)]
  x <- ""
  for (i in seq_along(configs)) {
    con <- file(configs[i], "r")
    x <- readLines(con, warn = FALSE)
    x <- readLines("config.yml")
    if (any(grepl("propublica", x, ignore.case = TRUE))) {
      x <- grep("propublica", x, ignore.case = TRUE, value = TRUE)
      x <- sub(".*propublica\\S{0,}", "", x, ignore.case = TRUE)
      m <- regexpr("[[:alnum:]]{30,50}", x)
      x <- regmatches(x, m)
      close(con)
      break
    }
    close(con)
  }
  if (length(x) == 0) {
    x <- ""
  }
  x
}

## get propublica API version
ppc_get_version <- function() {
  if (!is.null(version <- getOption("congress116.ppc_version"))) {
    if (!grepl("^v", version)) {
      version <- paste0("v", version)
    }
    return(version)
  }
  ppc_set_version("v1")
  "v1"
}

## base URL for propublica API call
ppc_base <- function() {
  version <- ppc_get_version()
  "https://api.propublica.org/congress/" %P% version %P% "/"
}
