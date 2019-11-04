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


stop_if_not <- function(..., exprs, local = TRUE, msg_append = "") {
  if (nchar(msg_append) > 0) {
    msg_append <- paste0("\n", msg_append)
  }
  n <- ...length()
  if (!missing(exprs)) {
    if (n)
      stop("Must use 'exprs' or unnamed expressions, but not both")
    envir <- if (isTRUE(local))
      parent.frame()
    else if (isFALSE(local))
      .GlobalEnv
    else if (is.environment(local))
      local
    else stop("'local' must be TRUE, FALSE or an environment")
    exprs <- substitute(exprs)
    E1 <- if (is.call(exprs))
      exprs[[1]]
    cl <- if (is.symbol(E1) && (E1 == quote(`{`) || E1 ==
        quote(expression))) {
      exprs[[1]] <- quote(stopifnot)
      exprs
    }
    else as.call(c(quote(stopifnot), if (is.null(E1) && is.symbol(exprs) &&
        is.expression(E1 <- eval(exprs))) as.list(E1) else as.expression(exprs)))
    names(cl) <- NULL
    return(eval(cl, envir = envir))
  }
  Dparse <- function(call, cutoff = 60L) {
    ch <- deparse(call, width.cutoff = cutoff)
    if (length(ch) > 1L)
      paste(ch[1L], "....")
    else ch
  }
  head <- function(x, n = 6L) x[seq_len(if (n < 0L) max(length(x) +
      n, 0L) else min(n, length(x)))]
  abbrev <- function(ae, n = 3L) paste(c(head(ae, n), if (length(ae) >
      n) "...."), collapse = "\n  ")
  for (i in seq_len(n)) {
    r <- ...elt(i)
    tmp <- if (FALSE)
      eval(quote(1))
    if (!(is.logical(r) && !anyNA(r) && all(r))) {
      cl.i <- match.call()[[i + 1L]]
      msg <- if (is.call(cl.i) && identical(cl.i[[1]],
        quote(all.equal)) && (is.null(ni <- names(cl.i)) ||
            length(cl.i) == 3L || length(cl.i <- cl.i[!nzchar(ni)]) ==
            3L))
        sprintf(gettext("%s and %s are not equal:\n  %s"),
          Dparse(cl.i[[2]]), Dparse(cl.i[[3]]), abbrev(r))
      else sprintf(ngettext(length(r), "%s is not TRUE",
        "%s are not all TRUE"), Dparse(cl.i))
      stop(simpleError(paste0(msg, msg_append), call = if (p <- sys.parent(1L))
        sys.call(p)))
    }
  }
  invisible()
}
