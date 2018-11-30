n <- 1
x <- '2'

b <- as.numeric(X)
b
print(class(x))
print(class(n))

BMI <- data.frame(
  gender = c("Male", "Male","Female"), 
  height = c(152, 171.5, 165), 
  weight = c(81,93, 78),
  Age = c(42,38,26)
)
print(BMI)

#correlation
motorcars <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/datasets/mtcars.csv", stringsAsFactors = FALSE)

head(motorcars)
#correlation function
cor(motorcars$wt, motorcars$mpg)

plot( pch = 21, bg = 2, motorcars$wt, motorcars$mpg, xlab = "Weight", ylab="mpg")

require(ggpubr)
library(tidyverse)
require(Hmisc)
require(corrplot)

head(motorcars)
my_data <- motorcars
my_data$cyl <- factor(my_data$cyl)
str(my_data)

library(ggpubr)
ggscatter(my_data, x = "wt", y = "mpg",
          add = "reg.line", conf.int = TRUE,
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Weight (1000 lbs)", ylab = "Miles/ (US) gallon")

