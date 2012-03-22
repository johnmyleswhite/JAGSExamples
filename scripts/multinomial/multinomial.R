# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'multinomial',
                         'multinomial.csv'))

z <- as.matrix(df)

jags <- jags.model(file.path('bugs',
                             'multinomial',
                             'multinomial.bugs'),
                   data = list('z' = z,
                               'N' = nrow(z),
                               'K' = ncol(z)),
                   n.chains = 4,
                   n.adapt = 1000)
                   
mcmc.samples <- coda.samples(jags,
                             c('pi'),
                             2500)

png(file.path('graphs', 'multinomial', 'plot.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)

# Compare approximate posterior mean with analytic posterior mean.
# TO DO
