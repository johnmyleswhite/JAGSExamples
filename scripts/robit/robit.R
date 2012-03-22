# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'robit',
                         'robit_regression.csv'))

png(file.path('graphs', 'robit', 'data_plot.png'))
with(df, plot(X, Y))
dev.off()

jags <- jags.model(file.path('bugs',
                             'robit',
                             'robit.bugs'),
                   data = list('x' = with(df, X),
                               'y' = with(df, Y),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 2000)
 
mcmc.samples <- coda.samples(jags,
                        c('a', 'b'),
                        10000,
                        thin = 2)

png(file.path('graphs', 'robit', 'plot1.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)$statistics

apply(as.matrix(mcmc.samples), 2, median)

# Compare with GLM solution.
glm(Y ~ X, data = df, family = binomial(link = 'logit'))
