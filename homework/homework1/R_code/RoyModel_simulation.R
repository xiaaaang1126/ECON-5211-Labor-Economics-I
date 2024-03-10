# install.packages("data.table")
library(data.table)

# 1. Pick my favorite value for set of parameters
mu_0 <- 100
mu_1 <- 100
sigma_0 <- 3
sigma_1 <- 6
sigma_01 <- 5
cost <- 50
n <- 1000000

# 2. Simulate the epsilon_0 and epsilon_1
set.seed(123)
reps <- 1000000
par.est.DT <- data.table(matrix(0, reps, 6))
epsilon_0 <- rnorm(n, mean = 0, sd = sigma_0**2)
epsilon_1 <- rnorm(n, mean = 0, sd = sigma_1**2)

# 3. Create the columns for w0 and w1
w_0 <- mu_0 + epsilon_0
w_1 <- mu_1 + epsilon_1
par.est.DT[, 1] <- epsilon_0
par.est.DT[, 2] <- epsilon_1
par.est.DT[, 3] <- w_0
par.est.DT[, 4] <- w_1

# 4. Generate the column I that take binary value.
par.est.DT[, 5] <- ifelse(par.est.DT[, 2] > par.est.DT[, 1], 1, 0)

# 5. Calculate E[w0|I], E[w1|I], Q0, Q1 from data
E_epsilon0_D1 <- par.est.DT[V5 == 1, mean(V1)]
E_epsilon1_D1 <- par.est.DT[V5 == 1, mean(V2)]
E_w0_D1 <- par.est.DT[V5 == 1, mean(V3)]
E_w1_D1 <- par.est.DT[V5 == 1, mean(V4)]

# 6. Calculate RHS of equation (1) and (2)
nu <- epsilon_1 - epsilon_0
par.est.DT[, 6] <- nu
sigma_nu <- par.est.DT[,sd(V5)]
Z <- (mu_0 - mu_1 + cost)/sigma_nu
mill <- function(x) {
  pnorm(x, lower.tail=FALSE, log.p=TRUE) - dnorm(x, log=TRUE)
}
RHS_1 <- mu_0 + (sigma_0*sigma_1/sigma_nu) * (sigma_01/(sigma_0*sigma_1) - sigma_0/sigma_1) * mill(Z)
RHS_2 <- mu_1 + (sigma_0*sigma_1/sigma_nu) * (sigma_0/sigma_1 - sigma_01/(sigma_0*sigma_1)) * mill(Z)

E_w0_D1
E_w1_D1
RHS_1
RHS_2

