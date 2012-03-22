# Basic inference with no adaptive phase and few posterior samples.
library('rjags')

df <- read.csv(file.path('data',
                         'binomial',
                         'binomial.csv'))

jags <- jags.model(file.path('bugs',
                             'binomial',
                             'binomial.bugs'),
                   data = list('x' = with(df, X),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 0)
                   
mcmc.samples <- coda.samples(jags,
                             c('p'),
                             100)

png(file.path('graphs', 'binomial', 'broken_plot.png'))
plot(mcmc.samples)
dev.off()
