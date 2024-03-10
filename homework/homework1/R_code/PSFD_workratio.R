# import package
library(tidyverse)
setwd("/Users/xiang/Library/CloudStorage/GoogleDrive-xiang001126turkey@gmail.com/我的雲端硬碟/NTU_course/112Spring/03_勞動經濟學一/homework/homework1")

# import data
data <- read.csv("data/PSFD_2000/psfd_ri2000_v202110_csv.csv", header = TRUE, sep = ",")

# select the variables columns we want and generate work (binary) and age (numeric)
workratio <- data %>%
  select(work_status = c01, born_year = a02) %>%
  mutate(cnt = 1, work = 2 - work_status, age = 89 - born_year) %>%
  group_by(age) %>%
  summarize(work_ratio = sum(work) / sum(cnt))

# check
head(workratio)

# use ggplot2 to make graph
ggplot(workratio, aes(x = age, y = work_ratio)) + geom_line()
ggsave("pic/Q3_4_workratio.png")