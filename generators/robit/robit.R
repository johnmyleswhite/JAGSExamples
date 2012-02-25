set.seed(1)

a <- 2
b <- -5

x <- seq(0, 20, by = 0.5)
z <- a * x + b
p <- pt(z, 1)
y <- rbinom(length(x), 1, prob = p)

# Force one extreme outlier to showcase robit's value.
# Without these extremes, robit doesn't really outperform logistic.
y[length(y)] <- 0

write.csv(data.frame(X = x, Y = y),
          file = file.path('data', 'robit', 'robit_regression.csv'),
          row.names = FALSE)
