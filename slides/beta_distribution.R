df <- data.frame(theta = seq(0, 1, by = 0.01))
df <- transform(df, posterior = dbeta(theta, 11, 4))

ggplot(df, aes(x = theta, y = posterior)) +
  geom_line()
ggsave('beta_distribution.png')
