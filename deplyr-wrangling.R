#------ Section 1:Filter -------------
# filter to keep or exclude based on whether or not they satufy conditions I specify
# Creat a subset that only contains blue whales longer then 12 meters

library(tidyverse)
library(palmerpenguins)
library(lterdatasampler)

# Look for an exact match

penguins_biscoe <- penguins %>% filter(island == "Biscoe")

##Another example
penguins_2007 <- penguins %>% filter(year == 2007)

## Species is Adeli and island torgesen

adelie_torgersen <- penguins %>% filter(species == "Adelie" & island = "Torgersen")
# Alternative penguins %>% filter(species == "Adelie",island == "Torgesersen) here the comma has the same affect as &

## Create a subset from penguins that only contains Gentoo penguins observed in 2008

gentoo_2008 <- penguins %>% filter(species =="Gentoo",year == 2008)

# Create a subset that contains Gentoos and Adelies

gentoo_adelia <- penguins %>% filter(species == "Gentoo"|species == "Adelie")

# Create a subset where the island is Dream OR the year is 2009

dream_or_2009 <- penguins %>% filter(island == "Dream"| year == 2009)

## Make a ggplot chart of water temperature versus crab size:
ggplot(pie_crab,aes(x = water_temp, y = size)) + geom_point()

unique(pie_crab$site)

#Keep observations for sites NIB, ZI, DB, JC
# pie_crab %>% fikter(site == "NIB"|site == "ZI"|site == "DB"|site =="JC")
# We can use the %in% operator to ask: does the value in our column match ANY of the values IN this vector

pie_sites <- pie_crab %>% filter(site %in% c("NIB","ZI","DB","JC"))
unique(pie_sites$site)

## Setting a vector outside and use it with filter

sites <- c("CC","BB","PIE")
pie_crab %>% filter(site %in% sites)

## %in% operator order does not matter versus == thats looking for a vector
## == looks at the vector elements in order so Row 1: does it match CC Row 2: does it match BB, ROW 3: does it match PIE then it repeats in that order

## Create a subset using the %in% operator that includes sites PIE, ZI, NIB, BB, and CC

pie_crab %>% filter(site %in% c("PIE","ZI","NIB","BB","CC"))

## Excluding filter statements
# != not equal operator (single condition)

exclude_zi<- pie_crab %>% filter(site != "ZI")

#What if I want to exclude sites "BB", "CC", "PIE"

exclude_bb_cc_pie <- pie_crab %>% filter(!site %in% c("BB","CC","PIE"))

# Create a subset from pie_crab that only contains observations from sites "NIB", "CC","ZI" for crabs with carapace size exceeding 13

sites_size <- pie_crab %>% filter(site %in% c("NIB", "CC","ZI") & size > 13)


## Select and exclude columns by using select()

#---------------Selecting columns-------------#

# Select individual columns by name, separate them by a comma
crabs_subset <- pie_crab %>% select(latitude, size, water_temp)

## This gives me the column names
names(crabs_subset)

## Select a range of columns
crabs_subset2 <- pie_crab %>% select(site:air_temp)
#Use them in combination select a range and an individual column

crabs_subset3 <- pie_crab %>% select(date:water_temp,name)

# Reorder things
pie_crab %>% select(name,water_temp,size)

#--------Mutate------------#
#Use dplyr::mutate() to add or update a column, while keeping all existing columns

crabs_cm <- pie_crab %>%
  mutate(size_cm = size /10)

# What happens if I use mutate to add a new column containing the mean of the size column?

crabs_mean <- pie_crab %>%
  mutate(mean_size = mean(size, na.rm = TRUE))

# This overwrites a column that says AWESOME but instead just make a new column a much safer approach
crabs_awesome <- pie_crab %>%
  mutate(name = "Teddy is awesome")

## Reminder of group by and summarize
mean_size_by_site <- pie_crab %>%
  group_by(site) %>%
  summarize(mean_size = mean(size,na.rm=TRUE),
            sd_size = sd(size,na.rm = TRUE))

# Group by then mutate

group_mutate <- pie_crab %>%
  group_by(site) %>%
  mutate(mean_size = mean(size,na.rm = TRUE))

## Multiple group by

penguins %>%
  group_by(species,island, year) %>%
  summarize(mean_body_mass = mean(body_mass_g,na.rm =TRUE))

#What if I want to create a new column in pie_cra that contains "giant" if the size is greater than 35, or "not giant" if the size is less than or equal to 35?

#Use dplyr::case_when() to write if_else statement more easily

crabs_bin <- pie_crab %>%
  mutate(size_binned = case_when(
    size > 20  ~ "giant",
    size <= 20 ~ "not giant"
  ))

## Match by string
# TRUE ~ : then if anything else is true have it say "HIGH"

sites_binned <- pie_crab %>%
  mutate(region = case_when(
    site %in% c("ZI","CC","PIE") ~ "Low",
    site %in% c("BB","NIB") ~ "Middle",
    TRUE ~ "HIGH"
  ))

#.default = here to set the default to something
