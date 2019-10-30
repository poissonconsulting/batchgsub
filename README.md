
<!-- README.md is generated from README.Rmd. Please edit that file -->

# batchgsub

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.com/poissonconsulting/batchgsub.svg?branch=master)](https://travis-ci.com/poissonconsulting/batchgsub)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/poissonconsulting/batchgsub?branch=master&svg=true)](https://ci.appveyor.com/project/poissonconsulting/batchgsub)
[![License:
MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
<!-- [![CRAN status](https://www.r-pkg.org/badges/version/batchgsub)](https://cran.r-project.org/package=batchgsub) -->
<!-- ![CRAN downloads](https://cranlogs.r-pkg.org/badges/batchgsub) -->
<!-- badges: end -->

`batchgsub` provides a function, Shiny app and RStudio addin for batch
replacement of text content in files.

## Installation

<!-- To install the latest release from [CRAN](https://cran.r-project.org) -->

To install the developmental version from
[GitHub](https://github.com/poissonconsulting/batchgsub)

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/batchgsub")
```

To install the latest developmental release from the Poisson drat
[repository](https://github.com/poissonconsulting/drat)

``` r
# install.packages("drat")
drat::addRepo("poissonconsulting")
install.packages("batchgsub")
```

## Demonstration

### Function

``` r
library(batchgsub)

path <- tempdir()
file <- file.path(path, "file1.txt")
writeLines("The quick brown fox jumps over the lazy dog", con = file)
readLines(file)
#> [1] "The quick brown fox jumps over the lazy dog"
batch_gsub("o", "ooo", path = path, regexp = "[.]txt$", ask = FALSE)
#> ✔ file1.txt [00:00:00.001]
#> 
#> Success: 1
#> Failure: 0
#> Remaining: 0
#> 
readLines(file)
#> [1] "The quick brooown fooox jumps ooover the lazy dooog"
```

### Shiny App

``` r
batchgsub::run_app()
```

![Shiny app](man/figures/shiny-app.png)

### RStudio addin

The RStudio addin opens the Shiny app from the [Addins
menu](https://rstudio.github.io/rstudioaddins/).

The RStudio addin allows the user to set a keyboard shortcut to run the
Shiny app.

![RStudio addin](man/figures/rstudio-addin.png)

## Contribution

Please report any
[issues](https://github.com/poissonconsulting/batchgsub/issues).

[Pull requests](https://github.com/poissonconsulting/batchgsub/pulls)
are always welcome.

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/poissonconsulting/batchgsub/blob/master/CODE_OF_CONDUCT.md).
By contributing, you agree to abide by its terms.
