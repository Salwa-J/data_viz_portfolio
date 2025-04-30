library(tidyverse)
library(RColorBrewer)
library(patchwork)

measles <- read.table("measles_cases_clean.txt", header = T, sep = "\t")
vacc_rates <- read.table("measles_vaccination_clean.txt", header = T, sep = "\t")

#Have a look at the two dataframes. What are the variables? 
#Which years are covered? You may have to google what some of the variables mean.

#Let’s start exploring the data. How have cases developed over the years in the United Kingdom?
UK_cases <- measles %>% filter(entity == "United Kingdom") %>% 
  ggplot(aes(x = year, y = cases) ) +
  geom_point() +
  geom_line()+
  labs(title= "Measles cases in the UK since 1980")

# Log scales

UK_cases_log <- measles %>% filter(entity == "United Kingdom") %>% 
  ggplot(aes(x = year, y = cases) ) +
  scale_y_continuous(trans = 'log10')+
  geom_point() +
  geom_line()+
  labs(title= "Measles cases in the UK since 1980")



# Breaks ------------------------------------------------------------------

UK_cases_breaks<- measles %>% filter(entity == "United Kingdom") %>% 
  ggplot(aes(x = year, y = cases) ) +
  scale_y_continuous(trans = 'log10', breaks= c(10, 100, 1000, 10000, 100000), labels = c("10", "100", "1,000", "10,000", "100,000"))+
  geom_point() +
  geom_line()+
  labs(title= "Measles cases in the UK since 1980")


#  vaccination data for the United Kingdom and the correct coverag --------

UK_vacc_cov <- vacc_rates %>% filter(entity == "United Kingdom", coverage_category == "WUENIC" ) %>% 
  ggplot(aes(x = year, y = coverage, fill = antigen) ) +
  geom_point(aes(colour = antigen)) +
  geom_line(aes(colour = antigen))+
  labs(title= "Vaccine rates dropped sharpy from 1998 onwards but recovered later.") # dropped due to andrew wakefield


#first vaccines for (coverage_category == “WUENIC”) then add the second


# Cases by continent ------------------------------------------------------

# 3. Summary Tables -------------------------------------------------------

measles %>%
  group_by(year)

# Group by the year and sum up the cases as follows:

world_cases <- measles %>%
  drop_na() %>% 
  group_by(year) %>% 
  summarise(total = sum(cases))


world_cases_plot <- world_cases %>% 
  ggplot(aes(x = year, y = total) ) +
  geom_col()


measles %>%
  group_by(year, continent)

continent_cases <- measles %>%
  drop_na() %>% 
  group_by(year, continent) %>% 
  summarise(total = sum(cases))

continent_cases_plot <- continent_cases %>% 
  ggplot(aes(x = year, y = total, fill = continent) ) +
  geom_col()

# africa is the main driver- Heatmaps are an excellent way to look at the interaction of three variables

# 4. Heatmaps -------------------------------------------------------------

Africa_heatmap<- measles %>% filter(continent == "Africa") %>% 
  ggplot(aes(x = year, y = entity, fill= cases) ) +
  geom_raster()
  

# 5. Finding a Story to Tell ----------------------------------------------

# Pull out countries with the ten highest case numbers in 2019

high_countries <- measles %>% filter(!is.na(cases) & year == 2019 ) %>% 
  arrange(cases) %>% 
  tail(n = 10L) %>% 
  pull(entity)

# Make data subset of the ten countries with the most cases in 2019
high_measles_2019 <- measles %>% filter(entity %in% high_countries)

# Make countries a factor in order of cases, highest first
high_measles_2019$entity <- factor(high_measles_2019$entity, levels = rev(high_countries))


# visualizing these countries with overall cases:
overall_cases<- measles %>% filter(!is.na(cases),  year > 2009) %>% 
  ggplot(aes(x=year, y = cases)) +
  geom_col(fill = "lightgrey") +
  geom_col(data = filter(high_measles_2019, !is.na(cases), year >2009),
           aes(fill = entity))


WHO_REGIONS<- vacc_rates %>% filter(coverage_category == "WUENIC", group == "WHO_REGIONS") %>% 
  ggplot(aes(x = year, y = coverage, colour = antigen)) +
  geom_point() +
  geom_line()+
  facet_wrap(~entity, ncol = 3, dir = "h")



#  compare DRC and Madagascar with the African and European Region --------

Compare_Plots<- vacc_rates %>% filter(coverage_category == "WUENIC", entity %in% c("African Region", "Democratic Republic of Congo", "European Region", "Madagascar")) %>% 
  ggplot(aes(x = year, y = coverage, colour = antigen)) +
  geom_point() +
  geom_line()+
  facet_wrap(~entity, nrow = 2, dir = "h")
# if you have a vector of names it has to be %in% not =


# 6. The big challenge ----------------------------------------------------

DRC_Plots<- vacc_rates %>% filter(coverage_category == "WUENIC", entity %in% c("African Region", "Democratic Republic of Congo")) %>% 
  ggplot(aes(x = year, y = coverage, colour = antigen)) +
  geom_point() +
  geom_line()+
  facet_wrap(~entity, ncol = 2, dir = "h")





Africa_cases<- measles %>% filter(!is.na(cases), continent == "Africa") %>% 
  ggplot(aes(x=year, y = cases)) +
  geom_col(fill = "lightgrey") +
  geom_col(data = filter(high_measles_2019, !is.na(cases), continent == "Africa"),
           aes(fill = entity))


DRC_Plots/Africa_cases