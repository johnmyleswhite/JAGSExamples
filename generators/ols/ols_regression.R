set.seed(1)

a <- 10
b <- 100

sigma <- 25

x <- seq(0, 10, by = 0.1)
y <- a * x + b
y <- y + rnorm(length(y), 0, sigma)

write.csv(data.frame(X = x, Y = y),
          file = file.path('data', 'ols', 'ols_regression.csv'),
          row.names = FALSE)
