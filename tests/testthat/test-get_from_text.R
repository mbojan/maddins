# Test get_from_text() on object names ------------------------------------

test_that("fetches correctly object by name", {
  skip("not working")
  expect_identical(get_from_text("x"), x)
  expect_identical(get_from_text(" x "), x)
  expect_identical(get_from_text(" x\n"), x)
} )
