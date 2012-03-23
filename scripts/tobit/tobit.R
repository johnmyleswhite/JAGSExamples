# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'tobit',
                         'tobit_regression.csv'))

png(file.path('graphs', 'tobit', 'data_plot.png'))
with(df, plot(X, Y))
dev.off()

png(file.path('graphs', 'tobit', 'hidden_data_plot.png'))
with(df, plot(X, YStar))
dev.off()

jags <- jags.model(file.path('bugs',
                             'tobit',
                             'tobit.bugs'),
                   data = list('x' = with(df, X),
                               'y' = with(df, Y),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 1000)
 
mcmc.samples <- coda.samples(jags,
                        c('a', 'b', 'sigma'),
                        1000)

png(file.path('graphs', 'tobit', 'plot1.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)

# Compare with MLE OLS solution.
lm(Y ~ X, data = df)

# Compare with MLE tobit solution.
library('VGAM')
fit <- vglm(Y ~ X, family = tobit(Lower = 0), df, trace = TRUE, crit = 'coeff')
