test_that("ppc_members works", {
  ##skips tests on CRAN, using the NOT_CRAN environment variable set by devtools
  skip_on_cran()
  ##skips tests on continuous integration systems by inspecting the CI environment variabl
  #skip_on_ci()

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
