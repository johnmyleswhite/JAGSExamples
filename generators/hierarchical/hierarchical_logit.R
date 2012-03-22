set.seed(1)

n.subjects <- 25
n.trials <- 50

df <- data.frame()

mu.a <- 0.5
mu.b <- -2

for (subject in 1:n.subjects)
{
  a <- rnorm(1, mu.a, 1)
  b <- rnorm(1, mu.b, 1)
  
  for (trial in 1:n.trials)
  {
    x <- runif(1, 0, 10)
    z <- a * x + b
    p <- 1 / (1 + exp(-z))
    y <- rbinom(length(x), 1, prob = p)
    
    df <- rbind(df, data.frame(g = subject, t = trial, x = x, y = y, a = a, b = b))
  }
}

write.csv(df,
          file = file.path('data', 'hierarchical', 'hierarchical_logit.csv'),
          row.names = FALSE)
