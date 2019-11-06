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
