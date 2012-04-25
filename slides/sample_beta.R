theta <- seq(0, 1, by = 0.01)

df <- data.frame(theta = theta,
                 d = dbeta(theta, 2, 1))

ggplot(df, aes(x = theta, y = d)) +
  geom_line() +
  ylab('P(theta)') +
  opts(title = 'Bayesian Estimate')
ggsave('sample_beta.png')
