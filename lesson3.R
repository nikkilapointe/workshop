# Lesson 3

#Using functions to streamline analysis

analyze <- function(filename){
  # import this data
  dat <- read.csv(file = filename, header = FALSE)
  # plot the avg, min, and max inflammation over time
  avg_day_inflammation <- apply(dat, 2, mean)
  plot(avg_day_inflammation)
  
  min_day_inflammation <- apply(dat, 2, min)
  plot(min_day_inflammation)
  
  max_day_inflammation <- apply(dat, 2, max)
  plot(max_day_inflammation)
  # not going to have a return at the end here, because we're just displaying plot
}

# "initialize" the function by running it once

# make sure we're in the right directory
getwd()
# is my data in here?
list.files()

#looks good, so we can run our new function
analyze('inflammation-01.csv')

# so this is a much easier way to do what we did in lesson 1
# we could apply this to other data files
analyze('inflammation-02.csv')

# can streamline even further with for loops

# can use this function that prints a value to a consol
print('text')
a <- 'text'
print(a)

best_practice <- c('Let', 'the', 'computer', 'do', 'the', 'work')

print_words <- function(sentence){
  print(sentence[1])
  print(sentence[2])
  print(sentence[3])
  print(sentence[4])
  print(sentence[5])
  print(sentence[6])
}

print_words(best_practice)

# that works, but it's clunky
# even worse, it would only work when the sentence has 6 words

best_practice[-6]

print_words(best_practice[-6])
# see that you get NA at the end because there was no word 6

# can use a for loop instead to pull out each element of the sentence and run the same code on it
# note that we could have used "i" instead of "word" insted the function
print_words <- function(sentence){
  for(word in sentence){    
    print(word)
  }
}

# now we get what we want for any sentence length
print_words(best_practice)
# now no NA in the output from the code below because it only tries to print the words in the input vector
print_words(best_practice[-6])

#create a variable called length
len <- 0
vowels <- c('a', 'e', 'i', 'o', 'u')

# make a for loop
# we're not really using v here, but it runs the code for each element in the vector
# and we can add print to see that v actually exists
for(v in vowels){
  print(v)
  len <- len + 1
}
len

letter <- 'z'
for(letter in c('a', 'b', 'c')){
  print(letter)
}
# this would overwrite the variable "letter", so that we never see "z"
# and if we type "letter", see it has the last value that it was set to
letter

# R has a function seq that creates a list of numbers
seq(3)
seq(10)
# make a function that prints the first N numbers of a sequence
# it takes a single number as input and returns all natural numbers up to that number
print_N <- function(N){
  Ns <- seq(N)
  for(i in Ns){
    print(i)
  }
}
# test it out
print_N(3)
