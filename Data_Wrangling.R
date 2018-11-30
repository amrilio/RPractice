install.packages("tidyverse")  
library("tidyverse")
trafficstops <- read.csv("D://Course/R Programming/RData/MS_trafficstops_bw_age.csv")
MS_bw_pop <- read.csv("D://Course/R Programming/RData/MS_acs2015_bw.csv")
#head(trafficstops)
head(MS_bw_pop)

#1.2 Subsetting columns and rows
select(trafficstops, police_department, officer_id, driver_race, limit=5)
select(trafficstops, starts_with("driver"))
filter(trafficstops, county_name == "Tallahatchie County")
slice(trafficstops, 1:3)

#1.3 Pipes (%>%)
#What if you wanted to select and filter at the same time
#Intermedite step
tmp_df <- filter(trafficstops, driver_age < 85)
select(tmp_df, violation_raw, driver_gender, driver_race, driver_age)

#nested
select(filter(trafficstops, driver_age > 85), violation_raw, driver_gender, driver_race)

#Pipe
trafficstops %>% 
  filter(driver_age < 50) %>% 
  select(violation_raw, driver_gender, driver_race, driver_age)

trafficstops %>% 
  filter(county_name == "Tunica County") %>% 
  arrange(driver_age) %>% 
  select(stop_date, driver_age, violation_raw)

#1.4 Add new columns
#We use mutatae() to create new columns based on the values in existing columns
#We use ymd() to convert the date column into a date object 
#use year() to extract the year only.

#add column birth_year
library(lubridate)

trafficstops %>% 
  mutate(birth_year = year(ymd(driver_birthdate)))

#add new column with, round nuumber
trafficstops %>% 
  mutate(birth_year = year(ymd(driver_birthdate)),
         birth_cohort = round(birth_year/10)*10) %>% 
  head()

#created and send it to plot:
trafficstops %>% 
  mutate(birth_year = year(ymd(driver_birthdate)),
         birth_cohort = round(birth_year/10)*10,
         birth_cohort = factor(birth_cohort)) %>%
  select(birth_cohort) %>% 
  plot()

#challenge
trafficstops %>% 
  mutate(Weekday_of_stop = wday(1)) %>% 
  filter(driver_age == 50, driver_gender=="female") %>% 
  select(violation_raw, driver_age, driver_gender) %>% 
  head()

#1.5 What is split-apply-combine?
#The use of group() and summarize()
trafficstops %>%
  group_by(driver_race) %>%
  summarize(mean_age = mean(driver_age, na.rm=TRUE))

#remove NA
trafficstops %>%
  filter(!is.na(driver_race)) %>% 
  group_by(driver_race) %>%
  summarize(mean_age = mean(driver_age, na.rm=TRUE))

#add more grup
trafficstops %>% 
  filter(!is.na(driver_race)) %>% 
  group_by(driver_race, driver_gender) %>%
  summarize(mean_age = mean(driver_age, na.rm=TRUE))

#add more summarize
trafficstops %>% 
  filter(!is.na(driver_race)) %>% 
  group_by(driver_race, driver_gender) %>%
  summarize(mean_age = mean(driver_age, na.rm=TRUE),
            min_age = min(driver_age, na.rm = TRUE),
            max_age = max(driver_age, na.rm = TRUE))

trafficstops %>%
  group_by(officer_id) %>%
  tally()

#1.7 Joining two tables
trafficstops %>%
  left_join(MS_bw_pop, by =  c("county_fips" = "FIPS")) %>% 
  head()
