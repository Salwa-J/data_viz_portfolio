## The Challenge
# look at the structure of the dataset. What sort of dataset do you think this is
str(dung_beetles_v2)
class(dung_beetles_v2) # data frame with each column as a variable and each row is an observation
# species and sites numeric and months are characters
vector_dungbeetles <- colnames(dung_beetles_v2) #create vector
# Make a new object that is a vector of all the species names
Vector_beetle_names <-vector_dungbeetles[3:length(vector_dungbeetles)] ## specified that we want the vector to include column names from the third column onwards.
Vector_beetle_names

# Using grep() prowess to find the names of all the species that have a genus name that starts with the letter ‘C’
grep_out <- grep(pattern = '[//^C]', x =Vector_beetle_names)
grep_out 
Vector_beetle_names[grep_out]

# 4. Find all the species where the specific epithet (the second word) starts with the letter ‘r’.
grep_out <- grep(pattern = '_r', x =Vector_beetle_names)
grep_out 
Vector_beetle_names[grep_out]

# 5. There is a typo in the species names! Replace all the ‘Copis’ genus names with the correct ‘Copris’ spelling
gsub_out <- gsub(pattern = 'Copis', x = Vector_beetle_names, replacement = 'Copris')
gsub_out

#6. Another genus name has been misspelled - ‘Microcopis’ should be ‘Microcopris’. Fix this too.
gsub_out <- gsub(pattern = 'Microcopis', x = Vector_beetle_names, replacement = 'Microcopris')
gsub_out

#8. Now create a new gsub() command that replaces the one you used in question 5 and 6, so that it is flexible enough to fix both genus names in one go! 
gsub_out <- gsub(pattern = 'opis', x = Vector_beetle_names, replacement = 'opris')
gsub_out

#9. Replace the column names in your data set with your corrected ones.
colnames(dung_beetles_v2)[3:68]<- gsub_out # applying gsub to columns 3-68

#10. Find all the species where the genus starts with an ‘O’ and the specific epithet ends in an ‘s’

# grep_out <- grep(x = cols, pattern = ‘^O.*s$’)

# cols[grep_out]

# 11. Subset the dataframe using regular expressions so that it only contains data from months ending in a ‘y’ and genera starting with an ‘O’.

subset <- dung_beetles_v2[grep(pattern = 'y$', x = dung_beetles_v2$Month), c(1,2,grep(pattern = '^O', names(dung_beetles_v2)))]
subset

#added a vector within to not remove the months
#use names as we dont want column content
myvector <- c(3,5,6,7)


