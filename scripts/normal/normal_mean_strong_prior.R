library('rjags')

df <- read.csv(file.path('data', 'normal', 'normal_mean_strong_prior.csv'))

jags <- jags.model(file.path('bugs', 'normal', 'normal_mean_strong_prior.bugs'),
                   data = list('x' = with(df, X),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 500)
                   
mcmc.samples <- coda.samples(jags,
                             c('mu'),
                             1000)

plot(mcmc.samples)

summary(mcmc.samples)
