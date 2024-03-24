# 定義對數似然函數
log_likelihood <- function(params, data) {
  sigma1_squared <- params[1]
  sigma2_squared <- params[2]
  n <- length(data)
  total_variance <- sigma1_squared + sigma2_squared
  
  # 計算對數似然
  ll <- -n/2 * log(2 * pi) - n/2 * log(total_variance) - sum(data^2) / (2 * total_variance)
  return(-ll)  # optim 函數是最小化，所以我們返回 -ll
}

# 模擬數據，N = 2
set.seed(123)  # 設定種子以獲得可重現的結果
data <- rnorm(2, mean = 0, sd = sqrt(1))  # 假設真實的標準差為 1

# 使用 optim 函數進行最優化
initial_values <- c(1, 1)  # 初始化估計值
optim_results <- optim(initial_values, log_likelihood, data = data)

# 輸出最優化結果
optim_results$par

