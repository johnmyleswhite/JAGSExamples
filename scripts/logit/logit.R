# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'logit',
                         'logit_regression.csv'))

png(file.path('graphs', 'logit', 'data_plot.png'))
with(df, plot(X, Y))
dev.off()

jags <- jags.model(file.path('bugs',
                             'logit',
                             'logit.bugs'),
                   data = list('x' = with(df, X),
                               'y' = with(df, Y),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 1000)
 
mcmc.samples <- coda.samples(jags,
                        c('a', 'b'),
                        5000)

png(file.path('graphs', 'logit', 'plot1.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)

summary(mcmc.samples)$statistics

# Compare with GLM solution.
glm(Y ~ X,
    data = df,
    family = binomial(link = 'logit'))
