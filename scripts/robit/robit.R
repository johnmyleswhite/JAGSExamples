library('rjags')

df <- read.csv(file.path('data', 'robit', 'robit_regression.csv'))

with(df, plot(X, Y))

jags <- jags.model(file.path('bugs', 'robit', 'robit.bugs'),
                   data = list('x' = with(df, X),
                               'y' = with(df, Y),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 2000)
 
mcmc.samples <- coda.samples(jags,
                        c('a', 'b'),
                        10000,
                        thin = 2)

plot(mcmc.samples)

summary(mcmc.samples)$statistics

apply(as.matrix(mcmc.samples), 2, median)

glm(Y ~ X, data = df, family = binomial(link = 'logit'))
