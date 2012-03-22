# Basic infernece.
library('rjags')

binary.votes <- read.table(file.path('data',
                                     'ideal_points',
                                     'ideal_points.txt'))
binary.votes <- as.matrix(binary.votes)

a <- rep(NA, nrow(binary.votes))
a[which(row.names(binary.votes) == "COBURN (R OK)")] <- 2

jags <- jags.model(file.path('bugs',
                             'ideal_points',
                             'ideal_points.bugs'),
                   data = list('votes' = binary.votes,
                               'M' = nrow(binary.votes),
                               'N' = ncol(binary.votes),
                               'a' = a),
                   n.chains = 4,
                   n.adapt = 500)

j.samples <- jags.samples(jags,
                        c('a', 'b', 'g'),
                        250)

estimated.a <- apply(j.samples$a, 1, mean)

# Make a human readable table output of the ideal points.
df <- data.frame(Senator = row.names(binary.votes),
                 IdealPoint = estimated.a)
head(df)
tail(df)
