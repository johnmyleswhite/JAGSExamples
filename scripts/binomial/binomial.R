# Basic inference.
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
                   n.adapt = 1000)
                   
mcmc.samples <- coda.samples(jags,
                             c('p'),
                             2500)

png(file.path('graphs', 'binomial', 'plot.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)

# Compare approximate posterior mean with analytic posterior mean.
alpha <- with(df, sum(X) + 1)
beta <- nrow(df) + 2 - alpha

alpha / (alpha + beta)

# Compare distribution of samples with theoretical density.
samples <- data.frame(MCMC = as.matrix(mcmc.samples)[, 1])
density.plot <- ggplot(samples, aes(x = MCMC)) +
  geom_density(aes(color = 'Sampling'))

x <- seq(0, 1, by = 0.01)
analytic <- data.frame(x = x, y = dbeta(x, alpha, beta))
density.plot <- density.plot +
  geom_line(data = analytic, aes(x = x, y = y, color = 'Analytic'))
ggsave(file.path('graphs', 'binomial', 'density.png'))

# Compare confidence intervals with credible intervals.
# binom.test(1, 5)
# binom.test(2, 7)

binom.test(with(df, sum(X)), nrow(df))$conf.int
credible.interval <- c(qbeta(0.025, alpha, beta),
                       qbeta(0.975, alpha, beta))
credible.interval
binom.test(with(df, sum(X)) + 1, nrow(df) + 2)$conf.int
