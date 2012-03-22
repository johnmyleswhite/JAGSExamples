# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'mixture_models',
                         'two_normals.csv'))

ggplot(df, aes(x = x)) + geom_histogram()
ggsave(file.path('graphs', 'mixture_models', 'blind_histogram.png'))
ggplot(df, aes(x = x, fill = factor(z))) + geom_histogram()
ggsave(file.path('graphs', 'mixture_models', 'labelled_histogram.png'))

jags <- jags.model(file.path('bugs',
                             'mixture_models',
                             'two_normals.bugs'),
                   data = list('x' = with(df, x),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 1000)
 
mcmc.samples <- coda.samples(jags,
                             c('p', 'mu1', 'mu2', 'sigma'),
                             5000)

png(file.path('graphs', 'mixture_models', 'two_normals_plot1.png'))
plot(mcmc.samples)
dev.off()

summary(mcmc.samples)

# Compare with true parameter values.
with(df, unique(p))
with(df, unique(mu1))
with(df, unique(mu2))
with(df, unique(sigma))

# Extract individual point cluster assignments.
mcmc.samples <- coda.samples(jags,
                             c('z', 'p', 'mu1', 'mu2', 'sigma'),
                             5000)

summary(mcmc.samples)

# Use the MCMCtools package from GitHub for alternative summaries.
library('MCMCtools')
mcmc.summarize(mcmc.samples)
