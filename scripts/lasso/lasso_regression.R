library('rjags')

df <- read.csv(file.path('data', 'lasso', 'lasso_regression.csv'))

m <- ncol(df) - 1
n <- nrow(df)

x <- as.matrix(df[, 1:m])
y <- with(df, Y)

jags <- jags.model(file.path('bugs', 'lasso', 'lasso_regression.bugs'),
                   data = list('x' = x,
                               'y' = y,
                               'N' = n,
                               'M' = m),
                   n.chains = 4,
                   n.adapt = 5000)

mcmc.samples <- coda.samples(jags,
                        c('beta', 'sigma'),
                        10000,
                        thin = 5)

plot(mcmc.samples, ask = TRUE)

summary(mcmc.samples)$statistics

library('glmnet')

lasso.fit <- glmnet(x, y, alpha = 1)
coef(lasso.fit, s = min(lasso.fit$lambda))

ridge.fit <- glmnet(x, y, alpha = 0)
coef(ridge.fit, s = min(ridge.fit$lambda))
