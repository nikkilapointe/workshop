# gggplot and dplyer

# to install packages 
install.packages('ggplot2')
# to load packages
# note that she put it in single quotes in library call
# but don't need them
library(ggplot2)

# do the same thing for dplyr
library(dplyr)

# import some data
# it has headers, so can leave that default
mammals <- read.csv("mammals.csv")

# look at the data
head(mammals)

# another way to look at it
glimpse(mammals)

# could also type View(mammals) in the console to pull up data

# we can see that it uses NA for empty cells
# pretty sure this is the default to a "fill" argument
# in the read.csv()

# plot in base R of one of the columns
# simple scatter plot
# syntax is plot(y ~ x, data)
plot(adult_head_body_len_mm ~ adult_body_mass_g, data = mammals)

# same thing in ggplot
# syntax ggplot(data, aes(x,y)) + geom()
ggplot(mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point()
# the warning is just because it took out NAs

# the essential things are the ggplot call
# the data to use
# the aesthetic
# the geom

# if you run it without the geom
# you'll get a blank plot
# the geom tells it what to do on that blank canvass

# let's add more detail
# increase the size of the point with an argument to geom
ggplot(mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point(size = 3)

# we can also map an aesthetic onto a variable
# let's map color onto the variable "order"
ggplot(mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point(size = 3, aes(color = order))
# plot is tiny, but you can use the zoom button

# this would be much more complicated in base R
# especially to get it to make the legend
# can see the code on the course website
# under a ggplot lesson
# and then under Getting Started with ggplot

# it's still hard to see all the detail 
# because so many points on top of each other
# so let's break things down more 

# say we just wanted rodents
# notice the use of the double == for "is equal to"
tails <- filter(mammals, order == "Rodentia")
# check what we have 
glimpse(tails)

# do we have any ROUS's?
# filter to keep things that are Rodentia or have a large mass
large_tails <- filter(mammals, order == "Rodentia" | adult_body_mass_g > 100000)
glimpse(large_tails)

# if we just want large rodents
large_tails <- filter(mammals, order == "Rodentia" & adult_body_mass_g > 100000)
glimpse(large_tails)
# can see that we didn't have any data that fit both criteria
# make criteria more realistic
large_tails <- filter(mammals, order == "Rodentia" & adult_body_mass_g > 10)
glimpse(large_tails)

# get just terrestrial mammals
tmammals <- filter(mammals, habitat == "T")
# if we just want to look at the columns 
colnames(tmammals)

# we could arrange these mammals from smallest to largest
arrange(tmammals, adult_body_mass_g)
# wrap in in View to look at the sorted data
View(arrange(tmammals, adult_body_mass_g))

# say we want to compare body size of terrestrial and marine mammals
ggplot(mammals, aes(x = habitat, y = adult_body_mass_g)) +
  geom_boxplot()
# everything is scrunched because of outliers
# we could put this on a log scale to see it better
ggplot(mammals, aes(x = habitat, y = adult_body_mass_g)) +
  geom_boxplot() +
  scale_y_log10()
# on avg, it looks like marine mammals are larger than terrestrial mammals

# could also code by color
# can also change these default colors with scale_fill_manual
# can change axis labels and a title
ggplot(mammals, aes(x = habitat, y = adult_body_mass_g, fill = habitat)) +
  geom_boxplot() +
  scale_y_log10() +
  scale_fill_manual(values = c("dodgerblue", "forestgreen")) +
  labs(x = "Habitat", y = "Adult body mass (g)", title = "Body mass of mammals, by habitat")

# can use the function colors() to see what colors are available
colors()

# what if we also want to see all the individual data points?
# added it after geom_boxplot to keep all geoms together
ggplot(mammals, aes(x = habitat, y = adult_body_mass_g, fill = habitat)) +
  geom_boxplot() +
  geom_jitter() +
  scale_y_log10() +
  scale_fill_manual(values = c("dodgerblue", "forestgreen")) +
  labs(x = "Habitat", y = "Adult body mass (g)", title = "Body mass of mammals, by habitat")
# geom_point was not super helpful because many points on top of each other
# can use geom_jitter instead

# the order of the geoms matters 
# because the plot is built up in layers
# if we did geom_jitter first, it would be covered by our geom_boxplot
ggplot(mammals, aes(x = habitat, y = adult_body_mass_g, fill = habitat)) +
  geom_jitter() +
  geom_boxplot() +
  scale_y_log10() +
  scale_fill_manual(values = c("dodgerblue", "forestgreen")) +
  labs(x = "Habitat", y = "Adult body mass (g)", title = "Body mass of mammals, by habitat")

# we could go back to first plot and make the points transparent and color coded
# we want to put the transparancy stuff in geom_jitter
# not on the first line, or everything would be transparant
ggplot(mammals, aes(habitat, adult_body_mass_g, fill = habitat)) +
  geom_boxplot() +
  geom_jitter(aes(color = order), alpha = 0.2) +
  scale_y_log10() +
  scale_fill_manual(values = c("dodgerblue", "forestgreen")) +
  labs(x = "Habitat", y = "Adult body mass (g)", title = "Body mass of mammals, by habitat")

# color belongs in aes because everything in aes is mapped to the data
# alpha goes outside aes, because it applies to all the data

# notice that aesthetics are inherited from higher levels
# you could even specify different data frames in each geom

# you can't set a fill for a dot, because a dot is its own thing

# you can put plots in a for loop and make a gif
# the gif is just the loop printing out a bunch of different plots

# we could also use scale_color_discrete(name = 'ORDER')
# and move other aes to the appropriate geom
# and we can change the name of the legend by adding it to geom
ggplot(mammals, aes(habitat, adult_body_mass_g)) +
  geom_boxplot(aes(fill = habitat)) +
  geom_jitter(aes(color = order), alpha = 0.2) +
  scale_y_log10() +
  scale_fill_manual(name = 'Habitat', values = c('blue', 'green')) +
  scale_color_discrete(name = 'ORDER') +
  labs(x = "Habitat", y = "Adult body mass (g)", title = "Body mass of mammals, by habitat")


