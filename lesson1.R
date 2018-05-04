# testing R here
3
# Addition
3+4
# pwd 
getwd()
# cd, can start typing and then tab down to what you want, repeat at each step
setwd("C:/Users/zomgb/Desktop/workshop/data/")
getwd()
# ls
list.files()
read.csv(file = "inflammation-01.csv", header = FALSE)
?read.csv()
# variables
3
a <- 3
a + 5

weight_kg <- 55
weight_kg
weight_kg * 2.2

weight_kg <- 57.5
weight_kg

weight_kg*2.2
weight_lb <- weight_kg * 2.2
weight_lb

weight_kg <- 100
weight_lb # shows that it doesn't redo the calculation on line 27
weight_lb <- weight_kg * 2.2
weight_lb

dat <- read.csv(file = "inflammation-01.csv", header = FALSE)
dat
head(dat)
class(dat)
# how big is dat? Get dimensions
dim(dat)

# INDEXING
# like a coordinate system, and always rows before columns
# top left cell
dat[1,1]
dat[30,20]

# use command "c" to get multiple things
c(1,2,3)
# get rows 1,3,5 and columns 10 and 20
dat[c(1,3,5), c(10,20)]

# shortcut for a series of numbers
1:5
# data from rows 1 through 4, columns 1 through 10
dat[1:4, 1:10]

# to grab the whole first row, can leave columns blank
dat[1,]
# to grab the whole second column
dat[,2]
# every row, columns 16 through 19
dat[,16:19]
# get the whole data frame if leave both blank
dat[,]

# in this data, each row is a different patient and each column is inflammation data
# from a different day in the study
dat[1,]
# can find the max value in that row
max(dat[1,])

patient_1 <- dat[1,]
max(patient_1)

# what was minimum on day 7 for any patient?
min(dat[,7])

# stats on inflammation for day 7
mean(dat[,7])
median(dat[,7])
sd(dat[,7])

# can get a summary for each column
summary(dat)
# good for identifying weirdness

# what if we want the mean for each row, or the sd for each column?
# mean of first day
mean(dat[,1])

# but this is tedious, so we can use apply
# if you want every row, use 1; every column, use 2
# mean of every row
apply(dat, 1, mean)
# mean of every column
apply(dat, 2, mean)

# can use combine to save a list or vector of values
a <- c(1,2,3)
a
a * 3

# can use quotes or single tick to indicate that we mean the letter, not a variable
animal <- c('m', 'o', 'n', 'k', 'e', 'y')
animal
# we dont have rows or columns, just one dimension, so don't need a comma to index
animal[1:3]
animal[4:6]
# can change the order of the output
animal[6:4]
# can also omit values from the output
animal[-1]

head(dat)
# say we want average inflammation for each day
apply(dat, 2, mean)
avg_day_inflammation <- apply(dat, 2, mean)

# if you just have a list of numbers, plot() will plot them
plot(avg_day_inflammation)

# get and plot max inflamm per day
max_day_inflammation <- apply(dat, 2, max)
plot(max_day_inflammation)
# get and plot min inflamm per day
min_day_inflammation <- apply(dat, 2, min)
plot(min_day_inflammation)

# exercise from Introduction to R -> 1. Analyzing Patient Data
# get and plot standard dev per day
sd_day_inflammation <- apply(dat, 2, sd)
plot(sd_day_inflammation)

# try mean of second person's data
mean(dat[2.])
# get an error, even though the same thing works for columns
# this is because if you take the row of a data frame, it's a data frame
class(dat[2,])
class(dat[,2])
# if you take a column of a data frame, it converts it into a string of integers
# this is because R knows that all the data in a column is the same data type
# by virtue of it being a data frame, it's not sure the same is true in a row
# apply has this consideration baked in
# but if we want to do it by hand, we have to say as.integer
mean(as.integer(dat[2,]))
