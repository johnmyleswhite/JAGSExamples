set.seed(1)

m <- 20
n <- 50

beta <- rnorm(m, 10, 1)
indices <- sample(1:length(beta), m - 2)
beta[indices] <- 0

sigma <- 0.1

x <- matrix(rnorm(n * m), nrow = n, ncol = m)
y <- x %*% beta
y <- y + rnorm(length(y), 0, sigma)

write.csv(beta,
          file = file.path('data', 'lasso', 'lasso_regression_betas.csv'),
          row.names = FALSE)

write.csv(cbind(data.frame(x), data.frame(Y = y)),
          file = file.path('data', 'lasso', 'lasso_regression.csv'),
          row.names = FALSE)
