set.seed(1)

p <- 0.4

x <- rbinom(5, 1, prob = p)

write.csv(data.frame(X = x),
          file = file.path('data', 'binomial', 'binomial.csv'),
          row.names = FALSE)
