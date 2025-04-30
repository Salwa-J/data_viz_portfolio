# be semi explicit- the second option
# have clear spacing
# crtl+shift+A to do your formatting

# Annotating data points:

library(palmerpenguins)
library(tidyverse)
library(dplyr)
# Subset penguins dataframe to the the five heaviest penguins
big_penguins <- penguins %>%
  filter(species == "Gentoo",!is.na(body_mass_g)) %>% # that don't have na's
  arrange(body_mass_g) %>% tail(n = 5L)# arrange in order of body mass from small to large
#tail is giving us the 5 last ones- which are the largest based on the arrangement

# Add a column with names to big_penguins
big_penguins$names <- c("Dwayne", "Hulk", "Giant", "Gwendoline", "Usain")

# Plot all Gentoo penguins and use big_penguins dataframe for labels
penguins %>% filter(species == "Gentoo") %>% 
  ggplot(aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(colour = flipper_length_mm)) +
  geom_text(
    data = big_penguins,
    mapping = aes(label = names),
    nudge_x = -1.5,#pushing the labels away from the point- stopping the text being on the point eg(+2 will move the labels above the point)
    nudge_y = -0.5,
    colour = "red"
  ) +
  xlim(3900, 6400) # limits of the x axis

#I want to highlight the home islands of Adelie penguins with flipper lengths over 200 mm:
penguins %>% filter(species == "Adelie") %>%
  ggplot(aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point() +
  geom_text(
    data = filter(penguins, species == "Adelie" &
                    flipper_length_mm > 200),
    aes(label = island),
    nudge_y = -0.7
  )
# Why do we have to filter for the species again in geom_text()? What happens if we don’t do that?

#3. Facets

# Reading in data
modeltab <- read.table("wmr_modelling.txt",sep="\t",header=T)

# Subsetting to the first half or so for readability
modeltab_short <- head(modeltab, n = 506L)

# Plotting deaths in years 2019-2021 faceted by country
modeltab_short %>% drop_na() %>% filter(year >2018) %>%
  ggplot(aes(x = year, y = deaths)) +
  geom_col(fill = "firebrick") +
  facet_wrap(~country, ncol = 5,scales = "free",dir = "v") # ~ determines the variable by which we want to split our data into separate plots
# Facet_wrap- wraps a 1d sequence of panels into 2d
# If TRUE, the default, the facets are laid out like a table with highest values at the bottom-right. If FALSE, the facets are laid out like a plot with the highest value at the top-right



#second faceting type lays out the plots in a 2D grid. This is often used to separate plots by two categorical variables like so:
penguins %>% drop_na() %>% ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  
  
# The formula in facet_grid() determines first the rows, then the columns. You can also use this to control how you want plots laid out that are separated by just one variable:
p_plot <- penguins %>% drop_na() %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point()


p_plot + facet_grid(. ~ species)
  facet_grid(sex ~ species)
  
  
p_plot + facet_grid(species ~ .)

#4. Patchwork

install.packages("patchwork")
library(patchwork)

p1 <- penguins %>% drop_na() %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm, colour = species)) +
  geom_point() + facet_grid(. ~ species)

p2 <- penguins %>%  drop_na() %>%
  ggplot(aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), position = "identity")

p3 <- penguins %>% drop_na() %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex))  

#Patchwork stitches these plot together using an intuitive formula approach:
p1/(p2+p3) 


#We can also say that we want only one plot on the left, and the other two stacked on the right:
p2 | (p1/p3)


# Patchwork allows you to add annotations using the plot_annotation() function:
p1/(p2+p3) + plot_annotation(tag_levels = "a",
                             title = "Plenty of penguin plots")

# Patchwork is very useful when we want to align plots with the same x- or y-axis:

p_deaths <- modeltab %>% filter(country %in% c("Angola", "Burkina Faso", "Chad")) %>% 
  ggplot(aes(x = year, y = deaths, colour = country)) +
  geom_point() +
  geom_line() +
  xlim(1999,2022)

p_pop <- modeltab %>% filter(country %in% c("Angola", "Burkina Faso", "Chad")) %>% 
  ggplot(aes(x = year, y = population, fill = country)) +
  geom_col(position = "dodge") +
  xlim(1999,2022)

p_deaths/p_pop
#p_deaths <- modeltab %>% filter(country %in% c("Angola", "Burkina Faso", "Chad")) %>% 
ggplot(aes(x = year, y = deaths, colour = country)) +
  geom_point() +
  geom_line() +
  xlim(1999,2022)

p_pop <- modeltab %>% filter(country %in% c("Angola", "Burkina Faso", "Chad")) %>% 
  ggplot(aes(x = year, y = population, fill = country)) +
  geom_col(position = "dodge") +
  xlim(1999,2022)

p_deaths/p_pop


# 5. Colours --------------------------------------------------------------

## Discrete colour scales


## Here is an example of how to change discrete colours manually:

s_counts <- penguins %>% ggplot(aes(x = species, fill = species)) +
  geom_bar()

s_counts + scale_fill_manual(values = c("yellow2", "magenta", "darkblue"))


install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()


# We can apply ColorBrewer palettes like this:
brew_1 <- s_counts + scale_fill_brewer(palette = "Set1")
brew_2 <- s_counts + scale_fill_brewer(palette = "Dark2", direction = -1)

brew_1 + brew_2


viri_1 <- s_counts + scale_fill_viridis_d() #Uses default option viridis
viri_2 <- s_counts + scale_fill_viridis_d(option = "plasma")

viri_1 + viri_2

# Continuous colour scales

con_plot_1 <- penguins %>% drop_na() %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point(aes(size = body_mass_g, colour = body_mass_g))

con_plot_2 <- con_plot_1 + scale_colour_viridis_c(option = "magma")

con_plot_1 + con_plot_2

# NA values
penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  scale_fill_brewer(palette = "Set2", na.value = "yellow2")

## 6. Themes

# We can simply change from the default to another one like so:
con_plot_3 <- con_plot_1 + theme_classic()

con_plot_1 + con_plot_3 + plot_annotation(title = "Default theme on the left, theme_classic() on the right")


# to remove an element entirely we use the function element_blank()

penguins %>% drop_na() %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point(aes(colour = body_mass_g)) +
  labs(title = "My pretty plot") +
  scale_colour_viridis_c(option = "magma") +
  theme(legend.position = "bottom",
        axis.title.x = element_text(colour = "red", size = 14, hjust = 1),
        axis.title.y = element_blank(),
        axis.line.y = element_line(colour = "cornflowerblue", linewidth = 4),
        axis.text.y = element_text(size = 20, angle = 45),
        panel.background = element_rect(colour = "green", fill = "yellow", linewidth = 10),
        plot.title = element_text(face = "italic",  hjust = 0.5, size = 18))

penguins %>%  drop_na() %>%
  ggplot(aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), position = "identity") +
  theme(legend.position = "inside",
        legend.position.inside = c(0.9,0.85),
        legend.background = element_blank())


# Exercises ---------------------------------------------------------------


#1. Labels: Produce the following plot. Plotted here are only the penguins resident on the island Biscoe.


penguins %>% filter(island == "Biscoe") %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point(aes(colour = species))+
  geom_text(
    data = filter(penguins, island == "Biscoe"& (bill_length_mm > 53| bill_depth_mm > 20)), # only labelling these
                  aes(label = sex))+
    labs(title = "Penguins on the island Biscoe") 
      
    
# 2. facets- produce a plot
wmr_data <- read.table("wmr_cases_deaths_modelling_summaries.txt", sep="\t",header=T)


wmr_data %>% filter(!region =="Total") %>%
  ggplot(aes(x = year, y = deaths)) +
  geom_col(fill = "darkblue") +
  facet_wrap(~region, ncol = 3, dir = "h",
             scales = "free") ## free tp specify that the sacles should adjusrt


## 3. Patchwork: Using the datasets in wmr_modelling.txt and wmr_cases_deaths_modelling_summaries.txt produce a publication-style figure. It should contain at least three plots, one with faceting, arranged with patchwork.

library(patchwork)
# first graph africa number of deaths per year


p1 <- wmr_data %>%
  ggplot(aes(x = year, y = deaths)) +
  geom_point() + facet_grid(. ~ species)
## deaths by year for the world


africa_deaths <- wmr_data %>% filter(region == "Africa") %>% 
  ggplot(aes(x = year, y = deaths) ) +
  geom_point() +
  geom_line()+
  labs(title= "Malaria related deaths in Africa")

  



country_deaths<- modeltab %>% filter(country %in% c("Burundi", "Gabon", "Senegal")) %>% 
  ggplot(aes(x = year, y = deaths, fill = country)) +
  geom_col(position = "dodge") 
  
africa_deaths/country_deaths

country_deaths <- modeltab %>% filter(country == country) %>% 
  ggplot(aes(x = year, y = deaths, fill = country)) +
  geom_point()
 

p_deaths/p_pop