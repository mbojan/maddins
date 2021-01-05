# Test get_from_text() on object names ------------------------------------

test_that("fetches correctly object by name", {
  # skip("not working")
  x <- 100
  expect_identical(get_from_text("x"), x)
  expect_identical(get_from_text(" x "), x)
  expect_identical(get_from_text(" x\n"), x)
  expect_error(get_from_text("y"), "cannot evaluate")
} )

test_that("evaluates expression correctly", {
  e <- "mean(1:5)"
  expect_identical(get_from_text(e), eval(parse(text=e)))
})

test_that("catches parsing error correctly", {
  e <- "mean(1:5"  # missing closing brace
  expect_error(get_from_text(e), "cannot parse text")
})
