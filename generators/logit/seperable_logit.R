set.seed(1)

x <- seq(0, 10, by = 0.1)
y <- ifelse(x > 5, 1, 0)

write.csv(data.frame(X = x, Y = y),
          file = file.path('data', 'logit', 'separable_logit.csv'),
          row.names = FALSE)
