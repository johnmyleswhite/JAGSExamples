set.seed(1)

shape <- 3
rate <- 0.01

x <- rgamma(500, shape = shape, rate = rate)

write.csv(data.frame(X = x),
          file = file.path('data', 'gamma', 'gamma.csv'),
          row.names = FALSE)
