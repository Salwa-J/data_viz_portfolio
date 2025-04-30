# BIO319 Worksheet 1 Script
# Salwa Jama
# 24/01/2025

1 + 3 * 10 # Simple mathematical sum
## Creating a variable

x <- 10 # assigns the values on the right of the <- to the name on the left
y <- 20
z <- 'thirty' # assigns z to the word 'thirty'
x*y # multiply x by y

x/z # This gives error Error in x/z : non-numeric argument to binary operator
# Mathematical operators such as those used above tend to only work on numeric data, hence the error message.
## Data classes
#Variables in R can take the form of several classes, we have already encountered two of them today: ‘numeric’ for x and y, and ‘character’ for z
# check whether your variable is numeric using the is.numeric() function.
#class function to check what class the the data are

# Creating a logical variable: using the logical class in R
a <- TRUE
b <- FALSE

#1 is less than 2
1 < 2
#1 is greater than 2
1 > 2
# < and > are types of logical operator.
x>y #x is greater than y

# <= is less than or equal to
# >= is greater than or equal to
# == is equal to
# != is not equal to
# &= and
## |= or

1 < 2 & 1 > 0 #1 is less than 2 AND greater than 0
1 < 2 | 1 > 0 #OR symbol |, we can ask R whether either expression is true


#Q1) What will R return if you input the expression 7 >= 6?
7 >= 6
#TRUE

#Q2) What would the value of x be if you ran the following code?
x <- 12 / 3 > 3 & 5 ^ 2 < 25
x

##False

#Q3) What would the value of y be if you ran the following code?
y <- 12 / 3 > 3 | 5 ^ 2 < 25 | 1 == 2
#FALSE unsure about this one
#Q4) What would R return if you ran the following code?
z <- FALSE
z == TRUE
#FALSE



