MS_demographic <- read.csv("D://Course/MS_demographic.csv")
head(MS_demographic)
install.packages('ggplot2')
library("tidyverse")
library(ggplot2)
ggplot(data=MS_demographic, aes(x=pct_black_stopped, y = pct_white_stopped)) +
  geom_point()

#3.2 Building your plots iteratively
MS_demographic %>% 
  ggplot(aes(x = pct_black_stopped, y = pct_white_stopped)) +
  xlab("PTC White Stopped") +
  ylab("PTC Black Stopped") +
  geom_point()

#add filter
MS_demographic %>%
  filter(pct_white_stopped < 0.5 & pct_black_stopped < 0.5) %>% 
  ggplot(aes(x = pct_black_stopped, y = pct_white_stopped)) +
  geom_point()

#add color & challenge
MS_demographic %>%
  filter(pct_white_stopped < 0.7 & pct_black_stopped < 0.2) %>% 
  ggplot(aes(x = pct_black_stopped, y = pct_white_stopped)) +
  geom_point(alpha=0.3, color="red", size=5) +
  geom_abline(color="blue")

#3.3 Barplot
ggplot(trafficstops, aes(violation))+
  geom_bar()
  
#add color
ggplot(trafficstops, aes(violation)) +
  geom_bar(fill="blue")

#color by gender
ggplot(trafficstops, aes(violation)) +
  geom_bar(aes(fill=driver_gender), position = "fill")