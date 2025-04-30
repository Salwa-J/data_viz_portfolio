#2.1. What is a loop? 
#simple for loop
for (i in 1:5) {  # create a for loop that runs 5 times (1 to 5)
  print(i)        # each time the for loop runs, print the value of i
}

#i is what we called the iterable

#2.2. How does it work?

x <- 0            # make a new scalar called x with a value of 0

# a scalar- single value like a number or a name.
for (i in 1:10) { # create a for loop that runs 10 times (1 to 10)
  x <- x + i      # within our for loop we are adding the value of i to the value of x
}

print(x)          # print x

#Here we have created a variable called x that has a value of 0. x then has the value of i added to it each time the loop runs, meaning that the value of x becomes 55 from 0
#(0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10)

## 2.3. Basic loop questions

#1) Try copying the code into a new script and move the print(x) command into the loop. What do you see?
