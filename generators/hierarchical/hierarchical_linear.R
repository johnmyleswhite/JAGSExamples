set.seed(1)

n.subjects <- 10
n.trials <- 100

df <- data.frame()

mu.a <- 10
mu.b <- -14

for (subject in 1:n.subjects)
{
  a <- rnorm(1, mu.a, 1)
  b <- rnorm(1, mu.b, 1)
  
  for (trial in 1:n.trials)
  {
    x <- runif(1, 0, 10)
    y <- a * x + b + rnorm(1, 0, 3)
    
    df <- rbind(df, data.frame(g = subject, t = trial, x = x, y = y, a = a, b = b))
  }
}

write.csv(df,
          file = file.path('data', 'hierarchical', 'hierarchical_linear.csv'),
          row.names = FALSE)
