library('rjags')

df <- read.csv(file.path('data', 'ols', 'ols_regression.csv'))

with(df, plot(X, Y))

jags <- jags.model(file.path('bugs', 'ols', 'ols_regression.bugs'),
                   data = list('x' = with(df, X),
                               'y' = with(df, Y),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 1000)
 
mcmc.samples <- coda.samples(jags,
                        c('a', 'b', 'sigma'),
                        1000)

plot(mcmc.samples)

summary(mcmc.samples)

lm(Y ~ X, data = df)
