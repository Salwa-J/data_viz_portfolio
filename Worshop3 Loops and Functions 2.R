# 1) Try copying the code into a new script and move the print(x) command into the loop. What do you see?


x <- 0            # make a new scalar called x with a value of 0

for (i in 1:10) { # create a for loop that runs 10 times (1 to 10)
  x <- x + i      # within our for loop we are adding the value of i to the value of x
  print(x)   
  }

#2) Try changing the numbers in the for() function (1:10) to numbers of your choosing multiple times. What do you see?


x <- 0            # make a new scalar called x with a value of 0

for (i in 3:6) { # create a for loop that runs 10 times (1 to 10)
  x <- x + i      # within our for loop we are adding the value of i to the value of x
  
}

print(x)   

# 3) Try changing the the name of i in the for() function to a name of your choosing and get the loop to run.

x <- 0            # make a new scalar called x with a value of 0

for (j in 1:10) { # create a for loop that runs 10 times (1 to 10)
  x <- x + j      # within our for loop we are adding the value of i to the value of x
  
}

print(x)   

# 4) Make a for loop that loops over the numbers 10 to 20, and prints the square of each.

      

for (i in 10:20) {
  square <-   i^2       
  print(square) }

# don't need a scalar for x here because we don't need a value to add something to

##  2.4. Looping over non-integer vectors

# loops will take vectors of any class

shrek_quote <- c('What', 'are', 'you', 'doing', 'in', 'my', 'swamp')
for (word in shrek_quote) {
  print(toupper(word))  # for i in the vector shrek quote print the words in uppercase
} 
# iterator is now word, rather than the usual i
# toupper convert upper-case characters in a character vector to lower-case, or vice versa


for (donkey in 1:length(shrek_quote)) {
  print(toupper(shrek_quote[donkey]))  
}

# In the above for loop what is the function of each of the following parts: (a) donkey (b) toupper() (c) 1:length() (d) shrek_quote (e) shrek_quote[donkey]?

# (a) the donkey acts as the iterator (technical term for loop). it symbolizes the contents of the vector
# (b) toupper() is a function that Translate characters in character vectors, in particular from upper to lower case or vice versa.
# (c) 1:length() start to end of the vector
# (d) shrek_quote is the name of the vector
# (e) shrek_quote[donkey] is going through each word in the vector Shrek quote- printing as uppercase


## 3. Saving outputs
#using an output vector to save the output
output <- vector() # creates an empty vector that we can fill with values called output
input <- c('red', 'yellow', 'green', 'blue', 'purple') # create and populate vector with colours
for (i in 1:length(input)) {  # create loop that runs from the beginning to the end of the vector called input
  output[i] <- nchar(input[i]) # saving as ouput of the loop- the number of letters in each word in the input vector. this gives us a number for each word corresponding to the number of letters
}
print(output)

#What does the nchar() function do?
## nchar is a function that takes the character vector (eg input) as an argument and returns vector containing a number that corresponds to the length of the word (character)

fruit_chars <- vector()
Fruits <- c('apple', 'tangerine', 'kiwi', 'banana')
for (i in 1:length(Fruits)) { # iterate in fruit vector
  fruit_chars[i] <- paste(Fruits[i], "_", nchar(Fruits[i]))# within the paste function i specified that we wanted to include the names in the vector fruit from beginning to end using [i].
}# loop hat takes a vector named fruits, adds an underscore and the number of characters to each of them, and saves them as a new vector called fruit_chars
print(fruit_chars)

## 4. Conditional statements

#They allow you to evaluate whether certain conditions are true or not  and carry out tasks based on the outcome of that statement.
#Creating conditional statements always starts with if(). This function gets R to run certain code only if a statement within the if() is TRUE. Take the following example:
numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)# creating vector
for(i in numbers){ # i is the iterator 
  if(i > 5){ # this is the conditional- if i is larger than 5 print the value in the vector - so -20.5, 1 and 4 are not printed
    print(i)
  }
} 

# when i > 5 == TRUE! the loop runs print(i) following th eif statement

#Any logical expression (remember these from Week 1?) can be used to create an if statement in this way.

numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)# creating vector
for(i in numbers){
  if(i < 5 & i %% 1 == 0){ # if i is less than 5 and i is the remainder when divided by 1 is zero (whole number).
    print(paste(i, ' is less than five and an integer.', sep = '')) # if the condition if fulfilled print the statement
  }
}

# How does the conditional statement in the above code work?
# %% 1 == 0  if the remainder of the division is 0 than the number is a whole number . the statemnt will be printed. %% is the remainder e.g, 5/2 the remainder is 1 as 2 goes into 5 only 2 times without a remainder.

# What does the paste() function do in the above code? Takes multiple elements from the multiple vectors and links them into a single element

# Create your own if statement inside a loop over the numeric vector nums below. Be creative with what your conditional statement is, but make sure you have an appropriate print output like the example above!
nums <- c(11, 22, 33, -0.01, 25, 100000, 7.2, 0.3, -2000, 20, 17, -11, 0)

for(i in nums){
  if(i < 40 & i %% 11 == 0){ # %% to find multiples of 11 (==0 means that it goes into 11 with no remainder)
    print(paste(i, ' is less than forty and a multiple of 11.', sep = ''))
  }
}
# %% operator returns the modulus (remainder) of a division operation. For instance, 5 %% 2 would return 1,  as the remainder of 5 divided by 2 is 1. 

## 4.2. Using else

numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
for(i in numbers){
  if(i < 5 & i %% 1 == 0){
    print(paste(i, ' is less than five and an integer.', sep = ''))
  } else {
    print(paste(i, ' is not less than five or is not an integer (or both!).', sep = ''))
  } # dd a layer of complexity to our conditional statements by also defining what code to run if the conditional is FALSE by using else{}.
}


# Update your for loop with an if() statement to also contain an else statement (of your choice again!).

for(i in nums) {
  if(i < 40 & i %% 11 == 0){ 
    print(paste(i, ' is less than forty and a multiple of 11.', sep = ''))
  } else {
  print(paste(i,'is less than forty and a multiple of 11 (or both!).', sep = ''))
}
}

## 4.3. Using else if()

#The difference between else and else if is that else doesn't need a condition as it is the default for everything where as else if is still an if so it needs a condition

numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
for(i in numbers){
  if(i < 5 & i %% 1 == 0){
    print(paste(i, ' is less than five and an integer.', sep = ''))
  } else if(i < 5 & i %% 1 != 0){
    print(paste(i, ' is not an integer.', sep = ''))
  } else if(i >= 5 & i %% 1 == 0){
    print(paste(i, ' is not less than five.', sep = ''))
  } else {
    print(paste(i, ' is not less than five and is not an integer.', sep = ''))
  }
}

# update the loop you made for the previous sections (on else statements) so that it also contains at least one else if() statement.
nums <- c(11, 22, 33, -0.01, 25, 100000, 7.2, 0.3, -2000, 20, 17, -11, 0)

for(i in nums) {
  if(i < 40 & i %% 11 == 0){ 
    print(paste(i, ' is less than forty and a multiple of 11.', sep = ''))
  } else if(i < 40&i %% 11 !=0){
    print(paste(i, 'is less than forty and not a multiple of 11.'))
  } else {
    print(paste(i,'is less than forty and a multiple of 11 (or both!).', sep = '')) 
  }}


## 5. While loops

x <- 0
while(x < 5){
  x <- x + 1
  print(paste('The number is now ', x, sep = ''))
}
# nstead of giving loops an object to iterate over (usually a vector), while loops will instead take a conditional statement. They continue to loop over the statement while the statement is TRUE
#   Why does the code stop running after 5 iterations? because after 5 loops the consitions are no longer true
#  Why does x reach a value of 5 and not 4? because in the 5th iteration x is 4 and 1 is added to it



## we want to create a loop that finds the lowest number that is a factor of 5, 6, 7 and 8
x <- 1
while(x %% 5 != 0 | x %% 6 != 0 | x %% 7 != 0 | x %% 8 != 0){
  x <- x + 1
}
print(paste('The lowest number that is a factor of 5, 6, 7 and 8 is ', x, sep = ''))

## the loops keeps going until we reach a number that is divisible by 5, 6, 7 and 8


# the loops keeps adding 1 to x until x is number that is divisible by 5,6,7 and 8.

# What does the logical statement x %% 5 != 0 check in the above code? it checks if the remainderof x/5 is not = to zero
# Why does the code not work if x starts as 0? because you can't divide 5 by zero

# While loops can run forever if they are poorly specified. Take for example the following while loop:
x <- 1
while(x < 10){
  x <- x - 1
}

# this does'nt work as it would run  indefinitely because its always minus 1


x <- 0.999
while(x>=0.5){# once x is greater than 0.5 is false the loop will stop- which means that x is less than 0.5
  x <- x^2
  print(x)
}
print(paste('x is less than 0.5', x, sep = ''))


## 6. Functions

powers <- function(x){# define function name as powers
  y <- x ^ 2# the inputs of the function (in this case x),
  return(y)  # this function is squaring x
}# define an output using the return() functio
powers(1)

powers(30)
powers(5189)

  
powers <- function(x){# defining the name of the function as powers and defines the input for this function as x
  y <- x ^ 2# y is x squared
  z <- x ^ 3 # z is x cubed
  return(c( y, z))# return the values for x squared followed by x cubed
}
powers(1)
powers(30)
powers(5189)

## 6.2. Default inputs
# This means that the function will assume that an input is the default, unless stated otherwise

powers <- function(x, y = 2){
  z <- x ^ y
  return(z)
}
powers(3)# y has the default value of 2 (as we did not specify a value of y when we used the function), and so returns 3 ^ 2 which is 9

powers(3, 3)# In the first use of the powers() function, y has the default value of 2 (as we did not specify a value of y when we used the function), and so returns 3 ^ 2 which is 9. In the second use, we define y as 3 and so the function returns 3 ^ 3 which is 27. Note that writing out powers(x = 3, y = 3) or even powers(y = 3, x = 3) would return the same result.


# Write a function that takes a character scalar (e.g. 'Bird') and returns a character scalar that appends is the word on the end of the word (e.g. ’Bird is the  word').

Bird <- function(x) {
  y<- gsub(pattern = "$", x=x, replacement = ' is the word')# replace the end ($) with is the word. x=x like x=data 
  return(y)
}

Bird('run')

# Edit the above function so that it appends a second input scalar (e.g. 'is not the word'), with the function defaulting to append 'is the word' if no second scalar is provided.

Bird <- function(x, y = 'is the word') {
  z<- gsub(pattern = "$", x=x, replacement = ' is not the word')# replace the end ($) with is the word. x=x like x=data 
  return(z)
}
Bird('hi')


##7. Question time

# 1) Make a for loop that iterates over the numeric vector c(1,1,3,5,8,13,21) and prints the square root of each of the number

squareroot <- c(1,1,3,5,8,13,21)

for (i in squareroot) {
  square <-   sqrt(i)       
  print(square) }
