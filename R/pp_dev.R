




is_congress_id <- function(x) length(x) == 1 && is.character(x) && grepl("^[A-Z]\\d+$", x)

