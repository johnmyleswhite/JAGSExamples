# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'normal',
                         'normal_mean.csv'))

jags <- jags.model(file.path('bugs',
                             'normal',
                             'normal_mean.bugs'),
                   data = list('x' = with(df, X),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 500)
                   
mcmc.samples <- coda.samples(jags,
                             c('mu'),
                             1000)

png(file.path('graphs', 'normal', 'plot1.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)
