d <- c(0, 1, 1, 1, 1, 1, 1, 1, 1, 1)

likelihood <- function(d, theta)
{
  dbinom(sum(d), length(d), prob = theta)
}

df <- data.frame(theta = seq(0, 1, by = 0.01))
df <- transform(df, likelihood = likelihood(d, theta))

ggplot(df, aes(x = theta, y = likelihood)) +
  geom_line()

# Likelihoods do not integrate to 1 when integrating with respect to theta.
with(df[1:100, ], sum(likelihood) * 0.01)

# beta(2, 3) prior
df <- transform(df, prior = dbeta(theta, 2, 3))

ggplot(df, aes(x = theta, y = prior)) +
  geom_line()

# Unnormalized posterior.
df <- transform(df, unnormalizedPosterior = prior * likelihood)

ggplot(df, aes(x = theta, y = unnormalizedPosterior)) +
  geom_line()

# Normalize so all integrate to 101.
#df <- transform(df, likelihood = likelihood * (101 / sum(likelihood)))
#df <- transform(df, prior = prior * (101 / sum(prior)))
df <- transform(df, normalizedPosterior = unnormalizedPosterior * (101 / sum(unnormalizedPosterior)))

# Visualize normalized versions.
library('reshape')
compare.df <- melt(df, id.vars = 'theta')

ggplot(compare.df, aes(x = theta, y = value, color = variable, group = variable)) +
  geom_line()
ggsave('grid_approximation.png')

# Notice that posterior is more peaked than prior. This is because confidence has gone up, even though we've changed our minds.

# Compare with correct posterior, which is a beta(11, 4) distribution.
df <- transform(df, truePosterior = dbeta(theta, 11, 4))

# Visualize normalized versions.
compare.df <- melt(df, id.vars = 'theta')

compare.df <- subset(compare.df, variable %in% c('normalizedPosterior', 'truePosterior'))

ggplot(compare.df, aes(x = theta, y = value, color = variable, group = variable)) +
  geom_line()
ggsave('grid_quality.png')
