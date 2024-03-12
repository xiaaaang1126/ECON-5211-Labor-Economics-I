
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


data.table(matrix(0, reps, 6))
dt[, w_0 := epsilon_0 + mu_0]
dt[, w_1 := epsilon_1 + mu_1]
dt[, I := w_1 > w_0 + C]
dt[I == 1, mean(w_0)]
dt[I == 1, mean(w_1)]
df[]