set.seed(1)

pi <- c(0.7, 0.2, 0.1)

N <- 100

z <- matrix(rep(NA, N * length(pi)), nrow = N, ncol = length(pi))

for (i in 1:N)
{
  z[i, ] <- t(rmultinom(1, 1, pi))
}

write.csv(z,
          file = file.path('data',
                           'multinomial',
                           'multinomial.csv'),
          row.names = FALSE)
