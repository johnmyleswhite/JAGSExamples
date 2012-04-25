sample.sizes <- 4 ^ seq(0, 3, by = 1)

theta <- 0.5

n.rep <- 5000

sampling.distribution <- data.frame()

for (sample.size in sample.sizes)
{
  for (sim in 1:n.rep)
  {
    estimator <- mean(rbinom(sample.size, 1, prob = theta))
    sampling.distribution <- rbind(sampling.distribution, data.frame(N = sample.size, I = sim, Estimator = estimator))
  }
}

ggplot(sampling.distribution, aes(x = Estimator)) +
  geom_histogram() +
  facet_grid(N ~ .) +
  xlab('Estimated Theta') +
  opts(title = 'Sampling Distributions for Theta as N Grows')
ggsave('sampling_distribution.png')
