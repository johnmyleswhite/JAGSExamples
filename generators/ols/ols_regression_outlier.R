set.seed(1)

a <- 10
b <- 100

sigma <- 25

x <- seq(0, 10, by = 0.5)
y <- a * x + b
y <- y + rnorm(length(y), 0, sigma)

y[8] <- 999

write.csv(data.frame(X = x, Y = y),
          file = file.path('data', 'ols', 'ols_regression_outlier.csv'),
          row.names = FALSE)
