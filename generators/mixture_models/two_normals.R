set.seed(1)

p <- 0.8
mu1 <- 0
mu2 <- 5
sigma <- 1
N <- 1000

df <- data.frame()

for (i in 1:N)
{
  z <- rbinom(1, 1, p)
  x <- rnorm(1, ifelse(z == 1, mu1, mu2), sigma)
  df <- rbind(df, data.frame(z = z, x = x, p = p, mu1 = mu1, mu2 = mu2, sigma = sigma))
}

write.csv(df,
          file = file.path('data', 'mixture_models', 'two_normals.csv'),
          row.names = FALSE)
