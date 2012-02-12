set.seed(1)

a <- 0.55
b <- 3

x <- seq(0, 10, by = 0.1)
z <- a * x - b
p <- 1 / (1 + exp(-z))
y <- rbinom(length(x), 1, prob = p)

write.csv(data.frame(X = x, Y = y),
          file = file.path('data', 'logit', 'logit_regression.csv'),
          row.names = FALSE)
