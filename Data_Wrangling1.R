#Chapter 2 Data Manipulation using tidyr
library("tidyverse")
library("lubridate")
MS_bw_pop <- read.csv("D://Course/R Programming/RData/MS_acs2015_bw.csv")
#head(trafficstops)
head(MS_bw_pop)

#2.2 Long to Wide with spread
trafficstops_ma <- trafficstops %>% 
  filter(!is.na(driver_gender)) %>% 
  group_by(county_name, driver_gender) %>% 
  summarize(mean_age = mean(driver_age, na.rm = TRUE))

head(trafficstops_ma) #<-long data

#convert from long to wide, use spread()
trafficstops_ma_wide <- trafficstops_ma %>% 
  spread(driver_gender, mean_age)

head(trafficstops_ma_wide) #<- wide data

#find age differences between male and female
trafficstops_ma_wide %>% 
  mutate(agediff = male - female) %>% 
  ungroup() %>% 
  filter(agediff %in% range(agediff))

#2.3 Wide to long with gather
trafficstops_ma_long <- trafficstops_ma_wide %>% 
  gather(gender, mean_age, -county_name)

head(trafficstops_ma_long)

#specific column
trafficstops_ma_wide %>%
  gather(gender, mean_age, female:male) %>% 
  head()

trafficstops %>% 
  filter(!is.na(driver_race)) %>% 
  count(county_name, county_fips, driver_race) %>% 
  spread(driver_race, n, fill = 0, sep = "_") %>% 
  head()

#kombinasi
trafficstops %>% 
  filter(!is.na(driver_race)) %>% 
  count(county_name, county_fips, driver_race) %>% 
  spread(driver_race, n, fill = 0, sep = "_") %>%  
  left_join(MS_bw_pop, by = c("county_fips" = "FIPS")) %>% 
  mutate(pct_black_stopped = driver_race_Black/black_pop,
         pct_white_stopped = driver_race_White/white_pop) %>% 
  print(n=5, width=Inf)

#export csv
trafficstops %>% 
  filter(!is.na(driver_race)) %>% 
  count(county_name, county_fips, driver_race) %>% 
  spread(driver_race, n, fill = 0, sep = "_") %>%  
  left_join(MS_bw_pop, by = c("county_fips" = "FIPS")) %>% 
  mutate(pct_black_stopped = driver_race_Black/black_pop,
         pct_white_stopped = driver_race_White/white_pop) %>% 
  write.csv(file = "D://MS_demographic_export.csv", row.names = FALSE)