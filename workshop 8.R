# Workshop 8 - Data Visualisation I
# example dataset
install.packages("palmerpenguins")
library(palmerpenguins)
library(tidyverse)
str(penguins)# looking at the pengins dataframe
library(ggplot2)

ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g))
# geom - we're using geom point to look at the general correlation
# data- the body mass in grams and the bill length in mm in the peguin dataframe
# Which varibales would we like to map to what aesthetics? species to colour
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g, colour = species))


ggplot(data = penguins,
      mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species, shape = island))


# add additional layers to our plot by specifying additional geoms.
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_smooth(mapping = aes(x = bill_length_mm, y = body_mass_g))

# adding geom smooth

ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point() +
  geom_smooth()

# map species again to colour
ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species)) +
  geom_smooth()

# fix the code above, so that each species has its own fitted curve:
ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g, colour = species)) +
  geom_point(mapping = aes(colour = species)) +
  geom_smooth(se= FALSE) # Gets rid of confidence intervals

# assign it to a variable and add other layers later
pengu_plot <-
  ggplot(data = penguins,
         mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(aes(colour = species))

#We can add layers to our plot
pengu_plot +
  geom_smooth(
    

#bill depth by bill length mapped by island and species
    
pengu_2_plot <-ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = bill_depth_mm, colour = species)) +
      geom_point(mapping = aes(colour = species, shape = island)) +
      geom_smooth(se= FALSE, method = lm) # removed confidence internval and made lines straight

# saving the plot
# ggsave(filename = "penguin_plot_1.png", plot = pengu_plot)



# Or if we don’t pass it a variable it will save the last plot we printed to screen

# pengu_plot +
  # geom_smooth()

# ggsave("penguin_plot_2.png")






#save your latest plot with the linear model lines as a 200mm x 300mm png:
ggsave("penguin_plot_1.png", plot = pengu_2_plot,  width = 200, height = 300, units = "mm")

ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot(mapping = aes(colour = species))

# 4. Continuous versus categorical variables

ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) + 
  geom_boxplot(mapping = aes(fill= species)) # fill colours in the whole plot

head(penguins)
str(penguins)

## alphabetical order- can be annoying
df_days <-
  data.frame(day = c("Mon", "Tues", "Wed", "Thu"),
             counts = c(3, 8, 10, 5))
df_days$day <- as.factor(df_days$day)
str(df_days)

ggplot(data = df_days, mapping = aes(x = day, y = counts)) +
  geom_col()


##fixed

df_days$day <- factor(df_days$day, levels = c("Mon", "Tues", "Wed", "Thu"))
str(df_days)

ggplot(data = df_days, mapping = aes(x = day, y = counts)) +
  geom_col()


#make violin plot

ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) + 
  geom_violin(mapping = aes(fill= species)) # fill colours in the whole plot


penguins$species <- factor(penguins$species, levels = c("Chinstrap", "Gentoo", "Adelie"))

plot_2 <- ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) + 
  geom_violin(mapping = aes(fill= island))


ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) +
  coord_flip()


### 6. Plotting only a subset of your data: filter()


# Mixing those up is quite a common error %>% and +

penguins %>% filter(!species == "Chinstrap") %>%
  ggplot(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species, shape = island))


penguins$species <- factor(penguins$species, levels = c("Adelie", "Chinstrap", "Gentoo"))

penguins %>% filter(!is.na(sex)) %>% 
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(mapping = aes(fill= sex))


# 7. Labels ---------------------------------------------------------------

penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       fill = "Sex",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  )



penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  ) +
  scale_fill_discrete(name = "Sex", # the legend title can be changed here or in labs()
                      labels = c("Female", "Male", "Unknown"),
                      type = c("yellow3", "magenta4", "grey"))


# Generate a new plot from the penguin data with at least two geoms, good labels, and maybe 
# even try out some colours



penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  ) +
  scale_fill_discrete(name = "Sex", # the legend title can be changed here or in labs()
                      labels = c("Female", "Male", "Unknown"),
                      type = c("yellow3", "magenta4", "grey"))
penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  ) +
  scale_fill_discrete(name = "Sex", # the legend title can be changed here or in labs()
                      labels = c("Female", "Male", "Unknown"),
                      type = c("yellow3", "magenta4", "grey"))


