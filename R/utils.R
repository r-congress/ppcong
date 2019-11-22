#' Paste operator
#'
#' See \code{tfse::\link[tfse]{\%P\%}} for details.
#'
#' @name %P%
#' @rdname P
#' @keywords internal
#' @export
#' @importFrom tfse %P%
#' @usage lhs \%P\% rhs
NULL


`%||%` <- function (a, b) if (is.null(a)) b else a

is_congress_id <- function(x) length(x) == 1 && is.character(x) && grepl("^[A-Z]\\d+$", x)

## validation function for congress number
is_congress_number <- function(x) {
  is.atomic(x) && length(x) == 1 && grepl("^1\\d{2}(th|st|rd|nd)?$", x)
}

as_congress_number <- function(x) {
  sub("(?<=\\d)[[:alpha:]]+$", "", x, perl = TRUE)
}

ppc_response_text <- function(x) {
  if ("content" %in% names(x)) {
    x <- x[["content"]]
  }
  paste(rawToChar(x, multiple = TRUE), collapse = "")
}

ppc_response_parsed <- function(x) {
  jsonlite::fromJSON(ppc_response_text(x))
}
