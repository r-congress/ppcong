test_that("ppc_members works", {
  ##skips tests on CRAN, using the NOT_CRAN environment variable set by devtools
  skip_on_cran()

  ## get data frame
  gas1 <- ppc_members(congress = "116",
                      chamber = "senate",
                      raw = FALSE)

  expect_true(is.data.frame(gas1))
  expect_gt(ncol(gas1), 2) ## check if # of columns is greater than 2
  expect_gt(nrow(gas1), 2) ## check if # of rows is greater than 2

  ## get raw data (a list)
  gas2 <- ppc_members(congress = "116",
                      chamber = "senate",
                      raw = TRUE)

  expect_true(is.list(gas2))
  expect_gt(length(gas2), 1) ## check if the list length is greater than 1

  expect_error(
    ppc_members(api_key = "") ## no api_key
  )

  ## input flexibility tests
  s <- ppc_members(116, "senate")
  expect_true(is.data.frame(s))
  expect_gt(nrow(s), 90)
  expect_true(all(tolower(s$chamber) == "senate"))
  expect_true(all(s$congress == "116"))
  s <- ppc_members("senate", 115)
  expect_true(is.data.frame(s))
  expect_gt(nrow(s), 90)
  expect_true(all(tolower(s$chamber) == "senate"))
  expect_true(all(s$congress == "115"))
})


test_that("ppc_api works", {
  ##skips tests on CRAN, using the NOT_CRAN environment variable set by devtools
  skip_on_cran()
  ##skips tests on continuous integration systems by inspecting the CI environment variabl
  #skip_on_ci()

  ## get key
  api <- ppc_api_key()

  expect_true(is.character(api))
  expect_equal(length(api), 1) ## check if the length of api equals 1

  expect_error(
    ppc_api_key(api_key = 123) ## api is a number
  )
})


test_that("ppc_committees works", {
  ##skips tests on CRAN, using the NOT_CRAN environment variable set by devtools
  skip_on_cran()

  ## get data frame
  cmt <- ppc_committees()

  expect_true(is.data.frame(cmt))
  expect_gt(ncol(cmt), 2) ## check if # of columns is greater than 2
  expect_gt(nrow(cmt), 2) ## check if # of rows is greater than 2
})


test_that("ppc_votes works", {
  ##skips tests on CRAN, using the NOT_CRAN environment variable set by devtools
  skip_on_cran()

  ## get data frame
  x <- ppc_votes()

  expect_true(is.data.frame(x))
  expect_gt(ncol(x), 2) ## check if # of columns is greater than 2
  expect_gt(nrow(x), 2) ## check if # of rows is greater than 2
})


test_that("ppc_bills works", {
  ##skips tests on CRAN, using the NOT_CRAN environment variable set by devtools
  skip_on_cran()

  ## get data frame
  x <- ppc_bills()

  expect_true(is.data.frame(x))
  expect_gt(ncol(x), 2) ## check if # of columns is greater than 2
  expect_gt(nrow(x), 2) ## check if # of rows is greater than 2
})


test_that("ppc_statements works", {
  ##skips tests on CRAN, using the NOT_CRAN environment variable set by devtools
  skip_on_cran()

  ## get data frame
  x <- ppc_statements("2017-05-08")

  expect_true(is.data.frame(x))
  expect_gt(ncol(x), 2) ## check if # of columns is greater than 2
  expect_gt(nrow(x), 2) ## check if # of rows is greater than 2
})


test_that("ppc_api functions work", {
  skip_on_cran()

  ## forget API key
  expect_warning(
    ppcong:::ppc_request("https://api.propublica.org/congress/v1/congress.json",
      api_key = NULL, FALSE)
  )

  ## invalid congress number
  expect_error(
    ppc_members(-120, raw = TRUE)
  )
})
