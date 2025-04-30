# 1 Introduction
# The basic structure of tidy data is the table. The three basic rules for tidy data are as follows:
  
#1. Each row is an observation
#2. Each column is a variable
#3. Each value has its own cell 

beetles1 <- read.csv("beetles_v1.csv")
beetles1 # species is a variable so should be ina acolumn
# taking a look at data in differnet ways without any changes
# counts dont have their own row becuse sepecies are not a column
#count is the observation so should be in rows

beetles2 <- read.csv("beetles_v2.csv")
beetles2 # month should be in a column not a row as its a variable
beetles3 <- read.csv("beetles_v3.csv")
beetles3 # sites sould not be a row

beetles4 <- read.csv("beetles_v4.csv")
beetles4

# Q: Which of the three rules does each table fail?


#Q: Which of these tables is most ‘tidy’?
# fourth is rthe bst but in species could be simplified into red blue pink and a genus column could be picked

# 2.1 Who cares? ‘beetles1’ was totally fine:

# unique function brings out the things that are mentioned, one time

#Select the ‘Site’ column from beetles1, pass it to the ‘unique’ function to get all the unique values, and count the length of the vector
usites <- unique(beetles1$Site)

length(usites)

#counting the number of species from ‘beetles1’?
colnames(beetles1)[3:ncol(beetles1)]

# Use the ‘unique’ and ‘length’ functions to count the number of species using ‘beetles3’: how many beetle species are there?
  
spps_num_3 <- unique(beetles3$spp)
length(spps_num_3)

# Which ‘beetles’ table lets you count all unique values for Sites, Months and Species? beetles 4
unique_all <- unique(beetles4) # add site or month or species
length(unique_all)

#3 Overviews of datasets

str() #structure
summary()# summary statistics
head()# first 6 lines
View() # shows you the data set # <-- this one is in Rstudio only


str(beetles4) 
summary(beetles4)
head(beetles4)
View(beetles4)   # <-- this one is in Rstudio only

#Each has advantages and disadvantages; what are they?
# str() gives you the structure and shows us the class of the data, the variables and observations. It provides limited information
# summary gives us the summary statistics- may not be the summary statistics - quantitative values
# head() only gives us a short section of data- but may not be enough



# 4 Reading tables --------------------------------------------------------


#read in a larger table. 
beetlesdf <- read.table("beetles_read_1.csv", sep=",",header=T)  # notice how we set the separator
#Notice how we had to set the separator and tell read.table that this file has a header. These were set by default in ‘read.csv’.

# ‘read.table’ is a bit more complex, but a lot more flexible. Changing the default arguments lets us read in files in many different formats.

# These two files will not read in with default settings

Beetles2_table<- read.table("beetles_read_2.txt",sep="\t",header=T )#\t is separated by a tab aka a space (forward slash). Header= true

Beetles2_table

Beetles3_table<-read.table("beetles_read_3.txt" ,sep="\t",header=T, skip = 1) # skipping the first row


Beetles3_table


# 5 Fill ------------------------------------------------------------------

library(tidyr)

# ?fill Fills missing values in selected columns using the next or previous entry

fill(beetlesdf,Site)  
beetlesdf <- fill(beetlesdf,Site)  #careful - this is a common source of errors
beetlesdf# fill filled the gaps 

beetlesdf2 <- read.table("beetles_read_4.txt", sep="\t",header=T, na.strings = "-") # The argument na. strings (highlighted above) is where you can specify a character vector of stings you want R to interpret as missing values.

fill(beetlesdf2,Site)# fill, fills the gaps in this case the dashes with the next and previous number


# 6 The Pipe --------------------------------------------------------------

# Where we have more than one function applied to a table, R has a way to take the output of one function, and shove it straight into the next. This is called piping.

beetlesdf <- read.table("beetles_read_1.csv", sep=",",header=T) %>% fill(Site) # pipe is ctrl shift m
# directly after reading the table it fills the site column


# 7 Pivoting --------------------------------------------------------------

# As we saw in section 2, the beetles data set has one of the common problems in untidy data: column headers are values, not variable names. tidyr has more functions designed to deal with this issue. Welcome to pivoting.

pivot_longer(data=beetlesdf, cols = c("blue_beetle", "green_beetle", "purple_beetle", "red_beetle", "brown_beetle", "black_beetle", "orange_beetle", "white_beetle"),names_to="species")# made a column called species with all of the species under it


# Perform this same pivot, but select columns using their numerical index

pivot_longer(data=beetlesdf, cols = c(3:length(beetlesdf)),names_to="species")

test_blue <- pivot_longer(data=beetlesdf, cols = contains("blue") ) # dataframe doesn't look good 

# look through the possible ways of selecting columns, can you find a selection helper that selects all your values?
# use contains or matches beetles
all_values <- pivot_longer(data=beetlesdf, cols = contains("beetle") )

# Using the help page for pivot_longer, figure out how to change ‘value’ to ‘count’
count_values <- pivot_longer(data=beetlesdf,cols = contains("beetle"), values_to = "count") 
count_values


# 7.2 pivot_wider ---------------------------------------------------------

# What about the opposite problem? where multiple variables are stored in one column.

casesdf <- read.table("WMR2022_reported_cases_1.txt",sep="\t", header = T, na.strings = "") %>%
  fill(country)
  
casesdf


# Here each row isn’t a single observation - instead each country is one observation, and the different numbers of suspected / examined / confirmed cases are variables of that observation. So we want to take values from the ‘method’ column, and spread them out as individual columns: the number of columns this makes will depend on the number of unique values in ‘method’.
pivot_wider(casesdf,names_from="method",values_from ="n")


sessionInfo()# saving session output

