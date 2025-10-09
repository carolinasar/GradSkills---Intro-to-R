# Introduction to R
# By Carolina Sarmiento
# USF - Grad Skills - Oct. 10, 2025

#*******************#
# LET'S GET STARTED # ------
#*******************#

# 1. Set your Working Directory (WD) ----
# You *ALWAYS* have to set your WD (i.e., tell R where - in your computer - are the files you will need and where it can store some of the objects when you ask R to do so)

# A. Check current WD by running the following line
getwd()

# B. Set your WD: Click on the drop-down menu "Session" -> Set Working Directory -> Choose Directory

# **** I suggest you copy the line that just appeared in the Console to your script, for next time you open your script, just run that line. ****

setwd("~/Desktop/Grad_Skills") # copy yours here!


# 2. Install a package -----

# A. Install the package
# Use first the "Install" button on the Packages tab, look for the package of interest (dslabs) and make sure to check "install dependencies"
# or you can run:
install.packages("dslabs")

# B. "load" the package:
library(dslabs)

# 3. Objects ----
# R is an object-oriented language - everything is an object that usually have a name (recommended)
# The user can modify these objects using operators or functions

# Create the object a:
a <-  15

# Ask R to show you the object a:
a

b <- c(1:10)
b

dog <- My dog name is Kona

# Try to run:
dog <- "My dog name is Kona"
dog


# 4. Operators ----
# There are *arithmetic* operators and *logical* operators

# Try some arithmetic operators
a*b
my.sum <-  a+b
my.sum
# what happen when you don't create an object (i.e.,assign a name to your operation)? Compare lines 56 and 57

# Try some logical operators
a == b
a!= b
a < a*b

# 5. Functions ----

# Built-in functions
mean(my.sum)
sd(my.sum)

# Some useful functions
rm(dog) #removes the objet x from your environment
data("iris") #load a dataset from "The R Datasets Package"
head(iris) #gives you the first six rows of the dataset iris and the variable names
tail(iris) #gives you the last six rows of the dataset iris 
names(iris) #give you the names of the variables for the iris dataset
dim(iris) #gives you the dimensions of the dataset iris No. of rows - No. of columns

# User-written functions
# Define your own function by using the general structure of a function:
# function.name <-  function(arguments){body}

addition <-  function(x,y){
  return(x+y)
}

# and use it:
addition(y=8, x=2) # Arguments can be matched by its name
# or
addition(2,8)#R will match each argument by position (as defined by the user, first value = x, second value = y)

# or define another function with the y value = 0 (by default)
myfunction1 <- function(x, y=0){
  print(x)
  print(y)
  return(sum ((x - y) ^ 2))
}

# and use it
myfunction1(10)
myfunction1(10,5) #use 5 instead of 0 for the argument y
myfunction1(b) # Did you see what R did here?! 

# 6. Properties of Objects ----
# Mode: How objects are stored in R (character,numeric,logical,factor,list, function)
mode(iris)
mode(iris$Sepal.Length)

# Class: How R treats the objects (character, factor, numeric, matrix, data.frame, array, and many others)
class(a)
class(iris$Species)

# Lentgh: Number of elements of an object
length(b)

# check also dim () or the dimensions of an object (only for data.frame and matrix)

dim(iris) #gives you the number of rows and number of columns of a data.frame or matrix

# Try
dim(a)

# 7. Data structure ----

# VECTORS: 1-dimensional list of items (values must all be the same mode)
d <- c(11:20)
d2 <- rep("a",5)

# MATRICES: set of elements organized in columns and rows (2-dimensional), columns must have same length
h <- cbind(b,d)
# function cbind() joins the two objects as columns; rbind()joins them as rows
# TRY
h2 <- cbind(a,d)

# DATA FRAMES
f <- rep(TRUE, 10) #create another vector by repeating 'TRUE' 10 times
mydf <- data.frame(b,d,f) #create a data.frame


# 8. The Indexing System ----
A <- matrix(rnorm(100),10,10) #Create a matrix
A

# Check what the function rnorm () does 
help("rnorm")

# Access different elements of Matrix A
A[3,] 		  # shows 3rd row
A[,4]		    # shows 4th column
A[3,4] 		  # shows element in row 3, column 4
A[c(1,9),] 	# shows row 1 and 9
A[,-1]		  # shows all of A, except column 1
A[-c(1,9),] # shows all of A, except rows 1 and 9
A[1:10,5:8]	# shows first 10 rows and columns 5-8
A[A[,1]>0,]	# shows only rows from A where first column is positive **check: A[,1]>0
A[10:1,] 		# shows first 10 rows of A, in opposite order

# "Create" a data frame:
mydf <- iris # the data frame iris is already created, we are just renaming it

# Check its structure:
str(mydf)

# Check the column names:
names(mydf)

# Show me all the columns for the species "setosa":
setosa <-  mydf[mydf$Species=="setosa", ] # note how I assigned a name to this object
setosa # run this line to take a look at the object "setosa"

# Show me the rows where Sepal.Length is > 6 and Sepal.Width is < 4:
val <- mydf[mydf$Sepal.Length>6 & mydf$Sepal.Width < 4, ]
val

# 9. Import a dataset ----

# use the function read.csv () to import the Iris dataset:
mydata <- read.csv("Data/Iris_data.csv", header = TRUE)
# note that my Iris file is stored in the 'Data' Folder inside the WD 
# *change yours if needed*

mydata <- read.table("Data/Iris_data.txt", sep= "\t", h = T) #does this work? why?
mydata <- read.table("Data/Iris_data.csv", sep = ",", header =TRUE)

mydata <- read.csv(file.choose( ))


# 10. Export a dataset ----
# use the function write.csv () to export data:
write.csv(mydata, "Data/New_iris.csv", row.names = FALSE) # Try saving without the row.names argument:
write.csv(mydata, "Data/New_iris2.csv")

# If exporting a plot, try the "Export" menu on the "Plots" tab on the right-bottom pane in RStudio

# 11. The basics of the Tidyverse ----

#First, install the tidyverse package!

# Let's practice a little bit of dplyr:
library(dplyr)

# First take a look at the dataset:
starwars

# Create a new "tibble" by selecting some rows using the starwars dataset:
droids <- starwars %>% 
  filter(species == "Droid")
droids

# Choose a few variables of interest:
colors <- starwars %>% 
  select(name, ends_with("color"))
colors

# Create a new variable to calculate the body mass index:
bmindex <- starwars %>% 
            mutate(name, bmi = mass / ((height / 100)  ^ 2)) %>%
            select(name:mass, bmi)

# Sort your data
sor <- starwars %>% 
       arrange(desc(mass))
sor

# Summarize your data and select what is useful to you:
my.data <- starwars %>%
  group_by(species) %>%
  summarise(
    n = n(),
    mass = mean(mass, na.rm = TRUE)) %>%
  filter(n > 1, mass > 50)

#11. Graphics ----

#We will have another session to learn more about this. For now try"
demo(graphics)


#12. Getting help -----
help(lm)
help("anova")
?lm
citation()
citation("dplyr")
