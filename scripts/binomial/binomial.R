library('rjags')

df <- read.csv(file.path('data', 'binomial', 'binomial.csv'))

jags <- jags.model(file.path('bugs', 'binomial', 'binomial.bugs'),
                   data = list('x' = with(df, X),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 1000)
                   
mcmc.samples <- coda.samples(jags,
                             c('p'),
                             2500)

plot(mcmc.samples)

summary(mcmc.samples)

with(df, sum(X) + 1) / (nrow(df) + 2)
