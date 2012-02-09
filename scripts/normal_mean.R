library('rjags')

df <- read.csv(file.path('data', 'normal_mean.csv'))

jags <- jags.model('bugs/normal_mean.bugs',
                   data = list('x' = with(df, X),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 500)
                   
mcmc.samples <- coda.samples(jags,
                             c('mu'),
                             1000)

plot(mcmc.samples)

summary(mcmc.samples)
