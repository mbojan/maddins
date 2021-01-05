# Test get_from_text() on object names ------------------------------------

test_that("fetches correctly object by name", {
  # skip("not working")
  x <- 100
  r <- get_from_text("x")
  expect_identical(r, x)
} )
