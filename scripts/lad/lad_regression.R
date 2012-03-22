# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'lad',
                         'lad_regression.csv'))

png(file.path('graphs', 'lad', 'data_plot.png'))
with(df, plot(X, Y))
dev.off()

jags <- jags.model(file.path('bugs',
                             'lad',
                             'lad_regression.bugs'),
                   data = list('x' = with(df, X),
                               'y' = with(df, Y),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 1000)
 
mcmc.samples <- coda.samples(jags,
                        c('a', 'b', 'sigma'),
                        1000)

png(file.path('graphs', 'lad', 'plot1.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)

# Compare with the OLS solution.
lm(Y ~ X, data = df)

lad.coef <- summary(mcmc.samples)$statistics[c(2, 1), 1]
ols.coef <- coef(lm(Y ~ X, data = df))

library('ggplot2')

ggplot(df, aes(x = X, y = Y)) +
  geom_point() +
  geom_abline(intercept = lad.coef[1],
              slope = lad.coef[2],
              color = "blue") +
  geom_abline(intercept = ols.coef[1],
              slope = ols.coef[2],
              color = "green")
ggsave(file.path('graphs', 'lad', 'lad_vs_ols.png'))
