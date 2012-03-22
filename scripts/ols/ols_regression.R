# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'ols',
                         'ols_regression.csv'))

png(file.path('graphs', 'ols', 'data_plot.png'))
with(df, plot(X, Y))
dev.off()

jags <- jags.model(file.path('bugs',
                             'ols',
                             'ols_regression.bugs'),
                   data = list('x' = with(df, X),
                               'y' = with(df, Y),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 1000)
 
mcmc.samples <- coda.samples(jags,
                        c('a', 'b', 'sigma'),
                        1000)

png(file.path('graphs', 'ols', 'plot1.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)

# Compare with true OLS solution.
lm(Y ~ X, data = df)
