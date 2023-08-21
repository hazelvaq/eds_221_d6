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
