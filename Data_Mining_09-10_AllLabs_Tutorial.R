# Data Mining Labs from
# http://www.louisaslett.com/Courses/Data_Mining_09-10.html
# Cristina I Moody
# June 30 2015


## Lab 1 : R Refresher
# Vectors
# Lab 1 Exercise 1
x <- c(1, 4, 5, -3);
y <- c(-1, 4, 2, 9);
# Lab 1 Exercise 2
z <- x + y;

# Matrices
# Compare:
# > matrix(c(1, 2, 3, 4), nrow=2, ncol=2, byrow=TRUE)
#     [,1] [,2]
# [1,]    1    2
# [2,]    3    4
# > matrix(c(1, 2, 3, 4), nrow=2, ncol=2, byrow=FALSE)
#     [,1] [,2]
# [1,]    1    3
# [2,]    2    4
# Lab 1 Exercise 3
D <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3, byrow = TRUE);
#     [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6

# Data Frames
# Look at > iris :
class(iris);
# [1] "data.frame"
names(iris);
# [1] "Sepal.Length" "Sepal.Width"
# [3] "Petal.Length" "Petal.Width"
# [5] "Species"
str(iris);
# 'data.frame':	150 obs. of  5 variables:
#     $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
summary(iris);
# Sepal.Length    Sepal.Width     Petal.Length
# Min.   :4.300   Min.   :2.000   Min.   :1.000
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600
# Median :5.800   Median :3.000   Median :4.350
# Mean   :5.843   Mean   :3.057   Mean   :3.758
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100
# Max.   :7.900   Max.   :4.400   Max.   :6.900
# Petal.Width          Species
# Min.   :0.100   setosa    :50
# 1st Qu.:0.300   versicolor:50
# Median :1.300   virginica :50
# Mean   :1.199
# 3rd Qu.:1.800
# Max.   :2.500

# Exploring Data
# look at > trees :
?trees;
# trees {datasets}	R Documentation
# Girth, Height and Volume for Black Cherry Trees
summary(trees);
# Girth           Height       Volume
# Min.   : 8.30   Min.   :63   Min.   :10.20
# 1st Qu.:11.05   1st Qu.:72   1st Qu.:19.40
# Median :12.90   Median :76   Median :24.20
# Mean   :13.25   Mean   :76   Mean   :30.17
# 3rd Qu.:15.25   3rd Qu.:80   3rd Qu.:37.30
# Max.   :20.60   Max.   :87   Max.   :77.00
str(trees);
# 'data.frame':	31 obs. of  3 variables:
#     $ Girth : num  8.3 8.6 8.8 10.5 10.7 10.8 11 11 11.1 11.2 ...
# $ Height: num  70 65 63 72 81 83 66 75 80 75 ...
# $ Volume: num  10.3 10.3 10.2 16.4 18.8 19.7 15.6 18.2 22.6 19.9 ...
sd(trees$Girth);
# [1] 3.138139
sd(trees$Height);
# [1] 6.371813
sd(trees$Volume);
# [1] 16.43785
var(trees);
# Girth   Height    Volume
# Girth   9.847914 10.38333  49.88812
# Height 10.383333 40.60000  62.66000
# Volume 49.888118 62.66000 270.20280
# Lab 1 Exercise 4
sd(trees$Girth)^2;
# [1] 9.847914
sd(trees$Height)^2;
# [1] 40.6
sd(trees$Volume)^2;
# [1] 270.2028

# Getting the data
# Lab 1 Exercise 5
mean(trees$Height);
# [1] 76
attach(trees);
Girth;
# [1]  8.3  8.6  8.8 10.5 10.7 10.8 11.0 11.0 11.1
# [10] 11.2 11.3 11.4 11.4 11.7 12.0 12.9 12.9 13.3
# [19] 13.7 13.8 14.0 14.2 14.5 16.0 16.3 17.3 17.5
# [28] 17.9 18.0 18.0 20.6

# Simple Graphical Summaries
boxplot(trees);
hist(Height);
plot(Girth, Volume);
# That last plot looks like there’s a strong linear relationship. We can easily ask R to calculate a
# standard linear regression where Volume depends on Girth using lm (linear model) and plot the
# line with abline. This is an example of nesting one function call inside another and can lead to
# powerful yet easy combinations of commands:
abline(lm(Volume ~ Girth), col = "red");
# When there are more than two parameters, a nice way to quickly see all the values plotted
# against each other is to use pairs():
pairs(trees);
# Lab 1 Excerise 6
hist(Girth, freq = FALSE, probability = TRUE);
hist(Height, freq = FALSE, probability = TRUE);
hist(Volume, freq = FALSE, probability = TRUE);


## Lab 2 : A Basic Tree Classifier
# Loading data from Outside R
# Lab 2 Exercise 1
# Download Titanic data set and read it into R
dir <- getwd();
data <- read.csv(sprintf("%s%s", dir, "/Titanic.csv"));
names(data);
# [1] "Class"    "Sex"      "Age"      "Survived"
data;
# Lab 2 Exercise 2
attach(data);

# Exploring the data
# Lab 2 Excercise 3
summary(data);
# Class         Sex          Age       Survived
# 1st :325   Female: 470   Adult:2092   No :1490
# 2nd :285   Male  :1731   Child: 109   Yes: 711
# 3rd :706
# Crew:885
table(data);
# , , Age = Adult, Survived = No
#
# Sex
# Class  Female Male
# 1st       4  118
# 2nd      13  154
# 3rd      89  387
# Crew      3  670
#
# , , Age = Child, Survived = No
#
# Sex
# Class  Female Male
# 1st       0    0
# 2nd       0    0
# 3rd      17   35
# Crew      0    0
#
# , , Age = Adult, Survived = Yes
#
# Sex
# Class  Female Male
# 1st     140   57
# 2nd      80   14
# 3rd      76   75
# Crew     20  192
#
# , , Age = Child, Survived = Yes
#
# Sex
# Class  Female Male
# 1st       1    5
# 2nd      13   11
# 3rd      14   13
# Crew      0    0
table(Age, Survived);
# Survived
# Age       No  Yes
# Adult 1438  654
# Child   52   57
# Lab 2 Exercise 4
table(Class, Survived);
# Survived
# Class   No Yes
# 1st  122 203
# 2nd  167 118
# 3rd  528 178
# Crew 673 212
table(Sex, Survived);
# Survived
# Sex        No  Yes
# Female  126  344
# Male   1364  367
barplot(table(Survived, Class), beside=TRUE, legend=levels(Survived));
# Lab 2 Exercise 5
barplot(table(Survived, Age), beside=TRUE, legend=levels(Survived))
barplot(table(Survived, Sex), beside=TRUE, legend=levels(Survived))
# Additional package for categorical graphics
install.packages("vcd");
library(vcd);

# Building a classification tree
# Lab 2 Exercise 6 : Loading packages
install.packages("rpart");
library(rpart);
# Fitting a tree
fit <- rpart(Survived ~ Class + Age + Sex);
fit;
# n= 2201
#
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
#
# 1) root 2201 711 No (0.6769650 0.3230350)
# 2) Sex=Male 1731 367 No (0.7879838 0.2120162)
# 4) Age=Adult 1667 338 No (0.7972406 0.2027594) *
#     5) Age=Child 64  29 No (0.5468750 0.4531250)
#     10) Class=3rd 48  13 No (0.7291667 0.2708333) *
#         11) Class=1st,2nd 16   0 Yes (0.0000000 1.0000000) *
#             3) Sex=Female 470 126 Yes (0.2680851 0.7319149)
#             6) Class=3rd 196  90 No (0.5408163 0.4591837) *
#                 7) Class=1st,2nd,Crew 274  20 Yes (0.0729927 0.9270073) *
post(fit, file = "");
## Can get better picture with rattle. Installing libraries:
install.packages('rattle');
install.packages('rpart.plot');
install.packages('RColorBrewer');
library(rattle);
library(rpart.plot);
library(RColorBrewer);
# Lab 2 Exercise 7
# Would a male child traveling in 2nd class survive?
fancyRpartPlot(fit); # YES
# Automated Prediction
newdata <- data.frame(Class = c("2nd"), Age = c("Child"), Sex = c("Male"));
newdata;
# Class   Age  Sex
# 1   2nd Child Male
predict(fit, newdata);
# No Yes
# 1  0   1
# Lab 2 Exercise 8
ex8 <- data.frame(Class = c("1st", "2nd", "Crew"),
                  Age = c("Child", "Adult", "Adult"),
                  Sex = c("Female", "Male", "Male"));
ex8;
# Class   Age    Sex
# 1   1st Child Female
# 2   2nd Adult   Male
# 3  Crew Adult   Male
predict(fit, ex8);
# No       Yes
# 1 0.0729927 0.9270073
# 2 0.7972406 0.2027594
# 3 0.7972406 0.2027594

# How did the tree do?
newdata <- subset(data, Survived=="No");
noPredictions <- predict(fit, newdata);
noPredictions;
correct <- (noPredictions[,1] > 0.5);
correct;
table(correct);
# correct
# FALSE  TRUE
# 20  1470
# Lab 2 Exercise 9
newdata2 <- subset(data, Survived=="Yes");
yesPredictions <- predict(fit, newdata2);
yesPredictions;
correctYes <- (yesPredictions[,1] > 0.5);
correctYes;
table(correctYes);
# correctYes
# FALSE  TRUE
# 270   441


## Lab 3 Tree detail, variable importance, & missing data
rm(list = ls());
# Building the Tree
# Getting setup
# Lab 3 Exercise 1
# Download Titanic data set and read it into R
dir <- getwd();
data <- read.csv(sprintf("%s%s", dir, "/Titanic.csv"));
# Lab 3 Exercise 2
# Attach the variable data to your workspace
attach(data);
# Lab 3 Exercise 3
# Load rpart package
install.packages("rpart");
library(rpart);
# Constructing the tree
fit <- rpart(Survived ~ Class + Age + Sex, parms = list(split = "gini"));
fit;
# n= 2201
#
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
#
# 1) root 2201 711 No (0.6769650 0.3230350)
# 2) Sex=Male 1731 367 No (0.7879838 0.2120162)
# 4) Age=Adult 1667 338 No (0.7972406 0.2027594) *
#     5) Age=Child 64  29 No (0.5468750 0.4531250)
#     10) Class=3rd 48  13 No (0.7291667 0.2708333) *
#         11) Class=1st,2nd 16   0 Yes (0.0000000 1.0000000) *
#             3) Sex=Female 470 126 Yes (0.2680851 0.7319149)
#             6) Class=3rd 196  90 No (0.5408163 0.4591837) *
#                 7) Class=1st,2nd,Crew 274  20 Yes (0.0729927 0.9270073) *
# Lab 3 Exercise 4
fit <- rpart(Survived ~ Class + Age + Sex, parms = list(split = "information"));
fit;
# n= 2201
#
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
#
# 1) root 2201 711 No (0.6769650 0.3230350)
# 2) Sex=Male 1731 367 No (0.7879838 0.2120162)
# 4) Age=Adult 1667 338 No (0.7972406 0.2027594) *
#     5) Age=Child 64  29 No (0.5468750 0.4531250)
#     10) Class=3rd 48  13 No (0.7291667 0.2708333) *
#         11) Class=1st,2nd 16   0 Yes (0.0000000 1.0000000) *
#             3) Sex=Female 470 126 Yes (0.2680851 0.7319149)
#             6) Class=3rd 196  90 No (0.5408163 0.4591837) *
#                 7) Class=1st,2nd,Crew 274  20 Yes (0.0729927 0.9270073) *
# No change in the tree from "gini" to "information"
# More tree detail
library(rattle);
asRules(fit);
#
# Rule number: 11 [Survived=Yes cover=16 (1%) prob=1.00]
# Sex=Male
# Age=Child
# Class=1st,2nd
#
# Rule number: 7 [Survived=Yes cover=274 (12%) prob=0.93]
# Sex=Female
# Class=1st,2nd,Crew
#
# Rule number: 6 [Survived=No cover=196 (9%) prob=0.46]
# Sex=Female
# Class=3rd
#
# Rule number: 10 [Survived=No cover=48 (2%) prob=0.27]
# Sex=Male
# Age=Child
# Class=3rd
#
# Rule number: 4 [Survived=No cover=1667 (76%) prob=0.20]
# Sex=Male
# Age=Adult
#
summary(fit);
# Call:
#     rpart(formula = Survived ~ Class + Age + Sex, parms = list(split = "information"))
# n= 2201
#
# CP nsplit rel error    xerror
# 1 0.30661041      0 1.0000000 1.0000000
# 2 0.02250352      1 0.6933896 0.6933896
# 3 0.01125176      2 0.6708861 0.6807314
# 4 0.01000000      4 0.6483826 0.6596343
# xstd
# 1 0.03085662
# 2 0.02750982
# 3 0.02732928
# 4 0.02701971
#
# Variable importance
# Sex Class   Age
# 69    26     5
#
# Node number 1: 2201 observations,    complexity param=0.3066104
# predicted class=No   expected loss=0.323035  P(node) =1
# class counts:  1490   711
# probabilities: 0.677 0.323
# left son=2 (1731 obs) right son=3 (470 obs)
# Primary splits:
#     Sex   splits as  RL,   improve=217.234400, (0 missing)
# Class splits as  RRLL, improve= 76.688460, (0 missing)
# Age   splits as  LR,   improve=  9.780301, (0 missing)
#
# Node number 2: 1731 observations,    complexity param=0.01125176
# predicted class=No   expected loss=0.2120162  P(node) =0.7864607
# class counts:  1364   367
# probabilities: 0.788 0.212
# left son=4 (1667 obs) right son=5 (64 obs)
# Primary splits:
#     Age   splits as  LR,   improve=9.673810, (0 missing)
# Class splits as  RLLL, improve=9.491997, (0 missing)
#
# Node number 3: 470 observations,    complexity param=0.02250352
# predicted class=Yes  expected loss=0.2680851  P(node) =0.2135393
# class counts:   126   344
# probabilities: 0.268 0.732
# left son=6 (196 obs) right son=7 (274 obs)
# Primary splits:
#     Class splits as  RRLR, improve=66.429510, (0 missing)
# Age   splits as  RL,   improve= 1.432219, (0 missing)
# Surrogate splits:
#     Age splits as  RL, agree=0.619, adj=0.087, (0 split)
#
# Node number 4: 1667 observations
# predicted class=No   expected loss=0.2027594  P(node) =0.757383
# class counts:  1329   338
# probabilities: 0.797 0.203
#
# Node number 5: 64 observations,    complexity param=0.01125176
# predicted class=No   expected loss=0.453125  P(node) =0.02907769
# class counts:    35    29
# probabilities: 0.547 0.453
# left son=10 (48 obs) right son=11 (16 obs)
# Primary splits:
#     Class splits as  RRL-, improve=16.04363, (0 missing)
#
# Node number 6: 196 observations
# predicted class=No   expected loss=0.4591837  P(node) =0.08905043
# class counts:   106    90
# probabilities: 0.541 0.459
#
# Node number 7: 274 observations
# predicted class=Yes  expected loss=0.0729927  P(node) =0.1244889
# class counts:    20   254
# probabilities: 0.073 0.927
#
# Node number 10: 48 observations
# predicted class=No   expected loss=0.2708333  P(node) =0.02180827
# class counts:    35    13
# probabilities: 0.729 0.271
#
# Node number 11: 16 observations
# predicted class=Yes  expected loss=0  P(node) =0.007269423
# class counts:     0    16
# probabilities: 0.000 1.000
#
# Numerical or Categorical?
data2 <- data.frame(Survived = Survived, Class = as.double(Class),
                    Age = as.double(Age), Sex = as.double(Sex));
fit2 <- rpart(Survived ~ Class + Age + Sex, data2, parms = list(split='gini'));
fit2;
# n= 2201
#
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
#
# 1) root 2201 711 No (0.67696502 0.32303498)
# 2) Sex>=1.5 1731 367 No (0.78798382 0.21201618)
# 4) Age< 1.5 1667 338 No (0.79724055 0.20275945) *
#     5) Age>=1.5 64  29 No (0.54687500 0.45312500)
# 10) Class>=2.5 48  13 No (0.72916667 0.27083333) *
#     11) Class< 2.5 16   0 Yes (0.00000000 1.00000000) *
#     3) Sex< 1.5 470 126 Yes (0.26808511 0.73191489)
# 6) Class>=2.5 219 109 Yes (0.49771689 0.50228311)
# 12) Class< 3.5 196  90 No (0.54081633 0.45918367) *
#     13) Class>=3.5 23   3 Yes (0.13043478 0.86956522) *
#     7) Class< 2.5 251  17 Yes (0.06772908 0.93227092) *
#
# Lab 3 Exercie 5
# NOTE differences between  fit and fit2. Only difference is value after Sex, Age, Class
# source("http://www.maths.tcd.ie/~louis/DataMining/importance.R");
i <- source("importance.R");
i;
# $value
# function (self)
# {
#     cat(self$info)
# }
#
# $visible
# [1] FALSE
#
# Missing Data
Sex[seq(1, 2201, 10)] <- NA;
Sex;
# [1] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [14] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [27] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Female Female Female Female
# [40] Female <NA>   Female Female Female Female Female Female Female Female Female <NA>   Female
# [53] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [66] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [79] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [92] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [105] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [118] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [131] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [144] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [157] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [170] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [183] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [196] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [209] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [222] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [235] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [248] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [261] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [274] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [287] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [300] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [313] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [326] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [339] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [352] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [365] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [378] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [391] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [404] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [417] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [430] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [443] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [456] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [469] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [482] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [495] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [508] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [521] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [534] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [547] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [560] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [573] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [586] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [599] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [612] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [625] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [638] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [651] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [664] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [677] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [690] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [703] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [716] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [729] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [742] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [755] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [768] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [781] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [794] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [807] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [820] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [833] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [846] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [859] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [872] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [885] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [898] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [911] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [924] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [937] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [950] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [963] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [976] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [989] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [1002] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [1015] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [1028] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [1041] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [1054] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [1067] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [1080] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [1093] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [1106] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [1119] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [1132] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [1145] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [1158] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [1171] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [1184] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [1197] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [1210] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [1223] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [1236] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [1249] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [1262] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [1275] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [1288] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [1301] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [1314] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [1327] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [1340] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [1353] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [1366] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [1379] Male   Male   <NA>   Female Female Female Female Female Female Female Female Female <NA>
#     [1392] Female Female Female Female Female Female Female Female Female <NA>   Female Female Female
# [1405] Female Female Female Female Female Female <NA>   Female Female Female Female Female Female
# [1418] Female Female Female <NA>   Female Female Female Female Female Female Female Female Female
# [1431] <NA>   Female Female Female Female Female Female Female Female Female <NA>   Female Female
# [1444] Female Female Female Female Female Female Female <NA>   Female Female Female Female Female
# [1457] Female Female Female Female <NA>   Female Female Female Female Female Female Female Female
# [1470] Female <NA>   Female Female Female Female Female Female Female Female Female <NA>   Female
# [1483] Female Female Female Female Female Female Female Female <NA>   Male   Male   Male   Male
# [1496] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [1509] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Female <NA>
#     [1522] Female Female Female Female Female Female Female Female Female <NA>   Female Female Female
# [1535] Female Female Female Female Female Female <NA>   Female Female Female Female Female Female
# [1548] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [1561] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [1574] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [1587] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [1600] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [1613] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [1626] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [1639] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [1652] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [1665] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [1678] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [1691] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [1704] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [1717] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [1730] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [1743] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [1756] Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male
# [1769] Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>
#     [1782] Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male
# [1795] Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male
# [1808] Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male
# [1821] <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male
# [1834] Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male
# [1847] Male   Male   Male   Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male
# [1860] Male   <NA>   Male   Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male
# [1873] Male   Male   Male   Male   Male   Male   Male   Male   <NA>   Male   Male   Male   Male
# [1886] Female Female Female Female Female <NA>   Female Female Female Female Female Female Female
# [1899] Female Female <NA>   Female Female Female Female Female Female Female Female Female <NA>
#     [1912] Female Female Female Female Female Female Female Female Female <NA>   Female Female Female
# [1925] Female Female Female Female Female Female <NA>   Female Female Female Female Female Female
# [1938] Female Female Female <NA>   Female Female Female Female Female Female Female Female Female
# [1951] <NA>   Female Female Female Female Female Female Female Female Female <NA>   Female Female
# [1964] Female Female Female Female Female Female Female <NA>   Female Female Female Female Female
# [1977] Female Female Female Female <NA>   Female Female Female Female Female Female Female Female
# [1990] Female <NA>   Female Female Female Female Female Female Female Female Female <NA>   Female
# [2003] Female Female Female Female Female Female Female Female <NA>   Female Female Female Female
# [2016] Female Female Female Female Female <NA>   Female Female Female Female Female Female Female
# [2029] Female Female <NA>   Female Female Female Female Female Female Female Female Female <NA>
#     [2042] Female Female Female Female Female Female Female Female Female <NA>   Female Female Female
# [2055] Female Female Female Female Female Female <NA>   Female Female Female Female Female Female
# [2068] Female Female Female <NA>   Female Female Female Female Female Female Female Female Female
# [2081] <NA>   Female Female Female Female Female Female Female Female Female <NA>   Female Female
# [2094] Female Female Female Female Female Female Female <NA>   Female Female Female Female Female
# [2107] Female Female Female Female <NA>   Female Female Female Female Female Female Female Female
# [2120] Female <NA>   Female Female Female Female Female Female Female Female Female <NA>   Female
# [2133] Female Female Female Female Female Female Female Female <NA>   Female Female Female Female
# [2146] Female Female Female Female Female <NA>   Female Female Female Female Female Female Female
# [2159] Female Female <NA>   Female Female Female Female Female Female Female Female Female <NA>
#     [2172] Female Female Female Female Female Female Female Female Female <NA>   Female Female Female
# [2185] Female Female Female Female Female Female <NA>   Female Female Female Female Female Female
# [2198] Female Female Female <NA>
#     Levels: Female Male
fit3 <- rpart(Survived ~ Class + Age + Sex, control = rpart.control(maxsurrogate = 1), parms = list(split = 'gini'));
fit3;
# n= 2201
#
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
#
# 1) root 2201 711 No (0.67696502 0.32303498)
# 2) Sex=Male 1778 402 No (0.77390326 0.22609674) *
#     3) Sex=Female 423 114 Yes (0.26950355 0.73049645)
#     6) Class=3rd 176  81 No (0.53977273 0.46022727) *
#         7) Class=1st,2nd,Crew 247  19 Yes (0.07692308 0.92307692) *
#
# Lab 3 Exercise 6
# Has the tree changed much between fit and fit3 wit hthe missing values?
# Yes. THe tree has less branches with the missing values. The Male passengers
# are not broken down into Class and Age groups.



## Lab 4 New tree data set and loss matrices
rm(list = ls());
# Lab 4 Excersice 1-2
# Downloaded and load the telecom churn data from the website
dir <- getwd();
churn <- read.csv(sprintf("%s%s", dir, "/churn.csv"));
# Lab 4 Excercise 3
library(rpart);
names(churn);
# [1] "churn"        "area"
# [3] "vmail"        "vmail.msgs"
# [5] "day.mins"     "day.calls"
# [7] "day.charge"   "eve.mins"
# [9] "eve.calls"    "eve.charge"
# [11] "night.mins"   "night.calls"
# [13] "night.charge" "intl.mins"
# [15] "intl.calls"   "intl.charge"
# [17] "svc.calls"
summary(churn);
# churn           area       vmail        vmail.msgs        day.mins       day.calls
# No :2850   Min.   :408.0   no :2411   Min.   : 0.000   Min.   :  0.0   Min.   :  0.0
# Yes: 483   1st Qu.:408.0   yes: 922   1st Qu.: 0.000   1st Qu.:143.7   1st Qu.: 87.0
# Median :415.0              Median : 0.000   Median :179.4   Median :101.0
# Mean   :437.2              Mean   : 8.099   Mean   :179.8   Mean   :100.4
# 3rd Qu.:510.0              3rd Qu.:20.000   3rd Qu.:216.4   3rd Qu.:114.0
# Max.   :510.0              Max.   :51.000   Max.   :350.8   Max.   :165.0
# day.charge       eve.mins       eve.calls       eve.charge      night.mins     night.calls
# Min.   : 0.00   Min.   :  0.0   Min.   :  0.0   Min.   : 0.00   Min.   : 23.2   Min.   : 33.0
# 1st Qu.:24.43   1st Qu.:166.6   1st Qu.: 87.0   1st Qu.:14.16   1st Qu.:167.0   1st Qu.: 87.0
# Median :30.50   Median :201.4   Median :100.0   Median :17.12   Median :201.2   Median :100.0
# Mean   :30.56   Mean   :201.0   Mean   :100.1   Mean   :17.08   Mean   :200.9   Mean   :100.1
# 3rd Qu.:36.79   3rd Qu.:235.3   3rd Qu.:114.0   3rd Qu.:20.00   3rd Qu.:235.3   3rd Qu.:113.0
# Max.   :59.64   Max.   :363.7   Max.   :170.0   Max.   :30.91   Max.   :395.0   Max.   :175.0
# night.charge      intl.mins       intl.calls      intl.charge      svc.calls
# Min.   : 1.040   Min.   : 0.00   Min.   : 0.000   Min.   :0.000   Min.   :0.000
# 1st Qu.: 7.520   1st Qu.: 8.50   1st Qu.: 3.000   1st Qu.:2.300   1st Qu.:1.000
# Median : 9.050   Median :10.30   Median : 4.000   Median :2.780   Median :1.000
# Mean   : 9.039   Mean   :10.24   Mean   : 4.479   Mean   :2.765   Mean   :1.563
# 3rd Qu.:10.590   3rd Qu.:12.10   3rd Qu.: 6.000   3rd Qu.:3.270   3rd Qu.:2.000
# Max.   :17.770   Max.   :20.00   Max.   :20.000   Max.   :5.400   Max.   :9.000
str(churn);
# 'data.frame':	3333 obs. of  17 variables:
#     $ churn       : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 1 1 1 ...
# $ area        : int  415 415 415 408 415 510 510 415 408 415 ...
# $ vmail       : Factor w/ 2 levels "no","yes": 2 2 1 1 1 1 2 1 1 2 ...
# $ vmail.msgs  : int  25 26 0 0 0 0 24 0 0 37 ...
# $ day.mins    : num  265 162 243 299 167 ...
# $ day.calls   : int  110 123 114 71 113 98 88 79 97 84 ...
# $ day.charge  : num  45.1 27.5 41.4 50.9 28.3 ...
# $ eve.mins    : num  197.4 195.5 121.2 61.9 148.3 ...
# $ eve.calls   : int  99 103 110 88 122 101 108 94 80 111 ...
# $ eve.charge  : num  16.78 16.62 10.3 5.26 12.61 ...
# $ night.mins  : num  245 254 163 197 187 ...
# $ night.calls : int  91 103 104 89 121 118 118 96 90 97 ...
# $ night.charge: num  11.01 11.45 7.32 8.86 8.41 ...
# $ intl.mins   : num  10 13.7 12.2 6.6 10.1 6.3 7.5 7.1 8.7 11.2 ...
# $ intl.calls  : int  3 3 5 7 3 6 7 6 4 5 ...
# $ intl.charge : num  2.7 3.7 3.29 1.78 2.73 1.7 2.03 1.92 2.35 3.02 ...
# $ svc.calls   : int  1 1 0 2 3 0 3 0 1 0 ...
graphics.off();
dev.off();
par(mfrow=c(4, 4), mar=c(3,3,3,0), tcl=0.5, mgp=c(0.6,0.6,0.6));
for(i in 4:17) { hist(churn[,i], xlab=names(churn)[i], main=names(churn)[i]) };
# Dividing the data into test and train sets
test_rows <- sample.int(nrow(churn), nrow(churn)/3);
test <- churn[test_rows, ];
train <- churn[-test_rows, ];
# Lab 4 Exercise 4
# Look at how the random split has dealth out lines
summary(train$churn);
# No  Yes
# 1908  314
summary(test$churn);
# No Yes
# 942 169
fit <- rpart(churn ~ ., data=train, parms = list(split = 'gini'), control = rpart.control(cp = 0.0001));
summary(fit);
# Call:
#     rpart(formula = churn ~ ., data = train, parms = list(split = "gini"),
#           control = rpart.control(cp = 1e-04))
# n= 2222
#
# CP nsplit rel error    xerror       xstd
# 1  0.1050955414      0 1.0000000 1.0000000 0.05229406
# 2  0.0812101911      1 0.8949045 0.9299363 0.05071873
# 3  0.0764331210      3 0.7324841 0.8566879 0.04896949
# 4  0.0286624204      4 0.6560510 0.6847134 0.04438040
# 5  0.0207006369      7 0.5700637 0.6178344 0.04237729
# 6  0.0175159236      9 0.5286624 0.5987261 0.04177849
# 7  0.0095541401     11 0.4936306 0.5700637 0.04085630
# 8  0.0079617834     13 0.4745223 0.5636943 0.04064729
# 9  0.0039808917     15 0.4585987 0.5573248 0.04043675
# 10 0.0010615711     21 0.4331210 0.5764331 0.04106380
# 11 0.0007961783     27 0.4267516 0.6337580 0.04286697
# 12 0.0006369427     31 0.4235669 0.6528662 0.04344384
# 13 0.0001000000     36 0.4203822 0.6528662 0.04344384
#
# Variable importance
# day.mins   day.charge     eve.mins   eve.charge    svc.calls   vmail.msgs        vmail
# 22           22           10           10            8            5            5
# day.calls    intl.mins  intl.charge   night.mins night.charge    eve.calls  night.calls
# 3            3            3            2            2            2            2
# intl.calls         area
# 1            1
#
# Node number 1: 2222 observations,    complexity param=0.1050955
# predicted class=No   expected loss=0.1413141  P(node) =1
# class counts:  1908   314
# probabilities: 0.859 0.141
# left son=2 (2083 obs) right son=3 (139 obs)
# Primary splits:
#     day.mins    < 264.45 to the left,  improve=67.584620, (0 missing)
# day.charge  < 44.96  to the left,  improve=67.584620, (0 missing)
# svc.calls   < 3.5    to the left,  improve=48.995600, (0 missing)
# intl.mins   < 13.55  to the left,  improve= 4.978565, (0 missing)
# intl.charge < 3.66   to the left,  improve= 4.978565, (0 missing)
# Surrogate splits:
#     day.charge < 44.96  to the left,  agree=1, adj=1, (0 split)
#
# Node number 2: 2083 observations,    complexity param=0.08121019
# predicted class=No   expected loss=0.1094575  P(node) =0.9374437
# class counts:  1855   228
# probabilities: 0.891 0.109
# left son=4 (1911 obs) right son=5 (172 obs)
# Primary splits:
#     svc.calls  < 3.5    to the left,  improve=50.582160, (0 missing)
# day.mins   < 221.85 to the left,  improve= 9.997290, (0 missing)
# day.charge < 37.715 to the left,  improve= 9.997290, (0 missing)
# intl.calls < 2.5    to the right, improve= 5.138273, (0 missing)
# intl.mins  < 13.35  to the left,  improve= 2.918292, (0 missing)
#
# Node number 3: 139 observations,    complexity param=0.07643312
# predicted class=Yes  expected loss=0.381295  P(node) =0.06255626
# class counts:    53    86
# probabilities: 0.381 0.619
# left son=6 (34 obs) right son=7 (105 obs)
# Primary splits:
#     vmail      splits as  RL,         improve=20.024750, (0 missing)
# vmail.msgs < 6.5    to the right, improve=20.024750, (0 missing)
# eve.mins   < 187.75 to the left,  improve=10.452850, (0 missing)
# eve.charge < 15.96  to the left,  improve=10.452850, (0 missing)
# night.mins < 252.8  to the left,  improve= 6.054293, (0 missing)
# Surrogate splits:
#     vmail.msgs < 6.5    to the right, agree=1, adj=1, (0 split)
#
# Node number 4: 1911 observations,    complexity param=0.02866242
# predicted class=No   expected loss=0.07639979  P(node) =0.860036
# class counts:  1765   146
# probabilities: 0.924 0.076
# left son=8 (1603 obs) right son=9 (308 obs)
# Primary splits:
#     day.mins   < 221.85 to the left,  improve=16.004230, (0 missing)
# day.charge < 37.715 to the left,  improve=16.004230, (0 missing)
# eve.mins   < 258.75 to the left,  improve= 4.452189, (0 missing)
# eve.charge < 21.995 to the left,  improve= 4.452189, (0 missing)
# intl.calls < 2.5    to the right, improve= 4.390077, (0 missing)
# Surrogate splits:
#     day.charge < 37.715 to the left,  agree=1, adj=1, (0 split)
#
# Node number 5: 172 observations,    complexity param=0.08121019
# predicted class=No   expected loss=0.4767442  P(node) =0.07740774
# class counts:    90    82
# probabilities: 0.523 0.477
# left son=10 (85 obs) right son=11 (87 obs)
# Primary splits:
#     day.mins   < 173.6  to the right, improve=35.238700, (0 missing)
# day.charge < 29.515 to the right, improve=35.238700, (0 missing)
# eve.mins   < 192.6  to the right, improve=10.296220, (0 missing)
# eve.charge < 16.375 to the right, improve=10.296220, (0 missing)
# svc.calls  < 4.5    to the left,  improve= 2.790805, (0 missing)
# Surrogate splits:
#     day.charge  < 29.515 to the right, agree=1.000, adj=1.000, (0 split)
# day.calls   < 105.5  to the right, agree=0.576, adj=0.141, (0 split)
# night.calls < 79.5   to the right, agree=0.576, adj=0.141, (0 split)
# eve.mins    < 191.45 to the right, agree=0.552, adj=0.094, (0 split)
# eve.charge  < 16.275 to the right, agree=0.552, adj=0.094, (0 split)
#
# Node number 6: 34 observations
# predicted class=No   expected loss=0.1470588  P(node) =0.01530153
# class counts:    29     5
# probabilities: 0.853 0.147
#
# Node number 7: 105 observations,    complexity param=0.01751592
# predicted class=Yes  expected loss=0.2285714  P(node) =0.04725473
# class counts:    24    81
# probabilities: 0.229 0.771
# left son=14 (38 obs) right son=15 (67 obs)
# Primary splits:
#     eve.mins     < 187.75 to the left,  improve=10.558810, (0 missing)
# eve.charge   < 15.96  to the left,  improve=10.558810, (0 missing)
# night.mins   < 129.9  to the left,  improve= 5.926531, (0 missing)
# night.charge < 5.845  to the left,  improve= 5.926531, (0 missing)
# day.mins     < 277.75 to the left,  improve= 4.111360, (0 missing)
# Surrogate splits:
#     eve.charge  < 15.96  to the left,  agree=1.000, adj=1.000, (0 split)
# night.calls < 75     to the left,  agree=0.667, adj=0.079, (0 split)
# intl.mins   < 3.75   to the left,  agree=0.667, adj=0.079, (0 split)
# intl.charge < 1.01   to the left,  agree=0.667, adj=0.079, (0 split)
# day.calls   < 67.5   to the left,  agree=0.657, adj=0.053, (0 split)
#
# Node number 8: 1603 observations,    complexity param=0.001061571
# predicted class=No   expected loss=0.04803493  P(node) =0.7214221
# class counts:  1526    77
# probabilities: 0.952 0.048
# left son=16 (1287 obs) right son=17 (316 obs)
# Primary splits:
#     intl.calls  < 2.5    to the right, improve=2.2304860, (0 missing)
# intl.mins   < 13.55  to the left,  improve=1.7244690, (0 missing)
# intl.charge < 3.66   to the left,  improve=1.7244690, (0 missing)
# eve.mins    < 302.45 to the left,  improve=0.9395295, (0 missing)
# eve.charge  < 25.705 to the left,  improve=0.9395295, (0 missing)
# Surrogate splits:
#     intl.mins   < 1.2    to the right, agree=0.809, adj=0.032, (0 split)
# intl.charge < 0.325  to the right, agree=0.809, adj=0.032, (0 split)
# day.mins    < 10.2   to the right, agree=0.803, adj=0.003, (0 split)
# day.calls   < 48.5   to the right, agree=0.803, adj=0.003, (0 split)
# day.charge  < 1.735  to the right, agree=0.803, adj=0.003, (0 split)
#
# Node number 9: 308 observations,    complexity param=0.02866242
# predicted class=No   expected loss=0.224026  P(node) =0.1386139
# class counts:   239    69
# probabilities: 0.776 0.224
# left son=18 (241 obs) right son=19 (67 obs)
# Primary splits:
#     eve.mins   < 240.6  to the left,  improve=21.956280, (0 missing)
# eve.charge < 20.45  to the left,  improve=21.956280, (0 missing)
# vmail      splits as  RL,         improve= 5.941959, (0 missing)
# vmail.msgs < 7.5    to the right, improve= 5.941959, (0 missing)
# intl.mins  < 13.85  to the left,  improve= 3.608891, (0 missing)
# Surrogate splits:
#     eve.charge  < 20.45  to the left,  agree=1.000, adj=1.000, (0 split)
# intl.mins   < 2.05   to the right, agree=0.789, adj=0.030, (0 split)
# intl.charge < 0.555  to the right, agree=0.789, adj=0.030, (0 split)
# day.mins    < 222.45 to the right, agree=0.786, adj=0.015, (0 split)
# day.charge  < 37.82  to the right, agree=0.786, adj=0.015, (0 split)
#
# Node number 10: 85 observations,    complexity param=0.00955414
# predicted class=No   expected loss=0.1529412  P(node) =0.03825383
# class counts:    72    13
# probabilities: 0.847 0.153
# left son=20 (78 obs) right son=21 (7 obs)
# Primary splits:
#     eve.mins    < 135.95 to the right, improve=4.807412, (0 missing)
# eve.charge  < 11.555 to the right, improve=4.807412, (0 missing)
# intl.mins   < 13.35  to the left,  improve=1.397775, (0 missing)
# intl.charge < 3.605  to the left,  improve=1.397775, (0 missing)
# night.calls < 116.5  to the left,  improve=1.185434, (0 missing)
# Surrogate splits:
#     eve.charge < 11.555 to the right, agree=1, adj=1, (0 split)
#
# Node number 11: 87 observations,    complexity param=0.02070064
# predicted class=Yes  expected loss=0.2068966  P(node) =0.03915392
# class counts:    18    69
# probabilities: 0.207 0.793
# left son=22 (31 obs) right son=23 (56 obs)
# Primary splits:
#     eve.mins   < 211.9  to the right, improve=9.210710, (0 missing)
# eve.charge < 18.01  to the right, improve=9.210710, (0 missing)
# day.mins   < 148.55 to the right, improve=4.919978, (0 missing)
# day.charge < 25.255 to the right, improve=4.919978, (0 missing)
# intl.mins  < 9.75   to the right, improve=2.038211, (0 missing)
# Surrogate splits:
#     eve.charge   < 18.01  to the right, agree=1.000, adj=1.000, (0 split)
# eve.calls    < 76.5   to the left,  agree=0.678, adj=0.097, (0 split)
# night.mins   < 285.6  to the right, agree=0.678, adj=0.097, (0 split)
# night.charge < 12.855 to the right, agree=0.678, adj=0.097, (0 split)
#
# Node number 14: 38 observations,    complexity param=0.01751592
# predicted class=No   expected loss=0.4736842  P(node) =0.01710171
# class counts:    20    18
# probabilities: 0.526 0.474
# left son=28 (23 obs) right son=29 (15 obs)
# Primary splits:
#     night.mins   < 213.95 to the left,  improve=5.277803, (0 missing)
# night.charge < 9.63   to the left,  improve=5.277803, (0 missing)
# day.mins     < 278.3  to the left,  improve=5.263158, (0 missing)
# day.charge   < 47.315 to the left,  improve=5.263158, (0 missing)
# eve.mins     < 144.25 to the left,  improve=3.850594, (0 missing)
# Surrogate splits:
#     night.charge < 9.63   to the left,  agree=1.000, adj=1.000, (0 split)
# eve.calls    < 128    to the left,  agree=0.658, adj=0.133, (0 split)
# intl.mins    < 13.7   to the left,  agree=0.658, adj=0.133, (0 split)
# intl.calls   < 7.5    to the left,  agree=0.658, adj=0.133, (0 split)
# intl.charge  < 3.7    to the left,  agree=0.658, adj=0.133, (0 split)
#
# Node number 15: 67 observations
# predicted class=Yes  expected loss=0.05970149  P(node) =0.03015302
# class counts:     4    63
# probabilities: 0.060 0.940
#
# Node number 16: 1287 observations,    complexity param=0.001061571
# predicted class=No   expected loss=0.03496503  P(node) =0.5792079
# class counts:  1242    45
# probabilities: 0.965 0.035
# left son=32 (1141 obs) right son=33 (146 obs)
# Primary splits:
#     intl.mins   < 13.55  to the left,  improve=2.9832780, (0 missing)
# intl.charge < 3.66   to the left,  improve=2.9832780, (0 missing)
# intl.calls  < 14.5   to the left,  improve=1.4158720, (0 missing)
# day.calls   < 63.5   to the right, improve=0.3675699, (0 missing)
# day.mins    < 212.05 to the left,  improve=0.3517372, (0 missing)
# Surrogate splits:
#     intl.charge < 3.66   to the left,  agree=1.000, adj=1.000, (0 split)
# intl.calls  < 15.5   to the left,  agree=0.888, adj=0.014, (0 split)
#
# Node number 17: 316 observations,    complexity param=0.0007961783
# predicted class=No   expected loss=0.1012658  P(node) =0.1422142
# class counts:   284    32
# probabilities: 0.899 0.101
# left son=34 (293 obs) right son=35 (23 obs)
# Primary splits:
#     eve.mins    < 275.2  to the left,  improve=3.0159450, (0 missing)
# eve.charge  < 23.395 to the left,  improve=3.0159450, (0 missing)
# vmail.msgs  < 39.5   to the left,  improve=1.2300260, (0 missing)
# eve.calls   < 100.5  to the right, improve=1.2063040, (0 missing)
# night.calls < 114.5  to the left,  improve=0.8438819, (0 missing)
# Surrogate splits:
#     eve.charge < 23.395 to the left,  agree=1, adj=1, (0 split)
#
# Node number 18: 241 observations,    complexity param=0.003980892
# predicted class=No   expected loss=0.1244813  P(node) =0.1084608
# class counts:   211    30
# probabilities: 0.876 0.124
# left son=36 (234 obs) right son=37 (7 obs)
# Primary splits:
#     intl.mins   < 15.1   to the left,  improve=2.880327, (0 missing)
# intl.charge < 4.075  to the left,  improve=2.880327, (0 missing)
# intl.calls  < 2.5    to the right, improve=1.988375, (0 missing)
# area        < 462.5  to the left,  improve=1.920731, (0 missing)
# eve.calls   < 77.5   to the right, improve=1.221281, (0 missing)
# Surrogate splits:
#     intl.charge  < 4.075  to the left,  agree=1.000, adj=1.000, (0 split)
# night.mins   < 86.1   to the right, agree=0.975, adj=0.143, (0 split)
# night.charge < 3.87   to the right, agree=0.975, adj=0.143, (0 split)
#
# Node number 19: 67 observations,    complexity param=0.02866242
# predicted class=Yes  expected loss=0.4179104  P(node) =0.03015302
# class counts:    28    39
# probabilities: 0.418 0.582
# left son=38 (16 obs) right son=39 (51 obs)
# Primary splits:
#     vmail      splits as  RL,         improve=14.244070, (0 missing)
# vmail.msgs < 10.5   to the right, improve=14.244070, (0 missing)
# day.mins   < 249.55 to the left,  improve= 3.130348, (0 missing)
# day.charge < 42.425 to the left,  improve= 3.130348, (0 missing)
# intl.mins  < 7.9    to the left,  improve= 2.428924, (0 missing)
# Surrogate splits:
#     vmail.msgs   < 10.5   to the right, agree=1.000, adj=1.000, (0 split)
# day.calls    < 63     to the left,  agree=0.791, adj=0.125, (0 split)
# night.calls  < 72.5   to the left,  agree=0.791, adj=0.125, (0 split)
# night.mins   < 281.55 to the right, agree=0.776, adj=0.063, (0 split)
# night.charge < 12.67  to the right, agree=0.776, adj=0.063, (0 split)
#
# Node number 20: 78 observations
# predicted class=No   expected loss=0.1025641  P(node) =0.03510351
# class counts:    70     8
# probabilities: 0.897 0.103
#
# Node number 21: 7 observations
# predicted class=Yes  expected loss=0.2857143  P(node) =0.003150315
# class counts:     2     5
# probabilities: 0.286 0.714
#
# Node number 22: 31 observations,    complexity param=0.02070064
# predicted class=No   expected loss=0.483871  P(node) =0.0139514
# class counts:    16    15
# probabilities: 0.516 0.484
# left son=44 (15 obs) right son=45 (16 obs)
# Primary splits:
#     day.mins    < 147    to the right, improve=10.117200, (0 missing)
# day.charge  < 24.99  to the right, improve=10.117200, (0 missing)
# eve.calls   < 102.5  to the right, improve= 3.111144, (0 missing)
# night.calls < 99.5   to the left,  improve= 2.773345, (0 missing)
# day.calls   < 107.5  to the left,  improve= 2.020235, (0 missing)
# Surrogate splits:
#     day.charge  < 24.99  to the right, agree=1.000, adj=1.000, (0 split)
# eve.calls   < 102.5  to the right, agree=0.742, adj=0.467, (0 split)
# night.calls < 92     to the left,  agree=0.710, adj=0.400, (0 split)
# eve.mins    < 239.35 to the left,  agree=0.677, adj=0.333, (0 split)
# eve.charge  < 20.345 to the left,  agree=0.677, adj=0.333, (0 split)
#
# Node number 23: 56 observations
# predicted class=Yes  expected loss=0.03571429  P(node) =0.02520252
# class counts:     2    54
# probabilities: 0.036 0.964
#
# Node number 28: 23 observations,    complexity param=0.00955414
# predicted class=No   expected loss=0.2608696  P(node) =0.01035104
# class counts:    17     6
# probabilities: 0.739 0.261
# left son=56 (14 obs) right son=57 (9 obs)
# Primary splits:
#     day.mins     < 283.6  to the left,  improve=4.8695650, (0 missing)
# day.charge   < 48.21  to the left,  improve=4.8695650, (0 missing)
# night.mins   < 164.35 to the right, improve=0.6849498, (0 missing)
# night.charge < 7.395  to the right, improve=0.6849498, (0 missing)
# eve.calls    < 112.5  to the right, improve=0.4528986, (0 missing)
# Surrogate splits:
#     day.charge  < 48.21  to the left,  agree=1.000, adj=1.000, (0 split)
# day.calls   < 63.5   to the right, agree=0.696, adj=0.222, (0 split)
# intl.mins   < 8.1    to the right, agree=0.696, adj=0.222, (0 split)
# intl.charge < 2.185  to the right, agree=0.696, adj=0.222, (0 split)
# area        < 411.5  to the right, agree=0.652, adj=0.111, (0 split)
#
# Node number 29: 15 observations
# predicted class=Yes  expected loss=0.2  P(node) =0.006750675
# class counts:     3    12
# probabilities: 0.200 0.800
#
# Node number 32: 1141 observations
# predicted class=No   expected loss=0.02278703  P(node) =0.5135014
# class counts:  1115    26
# probabilities: 0.977 0.023
#
# Node number 33: 146 observations,    complexity param=0.001061571
# predicted class=No   expected loss=0.130137  P(node) =0.06570657
# class counts:   127    19
# probabilities: 0.870 0.130
# left son=66 (139 obs) right son=67 (7 obs)
# Primary splits:
#     day.calls   < 71     to the right, improve=2.863633, (0 missing)
# intl.mins   < 14.65  to the right, improve=1.992118, (0 missing)
# intl.charge < 3.955  to the right, improve=1.992118, (0 missing)
# day.mins    < 181.3  to the right, improve=1.008441, (0 missing)
# day.charge  < 30.825 to the right, improve=1.008441, (0 missing)
#
# Node number 34: 293 observations,    complexity param=0.0007961783
# predicted class=No   expected loss=0.08191126  P(node) =0.1318632
# class counts:   269    24
# probabilities: 0.918 0.082
# left son=68 (170 obs) right son=69 (123 obs)
# Primary splits:
#     eve.mins   < 189.7  to the right, improve=1.7600810, (0 missing)
# eve.charge < 16.125 to the right, improve=1.7600810, (0 missing)
# vmail.msgs < 39.5   to the left,  improve=1.4129960, (0 missing)
# eve.calls  < 100.5  to the right, improve=0.7476530, (0 missing)
# svc.calls  < 0.5    to the right, improve=0.5962097, (0 missing)
# Surrogate splits:
#     eve.charge < 16.125 to the right, agree=1.000, adj=1.000, (0 split)
# eve.calls  < 63.5   to the right, agree=0.601, adj=0.049, (0 split)
# day.mins   < 118.7  to the right, agree=0.594, adj=0.033, (0 split)
# day.calls  < 121.5  to the left,  agree=0.594, adj=0.033, (0 split)
# day.charge < 20.18  to the right, agree=0.594, adj=0.033, (0 split)
#
# Node number 35: 23 observations
# predicted class=No   expected loss=0.3478261  P(node) =0.01035104
# class counts:    15     8
# probabilities: 0.652 0.348
#
# Node number 36: 234 observations,    complexity param=0.003980892
# predicted class=No   expected loss=0.1111111  P(node) =0.1053105
# class counts:   208    26
# probabilities: 0.889 0.111
# left son=72 (176 obs) right son=73 (58 obs)
# Primary splits:
#     intl.calls < 2.5    to the right, improve=2.6172070, (0 missing)
# area       < 462.5  to the left,  improve=2.0413400, (0 missing)
# eve.calls  < 77.5   to the right, improve=1.4626070, (0 missing)
# eve.mins   < 181.55 to the left,  improve=0.7832193, (0 missing)
# eve.charge < 15.435 to the left,  improve=0.7832193, (0 missing)
# Surrogate splits:
#     eve.calls   < 143.5  to the left,  agree=0.761, adj=0.034, (0 split)
# vmail.msgs  < 43.5   to the left,  agree=0.756, adj=0.017, (0 split)
# night.calls < 55     to the right, agree=0.756, adj=0.017, (0 split)
#
# Node number 37: 7 observations
# predicted class=Yes  expected loss=0.4285714  P(node) =0.003150315
# class counts:     3     4
# probabilities: 0.429 0.571
#
# Node number 38: 16 observations
# predicted class=No   expected loss=0  P(node) =0.00720072
# class counts:    16     0
# probabilities: 1.000 0.000
#
# Node number 39: 51 observations,    complexity param=0.007961783
# predicted class=Yes  expected loss=0.2352941  P(node) =0.0229523
# class counts:    12    39
# probabilities: 0.235 0.765
# left son=78 (32 obs) right son=79 (19 obs)
# Primary splits:
#     night.mins   < 213.05 to the left,  improve=3.352941, (0 missing)
# night.charge < 9.585  to the left,  improve=3.352941, (0 missing)
# day.mins     < 234    to the left,  improve=3.033586, (0 missing)
# day.charge   < 39.78  to the left,  improve=3.033586, (0 missing)
# intl.mins    < 8.95   to the left,  improve=2.433749, (0 missing)
# Surrogate splits:
#     night.charge < 9.585  to the left,  agree=1.000, adj=1.000, (0 split)
# eve.mins     < 270.25 to the left,  agree=0.686, adj=0.158, (0 split)
# eve.calls    < 79.5   to the right, agree=0.686, adj=0.158, (0 split)
# eve.charge   < 22.97  to the left,  agree=0.686, adj=0.158, (0 split)
# day.mins     < 222.35 to the right, agree=0.667, adj=0.105, (0 split)
#
# Node number 44: 15 observations
# predicted class=No   expected loss=0.06666667  P(node) =0.006750675
# class counts:    14     1
# probabilities: 0.933 0.067
#
# Node number 45: 16 observations
# predicted class=Yes  expected loss=0.125  P(node) =0.00720072
# class counts:     2    14
# probabilities: 0.125 0.875
#
# Node number 56: 14 observations
# predicted class=No   expected loss=0  P(node) =0.00630063
# class counts:    14     0
# probabilities: 1.000 0.000
#
# Node number 57: 9 observations
# predicted class=Yes  expected loss=0.3333333  P(node) =0.004050405
# class counts:     3     6
# probabilities: 0.333 0.667
#
# Node number 66: 139 observations,    complexity param=0.0006369427
# predicted class=No   expected loss=0.1079137  P(node) =0.06255626
# class counts:   124    15
# probabilities: 0.892 0.108
# left son=132 (71 obs) right son=133 (68 obs)
# Primary splits:
#     intl.mins   < 14.65  to the right, improve=2.5554650, (0 missing)
# intl.charge < 3.955  to the right, improve=2.5554650, (0 missing)
# day.mins    < 178.25 to the right, improve=0.9777362, (0 missing)
# day.charge  < 30.3   to the right, improve=0.9777362, (0 missing)
# night.calls < 115.5  to the left,  improve=0.7180758, (0 missing)
# Surrogate splits:
#     intl.charge < 3.955  to the right, agree=1.000, adj=1.000, (0 split)
# day.mins    < 163.1  to the right, agree=0.597, adj=0.176, (0 split)
# day.charge  < 27.725 to the right, agree=0.597, adj=0.176, (0 split)
# day.calls   < 94.5   to the right, agree=0.590, adj=0.162, (0 split)
# eve.calls   < 112.5  to the left,  agree=0.576, adj=0.132, (0 split)
#
# Node number 67: 7 observations
# predicted class=Yes  expected loss=0.4285714  P(node) =0.003150315
# class counts:     3     4
# probabilities: 0.429 0.571
#
# Node number 68: 170 observations
# predicted class=No   expected loss=0.03529412  P(node) =0.07650765
# class counts:   164     6
# probabilities: 0.965 0.035
#
# Node number 69: 123 observations,    complexity param=0.0007961783
# predicted class=No   expected loss=0.1463415  P(node) =0.05535554
# class counts:   105    18
# probabilities: 0.854 0.146
# left son=138 (87 obs) right son=139 (36 obs)
# Primary splits:
#     eve.mins     < 176.4  to the left,  improve=2.580366, (0 missing)
# eve.charge   < 14.995 to the left,  improve=2.580366, (0 missing)
# night.mins   < 260.9  to the left,  improve=2.140403, (0 missing)
# night.charge < 11.74  to the left,  improve=2.140403, (0 missing)
# area         < 411.5  to the right, improve=2.041318, (0 missing)
# Surrogate splits:
#     eve.charge  < 14.995 to the left,  agree=1.000, adj=1.000, (0 split)
# day.mins    < 79.75  to the right, agree=0.732, adj=0.083, (0 split)
# day.charge  < 13.555 to the right, agree=0.732, adj=0.083, (0 split)
# day.calls   < 64     to the right, agree=0.724, adj=0.056, (0 split)
# night.calls < 146    to the left,  agree=0.724, adj=0.056, (0 split)
#
# Node number 72: 176 observations,    complexity param=0.001061571
# predicted class=No   expected loss=0.06818182  P(node) =0.07920792
# class counts:   164    12
# probabilities: 0.932 0.068
# left son=144 (130 obs) right son=145 (46 obs)
# Primary splits:
#     area       < 462.5  to the left,  improve=0.8786865, (0 missing)
# day.mins   < 226.3  to the right, improve=0.7841492, (0 missing)
# day.charge < 38.47  to the right, improve=0.7841492, (0 missing)
# eve.calls  < 121.5  to the left,  improve=0.7841492, (0 missing)
# day.calls  < 133.5  to the left,  improve=0.6899255, (0 missing)
# Surrogate splits:
#     eve.calls   < 129.5  to the left,  agree=0.756, adj=0.065, (0 split)
# intl.mins   < 13.85  to the left,  agree=0.744, adj=0.022, (0 split)
# intl.charge < 3.74   to the left,  agree=0.744, adj=0.022, (0 split)
#
# Node number 73: 58 observations,    complexity param=0.003980892
# predicted class=No   expected loss=0.2413793  P(node) =0.02610261
# class counts:    44    14
# probabilities: 0.759 0.241
# left son=146 (17 obs) right son=147 (41 obs)
# Primary splits:
#     eve.calls  < 108.5  to the right, improve=2.802355, (0 missing)
# day.calls  < 83.5   to the right, improve=2.023988, (0 missing)
# day.mins   < 233    to the left,  improve=1.294713, (0 missing)
# day.charge < 39.615 to the left,  improve=1.294713, (0 missing)
# area       < 462.5  to the left,  improve=1.135824, (0 missing)
# Surrogate splits:
#     day.mins   < 223.35 to the left,  agree=0.759, adj=0.176, (0 split)
# day.charge < 37.97  to the left,  agree=0.759, adj=0.176, (0 split)
# eve.mins   < 232.8  to the right, agree=0.741, adj=0.118, (0 split)
# eve.charge < 19.785 to the right, agree=0.741, adj=0.118, (0 split)
# intl.mins  < 13.35  to the right, agree=0.724, adj=0.059, (0 split)
#
# Node number 78: 32 observations,    complexity param=0.007961783
# predicted class=Yes  expected loss=0.375  P(node) =0.01440144
# class counts:    12    20
# probabilities: 0.375 0.625
# left son=156 (15 obs) right son=157 (17 obs)
# Primary splits:
#     day.mins    < 236.15 to the left,  improve=4.803922, (0 missing)
# day.charge  < 40.15  to the left,  improve=4.803922, (0 missing)
# intl.mins   < 9.2    to the left,  improve=3.266667, (0 missing)
# intl.charge < 2.485  to the left,  improve=3.266667, (0 missing)
# eve.mins    < 268.95 to the left,  improve=2.200000, (0 missing)
# Surrogate splits:
#     day.charge  < 40.15  to the left,  agree=1.000, adj=1.000, (0 split)
# intl.mins   < 9.2    to the left,  agree=0.719, adj=0.400, (0 split)
# intl.charge < 2.485  to the left,  agree=0.719, adj=0.400, (0 split)
# eve.mins    < 252.95 to the right, agree=0.688, adj=0.333, (0 split)
# eve.charge  < 21.5   to the right, agree=0.688, adj=0.333, (0 split)
#
# Node number 79: 19 observations
# predicted class=Yes  expected loss=0  P(node) =0.008550855
# class counts:     0    19
# probabilities: 0.000 1.000
#
# Node number 132: 71 observations
# predicted class=No   expected loss=0.01408451  P(node) =0.0319532
# class counts:    70     1
# probabilities: 0.986 0.014
#
# Node number 133: 68 observations,    complexity param=0.0006369427
# predicted class=No   expected loss=0.2058824  P(node) =0.03060306
# class counts:    54    14
# probabilities: 0.794 0.206
# left son=266 (52 obs) right son=267 (16 obs)
# Primary splits:
#     day.calls  < 112.5  to the left,  improve=1.1968330, (0 missing)
# day.mins   < 126.25 to the right, improve=1.0269030, (0 missing)
# day.charge < 21.465 to the right, improve=1.0269030, (0 missing)
# area       < 462.5  to the right, improve=0.9831202, (0 missing)
# eve.calls  < 98.5   to the right, improve=0.9510836, (0 missing)
#
# Node number 138: 87 observations
# predicted class=No   expected loss=0.08045977  P(node) =0.03915392
# class counts:    80     7
# probabilities: 0.920 0.080
#
# Node number 139: 36 observations,    complexity param=0.0007961783
# predicted class=No   expected loss=0.3055556  P(node) =0.01620162
# class counts:    25    11
# probabilities: 0.694 0.306
# left son=278 (25 obs) right son=279 (11 obs)
# Primary splits:
#     area         < 411.5  to the right, improve=1.823232, (0 missing)
# night.mins   < 225.75 to the left,  improve=1.500000, (0 missing)
# night.charge < 10.16  to the left,  improve=1.500000, (0 missing)
# day.calls    < 105.5  to the left,  improve=1.334921, (0 missing)
# eve.calls    < 86.5   to the right, improve=1.047009, (0 missing)
# Surrogate splits:
#     vmail.msgs < 34     to the left,  agree=0.833, adj=0.455, (0 split)
# eve.mins   < 187.45 to the left,  agree=0.750, adj=0.182, (0 split)
# eve.charge < 15.93  to the left,  agree=0.750, adj=0.182, (0 split)
# vmail      splits as  LR,         agree=0.722, adj=0.091, (0 split)
# day.mins   < 68.05  to the right, agree=0.722, adj=0.091, (0 split)
#
# Node number 144: 130 observations
# predicted class=No   expected loss=0.03846154  P(node) =0.05850585
# class counts:   125     5
# probabilities: 0.962 0.038
#
# Node number 145: 46 observations,    complexity param=0.001061571
# predicted class=No   expected loss=0.1521739  P(node) =0.02070207
# class counts:    39     7
# probabilities: 0.848 0.152
# left son=290 (19 obs) right son=291 (27 obs)
# Primary splits:
#     night.mins   < 191.85 to the left,  improve=1.499195, (0 missing)
# night.charge < 8.63   to the left,  improve=1.499195, (0 missing)
# day.calls    < 109.5  to the left,  improve=1.292942, (0 missing)
# day.mins     < 253.95 to the left,  improve=1.261507, (0 missing)
# day.charge   < 43.17  to the left,  improve=1.261507, (0 missing)
# Surrogate splits:
#     night.charge < 8.63   to the left,  agree=1.000, adj=1.000, (0 split)
# eve.mins     < 119.25 to the left,  agree=0.652, adj=0.158, (0 split)
# eve.calls    < 127.5  to the right, agree=0.652, adj=0.158, (0 split)
# eve.charge   < 10.14  to the left,  agree=0.652, adj=0.158, (0 split)
# intl.mins    < 7.9    to the left,  agree=0.652, adj=0.158, (0 split)
#
# Node number 146: 17 observations
# predicted class=No   expected loss=0  P(node) =0.007650765
# class counts:    17     0
# probabilities: 1.000 0.000
#
# Node number 147: 41 observations,    complexity param=0.003980892
# predicted class=No   expected loss=0.3414634  P(node) =0.01845185
# class counts:    27    14
# probabilities: 0.659 0.341
# left son=294 (33 obs) right son=295 (8 obs)
# Primary splits:
#     day.calls   < 83.5   to the right, improve=3.317812, (0 missing)
# day.mins    < 232.35 to the left,  improve=1.581181, (0 missing)
# day.charge  < 39.5   to the left,  improve=1.581181, (0 missing)
# night.calls < 97.5   to the right, improve=1.319024, (0 missing)
# area        < 462.5  to the left,  improve=1.068654, (0 missing)
# Surrogate splits:
#     eve.calls   < 107.5  to the left,  agree=0.854, adj=0.250, (0 split)
# intl.mins   < 13.1   to the left,  agree=0.829, adj=0.125, (0 split)
# intl.charge < 3.535  to the left,  agree=0.829, adj=0.125, (0 split)
#
# Node number 156: 15 observations
# predicted class=No   expected loss=0.3333333  P(node) =0.006750675
# class counts:    10     5
# probabilities: 0.667 0.333
#
# Node number 157: 17 observations
# predicted class=Yes  expected loss=0.1176471  P(node) =0.007650765
# class counts:     2    15
# probabilities: 0.118 0.882
#
# Node number 266: 52 observations,    complexity param=0.0006369427
# predicted class=No   expected loss=0.1538462  P(node) =0.02340234
# class counts:    44     8
# probabilities: 0.846 0.154
# left son=532 (18 obs) right son=533 (34 obs)
# Primary splits:
#     day.mins   < 173.25 to the right, improve=1.3031670, (0 missing)
# day.charge < 29.455 to the right, improve=1.3031670, (0 missing)
# area       < 462.5  to the right, improve=0.6134217, (0 missing)
# eve.calls  < 80.5   to the left,  improve=0.5860806, (0 missing)
# vmail.msgs < 23.5   to the left,  improve=0.5289377, (0 missing)
# Surrogate splits:
#     day.charge   < 29.455 to the right, agree=1.000, adj=1.000, (0 split)
# night.mins   < 140.85 to the left,  agree=0.731, adj=0.222, (0 split)
# night.charge < 6.34   to the left,  agree=0.731, adj=0.222, (0 split)
# eve.calls    < 64.5   to the left,  agree=0.692, adj=0.111, (0 split)
# intl.mins    < 14.55  to the right, agree=0.692, adj=0.111, (0 split)
#
# Node number 267: 16 observations
# predicted class=No   expected loss=0.375  P(node) =0.00720072
# class counts:    10     6
# probabilities: 0.625 0.375
#
# Node number 278: 25 observations
# predicted class=No   expected loss=0.2  P(node) =0.01125113
# class counts:    20     5
# probabilities: 0.800 0.200
#
# Node number 279: 11 observations
# predicted class=Yes  expected loss=0.4545455  P(node) =0.004950495
# class counts:     5     6
# probabilities: 0.455 0.545
#
# Node number 290: 19 observations
# predicted class=No   expected loss=0  P(node) =0.008550855
# class counts:    19     0
# probabilities: 1.000 0.000
#
# Node number 291: 27 observations,    complexity param=0.001061571
# predicted class=No   expected loss=0.2592593  P(node) =0.01215122
# class counts:    20     7
# probabilities: 0.741 0.259
# left son=582 (18 obs) right son=583 (9 obs)
# Primary splits:
#     day.mins   < 245.1  to the left,  improve=2.3703700, (0 missing)
# day.charge < 41.665 to the left,  improve=2.3703700, (0 missing)
# day.calls  < 108.5  to the left,  improve=1.8417990, (0 missing)
# intl.calls < 4.5    to the left,  improve=1.5282650, (0 missing)
# eve.mins   < 203.9  to the left,  improve=0.9259259, (0 missing)
# Surrogate splits:
#     day.charge < 41.665 to the left,  agree=1.000, adj=1.000, (0 split)
# eve.mins   < 213.8  to the left,  agree=0.815, adj=0.444, (0 split)
# eve.charge < 18.17  to the left,  agree=0.815, adj=0.444, (0 split)
# day.calls  < 122    to the left,  agree=0.741, adj=0.222, (0 split)
# eve.calls  < 84.5   to the right, agree=0.741, adj=0.222, (0 split)
#
# Node number 294: 33 observations,    complexity param=0.003980892
# predicted class=No   expected loss=0.2424242  P(node) =0.01485149
# class counts:    25     8
# probabilities: 0.758 0.242
# left son=588 (13 obs) right son=589 (20 obs)
# Primary splits:
#     day.calls   < 105.5  to the left,  improve=2.521212, (0 missing)
# day.mins    < 236.25 to the left,  improve=1.698990, (0 missing)
# day.charge  < 40.16  to the left,  improve=1.698990, (0 missing)
# intl.mins   < 10.85  to the left,  improve=1.685122, (0 missing)
# intl.charge < 2.93   to the left,  improve=1.685122, (0 missing)
# Surrogate splits:
#     eve.mins    < 206.15 to the right, agree=0.758, adj=0.385, (0 split)
# eve.charge  < 17.525 to the right, agree=0.758, adj=0.385, (0 split)
# intl.mins   < 9.85   to the left,  agree=0.727, adj=0.308, (0 split)
# intl.charge < 2.66   to the left,  agree=0.727, adj=0.308, (0 split)
# area        < 411.5  to the left,  agree=0.697, adj=0.231, (0 split)
#
# Node number 295: 8 observations
# predicted class=Yes  expected loss=0.25  P(node) =0.00360036
# class counts:     2     6
# probabilities: 0.250 0.750
#
# Node number 532: 18 observations
# predicted class=No   expected loss=0  P(node) =0.00810081
# class counts:    18     0
# probabilities: 1.000 0.000
#
# Node number 533: 34 observations,    complexity param=0.0006369427
# predicted class=No   expected loss=0.2352941  P(node) =0.01530153
# class counts:    26     8
# probabilities: 0.765 0.235
# left son=1066 (12 obs) right son=1067 (22 obs)
# Primary splits:
#     eve.calls    < 108    to the right, improve=0.8565062, (0 missing)
# night.mins   < 207.05 to the left,  improve=0.7067227, (0 missing)
# night.charge < 9.315  to the left,  improve=0.7067227, (0 missing)
# svc.calls    < 1.5    to the left,  improve=0.7067227, (0 missing)
# area         < 462.5  to the right, improve=0.6779819, (0 missing)
# Surrogate splits:
#     intl.mins    < 14.25  to the right, agree=0.765, adj=0.333, (0 split)
# intl.charge  < 3.845  to the right, agree=0.765, adj=0.333, (0 split)
# day.calls    < 79     to the left,  agree=0.706, adj=0.167, (0 split)
# night.mins   < 146.25 to the left,  agree=0.706, adj=0.167, (0 split)
# night.charge < 6.585  to the left,  agree=0.706, adj=0.167, (0 split)
#
# Node number 582: 18 observations
# predicted class=No   expected loss=0.1111111  P(node) =0.00810081
# class counts:    16     2
# probabilities: 0.889 0.111
#
# Node number 583: 9 observations
# predicted class=Yes  expected loss=0.4444444  P(node) =0.004050405
# class counts:     4     5
# probabilities: 0.444 0.556
#
# Node number 588: 13 observations
# predicted class=No   expected loss=0  P(node) =0.005850585
# class counts:    13     0
# probabilities: 1.000 0.000
#
# Node number 589: 20 observations,    complexity param=0.003980892
# predicted class=No   expected loss=0.4  P(node) =0.0090009
# class counts:    12     8
# probabilities: 0.600 0.400
# left son=1178 (11 obs) right son=1179 (9 obs)
# Primary splits:
#     intl.mins   < 10.85  to the left,  improve=2.3272730, (0 missing)
# intl.charge < 2.93   to the left,  improve=2.3272730, (0 missing)
# day.mins    < 233.9  to the left,  improve=1.4241760, (0 missing)
# day.charge  < 39.76  to the left,  improve=1.4241760, (0 missing)
# area        < 462.5  to the left,  improve=0.7919192, (0 missing)
# Surrogate splits:
#     intl.charge  < 2.93   to the left,  agree=1.00, adj=1.000, (0 split)
# night.mins   < 213.5  to the right, agree=0.85, adj=0.667, (0 split)
# night.charge < 9.605  to the right, agree=0.85, adj=0.667, (0 split)
# day.calls    < 110.5  to the right, agree=0.65, adj=0.222, (0 split)
# eve.mins     < 167.25 to the left,  agree=0.65, adj=0.222, (0 split)
#
# Node number 1066: 12 observations
# predicted class=No   expected loss=0.08333333  P(node) =0.00540054
# class counts:    11     1
# probabilities: 0.917 0.083
#
# Node number 1067: 22 observations,    complexity param=0.0006369427
# predicted class=No   expected loss=0.3181818  P(node) =0.00990099
# class counts:    15     7
# probabilities: 0.682 0.318
# left son=2134 (13 obs) right son=2135 (9 obs)
# Primary splits:
#     intl.mins   < 14.05  to the left,  improve=1.716395, (0 missing)
# intl.charge < 3.795  to the left,  improve=1.716395, (0 missing)
# day.mins    < 127.3  to the right, improve=1.316883, (0 missing)
# day.charge  < 21.645 to the right, improve=1.316883, (0 missing)
# eve.calls   < 93.5   to the left,  improve=1.212121, (0 missing)
# Surrogate splits:
#     intl.charge < 3.795  to the left,  agree=1.000, adj=1.000, (0 split)
# day.mins    < 159.5  to the left,  agree=0.727, adj=0.333, (0 split)
# day.charge  < 27.115 to the left,  agree=0.727, adj=0.333, (0 split)
# eve.calls   < 103.5  to the left,  agree=0.727, adj=0.333, (0 split)
# night.mins  < 239.6  to the left,  agree=0.727, adj=0.333, (0 split)
#
# Node number 1178: 11 observations
# predicted class=No   expected loss=0.1818182  P(node) =0.004950495
# class counts:     9     2
# probabilities: 0.818 0.182
#
# Node number 1179: 9 observations
# predicted class=Yes  expected loss=0.3333333  P(node) =0.004050405
# class counts:     3     6
# probabilities: 0.333 0.667
#
# Node number 2134: 13 observations
# predicted class=No   expected loss=0.1538462  P(node) =0.005850585
# class counts:    11     2
# probabilities: 0.846 0.154
#
# Node number 2135: 9 observations
# predicted class=Yes  expected loss=0.4444444  P(node) =0.004050405
# class counts:     4     5
# probabilities: 0.444 0.556
#
# Lab 4 Exercise 5
# What is the best value for the complexity parameter on the basis of this table?
# cp = 0.0001 does not work because the xerror increases before the tree is finished
# cp = 0.001 has the same problem as cp = 0.0001, but the tree is shorter.
# cp = 0.01 is the best complexity parameter because the tree is still diverse and the xerror only decreases.
# cp = 0.1 does not work bescause the tree has no nodes.
# Lab 4 Exercise 6
# Refit the tree using the best value for the complexity parameter and store it in fit.
fit <- rpart(churn ~ ., data=train, parms = list(split = 'gini'), control = rpart.control(cp = 0.01));
summary(fit);
# Call:
#     rpart(formula = churn ~ ., data = train, parms = list(split = "gini"),
#           control = rpart.control(cp = 0.01))
# n= 2222
#
# CP nsplit rel error    xerror       xstd
# 1 0.09335443      0 1.0000000 1.0000000 0.05210098
# 2 0.08069620      2 0.8132911 0.9272152 0.05047087
# 3 0.02531646      4 0.6518987 0.6740506 0.04391579
# 4 0.02056962      5 0.6265823 0.6677215 0.04373087
# 5 0.01582278      7 0.5854430 0.6708861 0.04382348
# 6 0.01265823     10 0.5379747 0.6392405 0.04288370
# 7 0.01000000     11 0.5253165 0.6360759 0.04278801
#
# Variable importance
# day.charge     day.mins    svc.calls   eve.charge     eve.mins        vmail   vmail.msgs
# 25           25           11            9            9            7            7
# night.mins night.charge    eve.calls         area   intl.calls
# 1            1            1            1            1
#
# Node number 1: 2222 observations,    complexity param=0.09335443
# predicted class=No   expected loss=0.1422142  P(node) =1
# class counts:  1906   316
# probabilities: 0.858 0.142
# left son=2 (2087 obs) right son=3 (135 obs)
# Primary splits:
#     day.mins    < 265.45 to the left,  improve=62.208830, (0 missing)
# day.charge  < 45.125 to the left,  improve=62.208830, (0 missing)
# svc.calls   < 3.5    to the left,  improve=47.836440, (0 missing)
# intl.mins   < 13.15  to the left,  improve= 8.433701, (0 missing)
# intl.charge < 3.55   to the left,  improve= 8.433701, (0 missing)
# Surrogate splits:
#     day.charge < 45.125 to the left,  agree=1.00, adj=1.000, (0 split)
# eve.calls  < 155.5  to the left,  agree=0.94, adj=0.007, (0 split)
#
# Node number 2: 2087 observations,    complexity param=0.0806962
# predicted class=No   expected loss=0.1121227  P(node) =0.9392439
# class counts:  1853   234
# probabilities: 0.888 0.112
# left son=4 (1914 obs) right son=5 (173 obs)
# Primary splits:
#     svc.calls   < 3.5    to the left,  improve=50.993710, (0 missing)
# intl.mins   < 13.15  to the left,  improve= 7.260572, (0 missing)
# intl.charge < 3.55   to the left,  improve= 7.260572, (0 missing)
# day.mins    < 236.15 to the left,  improve= 5.894054, (0 missing)
# day.charge  < 40.145 to the left,  improve= 5.894054, (0 missing)
#
# Node number 3: 135 observations,    complexity param=0.09335443
# predicted class=Yes  expected loss=0.3925926  P(node) =0.06075608
# class counts:    53    82
# probabilities: 0.393 0.607
# left son=6 (40 obs) right son=7 (95 obs)
# Primary splits:
#     vmail      splits as  RL,         improve=26.456240, (0 missing)
# vmail.msgs < 9.5    to the right, improve=26.456240, (0 missing)
# eve.mins   < 149.15 to the left,  improve= 8.096408, (0 missing)
# eve.charge < 12.675 to the left,  improve= 8.096408, (0 missing)
# day.mins   < 286.9  to the left,  improve= 7.256331, (0 missing)
# Surrogate splits:
#     vmail.msgs  < 9.5    to the right, agree=1.000, adj=1.000, (0 split)
# night.calls < 54.5   to the left,  agree=0.719, adj=0.050, (0 split)
# eve.mins    < 280.9  to the right, agree=0.711, adj=0.025, (0 split)
# eve.charge  < 23.875 to the right, agree=0.711, adj=0.025, (0 split)
# night.mins  < 110.3  to the left,  agree=0.711, adj=0.025, (0 split)
#
# Node number 4: 1914 observations,    complexity param=0.01582278
# predicted class=No   expected loss=0.07889237  P(node) =0.8613861
# class counts:  1763   151
# probabilities: 0.921 0.079
# left son=8 (1605 obs) right son=9 (309 obs)
# Primary splits:
#     day.mins    < 223.25 to the left,  improve=10.352100, (0 missing)
# day.charge  < 37.95  to the left,  improve=10.352100, (0 missing)
# intl.mins   < 13.15  to the left,  improve= 7.036330, (0 missing)
# intl.charge < 3.55   to the left,  improve= 7.036330, (0 missing)
# eve.mins    < 245.35 to the left,  improve= 3.920513, (0 missing)
# Surrogate splits:
#     day.charge < 37.95  to the left,  agree=1, adj=1, (0 split)
#
# Node number 5: 173 observations,    complexity param=0.0806962
# predicted class=No   expected loss=0.4797688  P(node) =0.07785779
# class counts:    90    83
# probabilities: 0.520 0.480
# left son=10 (84 obs) right son=11 (89 obs)
# Primary splits:
#     day.mins   < 174.35 to the right, improve=34.494550, (0 missing)
# day.charge < 29.64  to the right, improve=34.494550, (0 missing)
# eve.mins   < 212.35 to the right, improve= 6.050862, (0 missing)
# eve.charge < 18.05  to the right, improve= 6.050862, (0 missing)
# svc.calls  < 4.5    to the left,  improve= 3.403978, (0 missing)
# Surrogate splits:
#     day.charge < 29.64  to the right, agree=1.000, adj=1.000, (0 split)
# area       < 462.5  to the left,  agree=0.572, adj=0.119, (0 split)
# eve.mins   < 233.55 to the right, agree=0.555, adj=0.083, (0 split)
# eve.charge < 19.85  to the right, agree=0.555, adj=0.083, (0 split)
# svc.calls  < 4.5    to the left,  agree=0.555, adj=0.083, (0 split)
#
# Node number 6: 40 observations
# predicted class=No   expected loss=0.125  P(node) =0.0180018
# class counts:    35     5
# probabilities: 0.875 0.125
#
# Node number 7: 95 observations,    complexity param=0.02531646
# predicted class=Yes  expected loss=0.1894737  P(node) =0.04275428
# class counts:    18    77
# probabilities: 0.189 0.811
# left son=14 (10 obs) right son=15 (85 obs)
# Primary splits:
#     eve.mins   < 142.5  to the left,  improve=11.284830, (0 missing)
# eve.charge < 12.11  to the left,  improve=11.284830, (0 missing)
# day.mins   < 277.75 to the left,  improve= 3.801658, (0 missing)
# day.charge < 47.22  to the left,  improve= 3.801658, (0 missing)
# intl.mins  < 8.25   to the left,  improve= 3.438947, (0 missing)
# Surrogate splits:
#     eve.charge < 12.11  to the left,  agree=1, adj=1, (0 split)
#
# Node number 8: 1605 observations
# predicted class=No   expected loss=0.05607477  P(node) =0.7223222
# class counts:  1515    90
# probabilities: 0.944 0.056
#
# Node number 9: 309 observations,    complexity param=0.01582278
# predicted class=No   expected loss=0.197411  P(node) =0.1390639
# class counts:   248    61
# probabilities: 0.803 0.197
# left son=18 (282 obs) right son=19 (27 obs)
# Primary splits:
#     eve.mins    < 266.7  to the left,  improve=11.053760, (0 missing)
# eve.charge  < 22.67  to the left,  improve=11.053760, (0 missing)
# intl.mins   < 13.85  to the left,  improve= 6.547385, (0 missing)
# intl.charge < 3.74   to the left,  improve= 6.547385, (0 missing)
# vmail       splits as  RL,         improve= 6.208384, (0 missing)
# Surrogate splits:
#     eve.charge  < 22.67  to the left,  agree=1.000, adj=1.000, (0 split)
# intl.mins   < 2.05   to the right, agree=0.919, adj=0.074, (0 split)
# intl.charge < 0.555  to the right, agree=0.919, adj=0.074, (0 split)
#
# Node number 10: 84 observations,    complexity param=0.01265823
# predicted class=No   expected loss=0.1547619  P(node) =0.03780378
# class counts:    71    13
# probabilities: 0.845 0.155
# left son=20 (74 obs) right son=21 (10 obs)
# Primary splits:
#     eve.mins   < 135.1  to the right, improve=6.749163, (0 missing)
# eve.charge < 11.485 to the right, improve=6.749163, (0 missing)
# day.calls  < 97.5   to the left,  improve=1.676190, (0 missing)
# eve.calls  < 94.5   to the right, improve=1.116529, (0 missing)
# intl.mins  < 13.3   to the left,  improve=1.104459, (0 missing)
# Surrogate splits:
#     eve.charge < 11.485 to the right, agree=1, adj=1, (0 split)
#
# Node number 11: 89 observations,    complexity param=0.02056962
# predicted class=Yes  expected loss=0.2134831  P(node) =0.04005401
# class counts:    19    70
# probabilities: 0.213 0.787
# left son=22 (32 obs) right son=23 (57 obs)
# Primary splits:
#     eve.mins   < 212.35 to the right, improve=8.203430, (0 missing)
# eve.charge < 18.05  to the right, improve=8.203430, (0 missing)
# day.mins   < 160.2  to the right, improve=4.938890, (0 missing)
# day.charge < 27.235 to the right, improve=4.938890, (0 missing)
# night.mins < 173.05 to the right, improve=2.111222, (0 missing)
# Surrogate splits:
#     eve.charge   < 18.05  to the right, agree=1.000, adj=1.000, (0 split)
# night.mins   < 285.6  to the right, agree=0.663, adj=0.062, (0 split)
# night.charge < 12.855 to the right, agree=0.663, adj=0.062, (0 split)
# intl.mins    < 12.5   to the right, agree=0.663, adj=0.062, (0 split)
# intl.charge  < 3.375  to the right, agree=0.663, adj=0.062, (0 split)
#
# Node number 14: 10 observations
# predicted class=No   expected loss=0.1  P(node) =0.00450045
# class counts:     9     1
# probabilities: 0.900 0.100
#
# Node number 15: 85 observations
# predicted class=Yes  expected loss=0.1058824  P(node) =0.03825383
# class counts:     9    76
# probabilities: 0.106 0.894
#
# Node number 18: 282 observations
# predicted class=No   expected loss=0.1560284  P(node) =0.1269127
# class counts:   238    44
# probabilities: 0.844 0.156
#
# Node number 19: 27 observations,    complexity param=0.01582278
# predicted class=Yes  expected loss=0.3703704  P(node) =0.01215122
# class counts:    10    17
# probabilities: 0.370 0.630
# left son=38 (8 obs) right son=39 (19 obs)
# Primary splits:
#     vmail      splits as  RL,         improve=9.013645, (0 missing)
# vmail.msgs < 5.5    to the right, improve=9.013645, (0 missing)
# intl.calls < 3.5    to the right, improve=1.959259, (0 missing)
# eve.mins   < 283.6  to the right, improve=1.792593, (0 missing)
# eve.charge < 24.11  to the right, improve=1.792593, (0 missing)
# Surrogate splits:
#     vmail.msgs   < 5.5    to the right, agree=1.000, adj=1.00, (0 split)
# night.mins   < 254    to the right, agree=0.852, adj=0.50, (0 split)
# night.charge < 11.43  to the right, agree=0.852, adj=0.50, (0 split)
# eve.calls    < 79.5   to the left,  agree=0.778, adj=0.25, (0 split)
#
# Node number 20: 74 observations
# predicted class=No   expected loss=0.08108108  P(node) =0.03330333
# class counts:    68     6
# probabilities: 0.919 0.081
#
# Node number 21: 10 observations
# predicted class=Yes  expected loss=0.3  P(node) =0.00450045
# class counts:     3     7
# probabilities: 0.300 0.700
#
# Node number 22: 32 observations,    complexity param=0.02056962
# predicted class=No   expected loss=0.5  P(node) =0.01440144
# class counts:    16    16
# probabilities: 0.500 0.500
# left son=44 (13 obs) right son=45 (19 obs)
# Primary splits:
#     day.mins   < 151    to the right, improve=10.947370, (0 missing)
# day.charge < 25.67  to the right, improve=10.947370, (0 missing)
# intl.calls < 5.5    to the right, improve= 3.000000, (0 missing)
# eve.mins   < 219.8  to the left,  improve= 1.333333, (0 missing)
# eve.charge < 18.68  to the left,  improve= 1.333333, (0 missing)
# Surrogate splits:
#     day.charge < 25.67  to the right, agree=1.000, adj=1.000, (0 split)
# eve.mins   < 219.8  to the left,  agree=0.719, adj=0.308, (0 split)
# eve.charge < 18.68  to the left,  agree=0.719, adj=0.308, (0 split)
# intl.calls < 7.5    to the right, agree=0.688, adj=0.231, (0 split)
# eve.calls  < 111.5  to the right, agree=0.656, adj=0.154, (0 split)
#
# Node number 23: 57 observations
# predicted class=Yes  expected loss=0.05263158  P(node) =0.02565257
# class counts:     3    54
# probabilities: 0.053 0.947
#
# Node number 38: 8 observations
# predicted class=No   expected loss=0  P(node) =0.00360036
# class counts:     8     0
# probabilities: 1.000 0.000
#
# Node number 39: 19 observations
# predicted class=Yes  expected loss=0.1052632  P(node) =0.008550855
# class counts:     2    17
# probabilities: 0.105 0.895
#
# Node number 44: 13 observations
# predicted class=No   expected loss=0  P(node) =0.005850585
# class counts:    13     0
# probabilities: 1.000 0.000
#
# Node number 45: 19 observations
# predicted class=Yes  expected loss=0.1578947  P(node) =0.008550855
# class counts:     3    16
# probabilities: 0.158 0.842
fit;
# n= 2222
#
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
#
# 1) root 2222 316 No (0.85778578 0.14221422)
# 2) day.mins< 265.45 2087 234 No (0.88787734 0.11212266)
# 4) svc.calls< 3.5 1914 151 No (0.92110763 0.07889237)
# 8) day.mins< 223.25 1605  90 No (0.94392523 0.05607477) *
#     9) day.mins>=223.25 309  61 No (0.80258900 0.19741100)
# 18) eve.mins< 266.7 282  44 No (0.84397163 0.15602837) *
#     19) eve.mins>=266.7 27  10 Yes (0.37037037 0.62962963)
# 38) vmail=yes 8   0 No (1.00000000 0.00000000) *
#     39) vmail=no 19   2 Yes (0.10526316 0.89473684) *
#         5) svc.calls>=3.5 173  83 No (0.52023121 0.47976879)
# 10) day.mins>=174.35 84  13 No (0.84523810 0.15476190)
# 20) eve.mins>=135.1 74   6 No (0.91891892 0.08108108) *
#     21) eve.mins< 135.1 10   3 Yes (0.30000000 0.70000000) *
#     11) day.mins< 174.35 89  19 Yes (0.21348315 0.78651685)
# 22) eve.mins>=212.35 32  16 No (0.50000000 0.50000000)
# 44) day.mins>=151 13   0 No (1.00000000 0.00000000) *
#     45) day.mins< 151 19   3 Yes (0.15789474 0.84210526) *
#     23) eve.mins< 212.35 57   3 Yes (0.05263158 0.94736842) *
#     3) day.mins>=265.45 135  53 Yes (0.39259259 0.60740741)
# 6) vmail=yes 40   5 No (0.87500000 0.12500000) *
#     7) vmail=no 95  18 Yes (0.18947368 0.81052632)
#     14) eve.mins< 142.5 10   1 No (0.90000000 0.10000000) *
#     15) eve.mins>=142.5 85   9 Yes (0.10588235 0.89411765) *
#
# Loss Matrix
# The next goal is to incorporate a loss matrix in to the classification tree: these are a parallel
# to the profit matrix from lectures. A loss matrix is used to weight misclassifications
# differently. In other words, different problems may mean that a false positive (type I error)
# and false negative (type II error) are not equally bad. For example, quite often in medical
# screening a false negative is far worse (we miss that the person has a disease) than a
# false positive (we suspect they have it when they don’t and send for further testing). Our
# classification tree can take this into consideration by weighting how much to penalise each
# incorrect classification in a given choice of split.
# Note: due to the quirk of R ordering factors alphabetically, you need to be careful about the
# order of false positive and false negative in the above matrix. Here, our churn factor is
# yes/no, so no is first (‘n’ being before ‘y’) and so the first row/column is actual/predicted
# for no.
# Fitting with a loss matrix
fit <- rpart(churn ~ ., data = train,
             parms = list(split = "gini",
                          loss = matrix(c(0, 12, 16, 0),
                                        byrow = TRUE, nrow = 2)),
             control = rpart.control(cp = 0.001));
fit;
# n= 2222
#
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
#
# 1) root 2222 5056 No (0.85778578 0.14221422)
# 2) day.mins< 265.45 2087 3744 No (0.88787734 0.11212266)
# 4) svc.calls< 3.5 1914 2416 No (0.92110763 0.07889237)
# 8) day.mins< 223.25 1605 1440 No (0.94392523 0.05607477)
# 16) intl.mins< 13.15 1386  944 No (0.95743146 0.04256854)
# 32) intl.calls>=2.5 1111  448 No (0.97479748 0.02520252) *
#     33) intl.calls< 2.5 275  496 No (0.88727273 0.11272727)
# 66) eve.mins< 249.15 224  288 No (0.91964286 0.08035714)
# 132) eve.mins>=189.7 114   48 No (0.97368421 0.02631579) *
#     133) eve.mins< 189.7 110  240 No (0.86363636 0.13636364)
# 266) eve.mins< 159.95 58   16 No (0.98275862 0.01724138) *
#     267) eve.mins>=159.95 52  224 No (0.73076923 0.26923077)
# 534) eve.calls>=104 19   32 No (0.89473684 0.10526316) *
#     535) eve.calls< 104 33  192 No (0.63636364 0.36363636)
# 1070) area>=411.5 24   96 No (0.75000000 0.25000000)
# 2140) night.calls< 99.5 11    0 No (1.00000000 0.00000000) *
#     2141) night.calls>=99.5 13   84 Yes (0.53846154 0.46153846) *
#     1071) area< 411.5 9   36 Yes (0.33333333 0.66666667) *
#     67) eve.mins>=249.15 51  208 No (0.74509804 0.25490196)
# 134) night.calls< 115 36   96 No (0.83333333 0.16666667) *
#     135) night.calls>=115 15   96 Yes (0.53333333 0.46666667) *
#     17) intl.mins>=13.15 219  496 No (0.85844749 0.14155251)
# 34) intl.mins>=14.55 85   96 No (0.92941176 0.07058824) *
#     35) intl.mins< 14.55 134  400 No (0.81343284 0.18656716)
# 70) eve.mins< 166.25 32   32 No (0.93750000 0.06250000) *
#     71) eve.mins>=166.25 102  368 No (0.77450980 0.22549020)
# 142) intl.calls< 5.5 70  176 No (0.84285714 0.15714286)
# 284) intl.calls>=3.5 25   16 No (0.96000000 0.04000000) *
#     285) intl.calls< 3.5 45  160 No (0.77777778 0.22222222)
# 570) intl.calls< 2.5 18   16 No (0.94444444 0.05555556) *
#     571) intl.calls>=2.5 27  144 No (0.66666667 0.33333333)
# 1142) day.mins< 165.3 13   32 No (0.84615385 0.15384615) *
#     1143) day.mins>=165.3 14   84 Yes (0.50000000 0.50000000) *
#     143) intl.calls>=5.5 32  192 No (0.62500000 0.37500000)
# 286) svc.calls>=1.5 17   32 No (0.88235294 0.11764706) *
#     287) svc.calls< 1.5 15   60 Yes (0.33333333 0.66666667) *
#     9) day.mins>=223.25 309  976 No (0.80258900 0.19741100)
# 18) eve.mins< 266.7 282  704 No (0.84397163 0.15602837)
# 36) intl.mins< 13.85 257  512 No (0.87548638 0.12451362)
# 72) intl.calls>=2.5 188  240 No (0.92021277 0.07978723)
# 144) eve.mins< 245.2 167  144 No (0.94610778 0.05389222) *
#     145) eve.mins>=245.2 21   96 No (0.71428571 0.28571429)
# 290) eve.mins>=255.15 11    0 No (1.00000000 0.00000000) *
#     291) eve.mins< 255.15 10   48 Yes (0.40000000 0.60000000) *
#     73) intl.calls< 2.5 69  272 No (0.75362319 0.24637681)
# 146) day.calls>=86 58  160 No (0.82758621 0.17241379)
# 292) day.mins< 236.25 29   16 No (0.96551724 0.03448276) *
#     293) day.mins>=236.25 29  144 No (0.68965517 0.31034483)
# 586) vmail.msgs>=12.5 9    0 No (1.00000000 0.00000000) *
#     587) vmail.msgs< 12.5 20  132 Yes (0.55000000 0.45000000)
# 1174) night.mins< 172.9 8   16 No (0.87500000 0.12500000) *
#     1175) night.mins>=172.9 12   48 Yes (0.33333333 0.66666667) *
#     147) day.calls< 86 11   48 Yes (0.36363636 0.63636364) *
#     37) intl.mins>=13.85 25  156 Yes (0.52000000 0.48000000)
# 74) day.calls< 90 7   16 No (0.85714286 0.14285714) *
#     75) day.calls>=90 18   84 Yes (0.38888889 0.61111111) *
#     19) eve.mins>=266.7 27  120 Yes (0.37037037 0.62962963)
# 38) vmail=yes 8    0 No (1.00000000 0.00000000) *
#     39) vmail=no 19   24 Yes (0.10526316 0.89473684) *
#         5) svc.calls>=3.5 173 1080 Yes (0.52023121 0.47976879)
# 10) day.mins>=174.35 84  208 No (0.84523810 0.15476190)
# 20) eve.mins>=135.1 74   96 No (0.91891892 0.08108108) *
#     21) eve.mins< 135.1 10   36 Yes (0.30000000 0.70000000) *
#     11) day.mins< 174.35 89  228 Yes (0.21348315 0.78651685)
# 22) eve.mins>=212.35 32  192 Yes (0.50000000 0.50000000)
# 44) day.mins>=151 13    0 No (1.00000000 0.00000000) *
#     45) day.mins< 151 19   36 Yes (0.15789474 0.84210526) *
#     23) eve.mins< 212.35 57   36 Yes (0.05263158 0.94736842) *
#     3) day.mins>=265.45 135  636 Yes (0.39259259 0.60740741)
# 6) vmail.msgs>=9.5 40   80 No (0.87500000 0.12500000) *
#     7) vmail.msgs< 9.5 95  216 Yes (0.18947368 0.81052632)
# 14) eve.mins< 142.5 10   16 No (0.90000000 0.10000000) *
#     15) eve.mins>=142.5 85  108 Yes (0.10588235 0.89411765) *
sum(c(0,12) %*% t(predict(fit, subset(test, test$churn=="No"), type="prob")));
# [1] 900.2784
sum(c(16,0) %*% t(predict(fit, subset(test, test$churn=="Yes"), type="prob")));
# [1] 1179.777
calcLoss <- function(p) { sum(c(0, 12) %*%
                                  t(predict(fit,
                                            subset(test, test$churn=="No"),
                                            type = "prob") > p))
                        + sum(c(16, 0) %*%
                                  t(predict(fit,
                                            subset(test, test$churn=="Yes"),
                                            type = "prob") < p))};
p <- seq(0, 1, length.out = 100);
loss <- sapply(p, calcLoss);
graphics.off();
dev.off();
par(mfrow=c(1,1), mar=c(3,3,3,0), tcl=0.5, mgp=c(0.6,0.6,0.6));
plot(p, loss, type = "b");
# Lab 4 Exercise 7
# Approximately what probability would you use as the threshold
# between classes for the loss matrix which we defined?
p;
# [1] 0.00000000 0.01010101 0.02020202
# [4] 0.03030303 0.04040404 0.05050505
# [7] 0.06060606 0.07070707 0.08080808
# [10] 0.09090909 0.10101010 0.11111111
# [13] 0.12121212 0.13131313 0.14141414
# [16] 0.15151515 0.16161616 0.17171717
# [19] 0.18181818 0.19191919 0.20202020
# [22] 0.21212121 0.22222222 0.23232323
# [25] 0.24242424 0.25252525 0.26262626
# [28] 0.27272727 0.28282828 0.29292929
# [31] 0.30303030 0.31313131 0.32323232
# [34] 0.33333333 0.34343434 0.35353535
# [37] 0.36363636 0.37373737 0.38383838
# [40] 0.39393939 0.40404040 0.41414141
# [43] 0.42424242 0.43434343 0.44444444
# [46] 0.45454545 0.46464646 0.47474747
# [49] 0.48484848 0.49494949 0.50505051
# [52] 0.51515152 0.52525253 0.53535354
# [55] 0.54545455 0.55555556 0.56565657
# [58] 0.57575758 0.58585859 0.59595960
# [61] 0.60606061 0.61616162 0.62626263
# [64] 0.63636364 0.64646465 0.65656566
# [67] 0.66666667 0.67676768 0.68686869
# [70] 0.69696970 0.70707071 0.71717172
# [73] 0.72727273 0.73737374 0.74747475
# [76] 0.75757576 0.76767677 0.77777778
# [79] 0.78787879 0.79797980 0.80808081
# [82] 0.81818182 0.82828283 0.83838384
# [85] 0.84848485 0.85858586 0.86868687
# [88] 0.87878788 0.88888889 0.89898990
# [91] 0.90909091 0.91919192 0.92929293
# [94] 0.93939394 0.94949495 0.95959596
# [97] 0.96969697 0.97979798 0.98989899
# [100] 1.00000000
loss;
# [1]    0    0    0    0    0    0  384
# [8]  384  384  384  384 1296 1296 1296
# [15] 1296 1296 1440 1440 1440 1440 1440
# [22] 1440 1440 1440 1440 1440 1440 1440
# [29] 1440 1440 1488 1488 1488 1552 1552
# [36] 1552 1568 1568 1568 1584 1616 1616
# [43] 1616 1616 1616 1616 1616 1616 1616
# [50] 1616 1616 1616 1616 1648 1664 1664
# [57] 1664 1664 1664 1664 1664 1664 1664
# [64] 1664 1664 1664 1664 1664 1664 1664
# [71] 1664 1664 1664 1664 1664 1664 1664
# [78] 1664 1664 1664 1664 1664 1664 1696
# [85] 1712 1728 1728 1760 1792 1808 1808
# [92] 1904 1904 2016 2160 2160 2224 2512
# [99] 2592 2592
p[which.min(loss)];
# [1] 0
#
# Lab 4 Exercise 8
fit_4p8 <- rpart(churn ~ ., data = train,
             parms = list(split = "gini",
                          loss = matrix(c(0, 12, 500, 0),
                                        byrow = TRUE, nrow = 2)),
             control = rpart.control(cp = 0.001));
fit_4p8;
sum(c(0,12) %*% t(predict(fit_4p8, subset(test, test$churn=="No"), type="prob")));
# [1] 900.2784
sum(c(500,0) %*% t(predict(fit_4p8, subset(test, test$churn=="Yes"), type="prob")));
# [1] 1179.777
calcLoss_4p8 <- function(p) { sum(c(0, 12) %*%
                                  t(predict(fit_4p8,
                                            subset(test, test$churn=="No"),
                                            type = "prob") > p))
    + sum(c(500, 0) %*%
              t(predict(fit_4p8,
                        subset(test, test$churn=="Yes"),
                        type = "prob") < p))};
loss_4p8 <- sapply(p, calcLoss_4p8);
graphics.off();
dev.off();
par(mfrow=c(1,1), mar=c(3,3,3,0), tcl=0.5, mgp=c(0.6,0.6,0.6));
plot(p, loss_4p8, type = "b", color = "red");
plot(p, loss, type = "b", color = "blue");
p;
loss_4p8;
p[which.min(loss_4p8)];


## Lab 5 More programming concepts and model evaluation
remove(list = ls());
graphics.off();
dev.off();
# Example if statement
i = rnorm(1);
i;
if(i > 0.25) {
    cat("i is greater than a quarter")
} else {
    cat("i is less than or equal to a quarter")
}
# Lab 5 Exercise 1
# Use R to simulate a fair coin toss. Code should print "Heads" or "Tails"
coin_toss <- function(k) {
    i <- seq(0, 1, length.out = 10000);
    toss <- sample(i, 1);
    for (i in length(k)){
        if (toss > 0.5) {return("Heads");}
        else {return("Tails");}
        }
}
x <- data.frame(sample(seq(0, 1, length.out = 1000000)));
tosses <- c(apply(X = x, FUN = coin_toss, MARGIN = 1));
prop.table(table(tosses));
# tosses
# Heads    Tails
# 0.500536 0.499464
#
# Example for loop
total <- 0;
upto <- 10;
for(j in 1:upto) {
    total <- total + log(j);
    cat("The natural log of", j, "is", log(j), "\n");
}
# The natural log of 1 is 0
# The natural log of 2 is 0.6931472
# The natural log of 3 is 1.098612
# The natural log of 4 is 1.386294
# The natural log of 5 is 1.609438
# The natural log of 6 is 1.791759
# The natural log of 7 is 1.94591
# The natural log of 8 is 2.079442
# The natural log of 9 is 2.197225
# The natural log of 10 is 2.302585
cat("The sum of the natural logs of 1 to", upto, "is", total);
# The sum of the natural logs of 1 to 10 is 15.10441
#
# Lab 5 Exercise 2
# Use a for loop to simulate 100 tosses of a coin.
# Count how many heads you get and store in a
# variable called total which prints after the loop.
total <- function(t){
    heads <- 0;
    for (j in 1:t){
        toss <- coin_toss(1);
        if (toss=="Heads") {heads <- heads + 1;}
    }
    cat("There are", heads, "heads in", t, "tosses. \n");
    return(heads);}
total(100);
#
# Example function
drawCards = function(number) {
    faceValues = c(1:10, "Jack", "Queen", "King");
    suits = c("Hearts", "Diamonds", "Spades", "Clubs");
    f = sample(faceValues, number, replace=TRUE);
    s = sample(suits, number, replace=TRUE);
    paste(f, "of", s);
}
drawCards(5);
# Lab 5 Exercise 3
# Create a function called tossCoin. It sould take
# a single arguement for how many coins to toss
# and return just the total number of heads.
tossCoin <- function(k){
    heads <- 0;
    for(j in i:k){
        if (coin_toss(1)=="Heads"){heads <- heads + 1;}}
    return(heads);}
tossCoin(10);
# [1] 6
tossCoin(100);
# [1] 57
tossCoin(1000);
# [1] 512
tossCoin(10000);
# [1] 5095
#
# Lab 5 Exercise 4
churn <- read.csv("churn.csv", stringsAsFactors = FALSE);
# Lab 5 Exercise 5
library(rpart);
#
test_rows <- sample.int(nrow(churn), nrow(churn)/3);
test <- churn[test_rows, ];
train <- churn[-test_rows, ];
fit <- rpart(churn ~ ., data = train, parms = list(split = 'gini'));
fit;
probs <- predict(fit, test)[, 2];
probs;
# Confusion Matrix
makePrediction <- function(probYes, cutoff) {
    prediction <- vector(length=length(probYes))
    for(i in 1:length(prediction)) {
        if(prediction[i] > cutoff) {
            prediction[i] = "Yes";
        } else {
            prediction[i] = "No";
        }
    }
    factor(prediction, levels=c("No", "Yes"));
}
pred <- makePrediction(probs, 0.4);
table(pred, test$churn, dnn=c("Predicted", "Actual"));
prop.table(table(pred, test$churn, dnn=c("Predicted", "Actual")));
# ROC Receiver Operating Characteristic
drawROC <- function(fit, test) {
    alpha <- seq(0, 1, length.out=100);
    tp <- vector(length=100);
    fp <- vector(length=100);
    probs = predict(fit, test)[,2];
    for(i in 1:100) {
        pred = makePrediction(probs, 0.4);
        confusion = table(pred, test$churn, dnn=c("Predicted", "Actual"));
        tp[i] = confusion[2,2]/(confusion[1,2]+confusion[2,2]);
        fp[i] = confusion[2,1]/(confusion[1,1]+confusion[2,1]);
    }
    plot(fp, tp, type="l");
}
# Lab 5 Exercise 6
# Understand ROC and run on the model we fitted to train data.
graphics.off();
par(mfrow=c(1,1), mar=c(4,4,4,0), tcl=0.2, mgp=c(0.6,0.6,0.6));
drawROC(fit, test);
