set.seed(1)

a <- 2
b <- 1

x <- seq(-10, 10, by = 0.1)
y.star <- a * x + b
y.star <- y.star + rnorm(length(y.star), 0, 1)
y <- ifelse(y.star >= 0, y.star, 0)

write.csv(data.frame(X = x, YStar = y.star, Y = y),
          file = file.path('data', 'tobit', 'tobit_regression.csv'),
          row.names = FALSE)
