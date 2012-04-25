theta <- seq(0, 1, by = 0.01)

l <- dbinom(9, 10, theta)

df <- data.frame(theta = theta, L = l)

ggplot(df, aes(x = theta, y = L)) +
  geom_line() +
  opts(title = 'Likelihood Function after 9 Days of Rain and 1 Day of No Rain')
ggsave('likelihood_function.png')

ggplot(df, aes(x = theta, y = L)) +
  geom_line() +
  geom_vline(xintercept = 0.9, color = 'blue') +
  opts(title = 'Likelihood Function after 9 Days of Rain and 1 Day of No Rain')
ggsave('likelihood_function_mle.png')
