# Michal's RStudio Addins

<!-- badges: start -->
[![R-CMD-check](https://github.com/mbojan/maddins/workflows/R-CMD-check/badge.svg)](https://github.com/mbojan/maddins/actions)
<!-- badges: end -->

A collection of RStudio addins.


## Addins

### Glimpse selection

Call `dplyr::glimpse()` or `utils::str()` on text currently selected in RStudio editor. If it is a word assume object name and use `get()` otherwise treat it as an expression, parse, evaluate and call `str()`/`glimpse()` on the result.

Very effective when bound to a key combination to quickly inspect objects. Especially data frames.
