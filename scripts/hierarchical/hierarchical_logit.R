# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'hierarchical',
                         'hierarchical_logit.csv'))

jags <- jags.model(file.path('bugs',
                             'hierarchical',
                             'hierarchical_logit.bugs'),
                   data = list('x' = with(df, x),
                               'y' = with(df, y),
                               'g' = with(df, g),
                               'N' = nrow(df),
                               'K' = with(df, max(g))),
                   n.chains = 4,
                   n.adapt = 5000)
 
mcmc.samples <- coda.samples(jags,
                             c('mu.a',
                               'mu.b',
                               'tau.a',
                               'tau.b'),
                             5000)

png(file.path('graphs', 'hierarchical', 'logit_plot1.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)

mcmc.samples <- coda.samples(jags,
                             c('a',
                               'b',
                               'mu.a',
                               'mu.b',
                               'tau.a',
                               'tau.b'),
                             5000)

summary(mcmc.samples)

# Compare with true parameter values and OLS solution(s).
library('plyr')
ddply(df, 'g', function (df) {with(df, unique(a))})
ddply(df, 'g', function (df) {with(df, unique(b))})

glm(y ~ x : factor(g) + factor(g) - 1,
    data = df,
    family = binomial(link = 'logit'))
