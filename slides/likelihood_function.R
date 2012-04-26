theta <- seq(0, 1, by = 0.01)

l <- dbinom(9, 10, theta)

df <- data.frame(theta = theta, L = l)

ggplot(df, aes(x = theta, y = L)) +
  geom_line() +
  opts(title = 'Likelihood Function after 9 Mistaken Orders and 1 Correct Order')
ggsave('likelihood_function.png')

ggplot(df, aes(x = theta, y = L)) +
  geom_line() +
  geom_vline(xintercept = 0.9, color = 'blue') +
  opts(title = 'Likelihood Function after 9 Mistaken Orders and 1 Correct Order')
ggsave('likelihood_function_mle.png')
