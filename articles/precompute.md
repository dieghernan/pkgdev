# Example of a precomputed vignette

This is an example of a precomputed vignette:

``` r
set.seed(1234)
tbl <- data.frame(x = runif(10), y = runif(10))
plot(x = tbl$x, y = tbl$y)
```

![plot of chunk plot](plot-1.png)

plot of chunk plot

Another plot

``` r
plot(x = tbl$y, y = tbl$x)
```

![plot of chunk plot2](plot2-1.png)

plot of chunk plot2
