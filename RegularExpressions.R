## Regular expressions Introduction
# A character vector
sentence <- c('By','the','time','they', 'got', 'back,', 'the', 'lights', 'were', 'all', 'out', 'and', 'everybody', 'was', 'asleep.', 'Everybody,', 'that', 'is,', 'except', 'for', 'Guih', 'Kyom', 'the', 'dung', 'beetle.', 'He', 'was', 'wide', 'awake', 'and', 'on', 'duty,', 'lying', 'on', 'his', 'back', 'with', 'his', 'legs', 'in', 'the', 'air', 'to', 'save', 'the', 'world', 'in', 'case', 'the', 'heavens', 'fell.')
# to find out where the word 'the' is in this vector
grep_out <- grep(pattern = '^the$', x = sentence) #Avoid returning the position of 'they', as it contains 'the' by adding pattern = '^the$' as an anchor
grep_out
#to check that the numbers correspond to the position of every the in our sentence vector.
sentence[grep_out]

#search for world
grep_out_2 <- grep(pattern = '^world$', x = sentence)
grep_out_2
sentence[grep_out_2]

## Regular Expression Tools
grep_out <- grep(pattern = '[A-Z]', x = sentence)
grep_out # search for the elements that contain a capital letter using the pattern '[A-Z]'

grep_out <- grep(pattern = 'a.e', x = sentence)
sentence[grep_out]# search for 'a.e' we are looking for matches where there is an 'a' and an 'e' separated by any character.

grep_out <- grep(pattern = '[a-z]', x = sentence)
grep_out # search for the elements that contain a lowercase letter using the pattern '[A-Z]'


## Quantifiers
#allow the user to specify how many of a character (or set of characters) grep() is matching to

sentence[grep(pattern = 'e.?e', x = sentence)] # This line of code is looking for instances where 'e' is separated by 0 or 1 letters
sentence[grep(pattern = 'e.*e', x = sentence)] # This line of code is looking for instances where 'e' is separated by 0 or more letters
sentence[grep(pattern = 'e.+e', x = sentence)] # This line of code is looking for instances where 'e' is separated by 1 or more letters

## The gsub() Function

#used to search for text by substituting the matched text with text of our choosing

gsub_out <- gsub(pattern = 'a.e', x = sentence, replacement = '!!!')
gsub_out # example the Arundhati Roy quote
# found matches to our pattern ('a.e'), it has replaced them with ‘!!!’
gsub_out <- gsub(pattern = 't', x = sentence, replacement = '?')
gsub_out #  replace all the letter ’t’s with question marks


