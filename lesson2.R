# Intro to Part 2

# make our own function 
# when i give you temp_F, come up with temp_K according to this formula and return temp_K
fahrenheight_to_kelvin <- function(temp_F){ 
  temp_K <- ((temp_F - 32) * (5/9)) + 273.15
  return(temp_K)
}
# to run this, you need the cursor on the top line of the function, or else highlight it all

# now we can use our new function
fahrenheight_to_kelvin(100)

# by default, even if you don't put a "return" line, R will by default return the last value
# of the function, but with complex functions this doesn't always turn out well

# make another funciton that does Kelvin to Celsius
kelvin_to_celsius <- function(temp_K){
  temp_C <- temp_K - 273.15
  return(temp_C)
}
# and use it
kelvin_to_celsius(0)
#what happens if you type temp_C
temp_C
# get an error saying 'temp_C' not found
# this is because the variables within a function only exist in the universe of that function

# you can build functions from multiple functions
# we can use our two functions to do a conversion from Fahrenheit to Celsius
fahrenheight_to_celsius <- function(temp_F){
  temp_K <- fahrenheight_to_kelvin(temp_F)
  temp_C <- kelvin_to_celsius(temp_K)
  return(temp_C)
}
# now we can use this new function
fahrenheight_to_celsius(100)
fahrenheight_to_kelvin(0)
fahrenheight_to_kelvin(32)

# how do we know the function is doing what we want it to do?
# we're going to wait to cover this until later

# don't have to use functions just for math
# write one called best practice, where the input will be a sentence
# first assign a sentence
sentence <- c("Write", "programs", "for", "people", "not", "computers")
# create another variable cassed asterisk
asterisk <- "***"
# now write a function that puts a wrapper around a sentence
fence <- function(sentence, wrapper){
  answer <- c(wrapper, sentence, wrapper)
  return(answer)
}
# run the function
fence(sentence, asterisk)

# back to the idea of being able to tell if the function is working
# make a function to center a data set around a desired value
center <- function(data, desired){
  new_data <- (data - mean(data) + desired)
  return(new_data)
}
# to test it out, can make up some dummy data that's easy to check 
z <- c(0,0,0,0)
# pass this data to the function, with desired value = 3
center(z, 3)
# returns all 3s
# if we think about what the function does, this makes sense

# can try on real data
dat <- read.csv(file = "inflammation-01.csv", header = FALSE)

# run the function on a subset of this data frame
# only day 4 data
center(dat[,4], 0)

# return looks right, but we can use some built in functions to get a simplier picture
centered <- center(dat[,4], 0)
# compare min from centered data to min from original data
min(centered)
min(dat[,4])
# can also compare means
mean(centered)
mean(dat[,4])
# by comparing these stats, we're more confident that the function is working
sd(dat[,4])
sd(centered)

# an easier way is to put things into an R function that tells if 2 things are equal
# in this case, we should have the same sd in both data sets
all.equal(sd(dat[,4]), sd(centered))
# returns TRUE or FALSE
# if you want do something about the number of data points, can use an extra argument..Missed somehting

# We can specify defaults for arguments in our functions

# when using functions, can drop argument= as long as inputs are in the correct order
# this is because when we wrote it, we gave it the order to expect arguments
center(0, dat[,4])
# this operated on 0 instead of dat, and used dat as the desired value
# but if we explicitly named the arguements it would be ok
center(desired = 0, data = dat[,4])
# it also breaks it if we don't give it a desired value
center(dat[,4])
# get an error that argument 'desired' is missing, with no default

# let's set a default for desired
center <- function(data, desired = 0){
  new_data <- (data - mean(data)) + desired
  return(new_data)
}

# now we can use it without specifying a desired value
center(dat[,4])

# make another function 
# takes a vector and returns a vector of those values scaled 0 to 1
# need to find the min of the vector you give it
# subtract the min from everything so that min is 0
# find the max of this shifted vector
# then divide through by the max
rescale <- function(vect){
  vect_min <- min(vect)
  vect_shifted <- vect - min(vect)
  max_vect_shifted <- max(vect_shifted)
  new_vect <- (vect_shifted / max_vect_shifted)
  return(new_vect)
}
# make a simple vector to test it out
vect_simp <- c(3,2,5,7)
# try it out
rescale(vect_simp)

# prettier solution
rescale_prettier <- function(v){
  L <- min(v)
  H <- max(v)
  result <- (v - L) / (H - L)
  return(result)
}
# try it out
rescale_prettier(vect_simp)
