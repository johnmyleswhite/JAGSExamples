theta <- seq(0.01, 0.99, by = 0.01)

df <- data.frame()

for (n in c(10, 100, 1000))
{
  l <- dbinom(0.9 * n, n, theta)
  df <- rbind(df, data.frame(theta = theta, L = l, N = n))
}

ggplot(df, aes(x = theta, y = log(L))) +
  geom_line() +
  facet_grid(. ~ N) +
  ylab('Log Likelihood') +
  opts(title = 'Log Likelihood Function as N Increases')
ggsave('fisher_information.png')
