library('rjags')

df <- read.csv(file.path('data', 'gamma', 'gamma.csv'))

jags <- jags.model(file.path('bugs', 'gamma', 'gamma.bugs'),
                   data = list('x' = with(df, X),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 1000)
                   
mcmc.samples <- coda.samples(jags,
                             c('shape', 'rate'),
                             5000,
                             thin = 5)

plot(mcmc.samples)

summary(mcmc.samples)

# GLM values
# Conjugate values
