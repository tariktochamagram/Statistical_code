# Day 2 R script

# Building your own dataframe

rm(list=ls())  # clears all objects from the workspace

serial <- 1:10
sex <- c("F", "M", "M", "F", "F", "F", "M", "M", "F", "M")
weight <- c(56.4, 80.0, 65.7, 69.0, 67.4, 80.3, 65.0,
            60.0, 60.5, 50.5)
height <- c(165, 170, 171, 166, 162, 158, 168, 160, 162, 155)


mydat <- data.frame(serial, sex, weight, height)
mydat

######## Binding a column ##############################

years.edu <- c(16, 15, 18, 10, 13, 15, 17, 10, 15, 16)

# # Way 1
mydat2 <- cbind(mydat, years.edu)
mydat2



# Way 2
mydat$years.edu<- c(16, 15, 18, 10, 13, 15, 17, 10, 15, 16)
names(mydat)
mydat
head(mydat) #Check the updated dataset
# to see the updated dataset

### Binding row

mydat <- rbind(mydat, c(11, "F", 62.0, 165, 15))
tail(mydat)

####### Renaming variable names (column names)#############

names(mydat) # gives the actual names
names(mydat) <- c("id", "sex", "weight", "height", "years.edu")
head(mydat)


# Saving the data frame
save(list = "mydat", file = "mydat.Rdata")  # save  the data file 

######### Built-in data ################

data(mtcars)
row.names(mtcars)  # row names
names(mtcars) # column names

# tidyverse

install.packages("tidyverse")
library(tidyverse)


as_tibble(mydat)

# Import/export
mydata <- read_csv("data_comma.txt", skip = 3, col_names = TRUE)
mydata

mydata2 <- read_tsv("Data/data_space.txt", skip = 3, col_names = TRUE)
mydata2

mydata3 <- read_csv("Data/data_excel.csv", col_names = TRUE)
mydata3




###################################


id <- c(1:4)
marks <- c(20, 22, 18, 23)
grade <- c("A", "A", "B", "A")
grade_dat <- tibble(id, marks, grade)
grade_dat
write_csv(grade_dat, path = "new.grade.csv")


#########Data manipulation dplyr and tidyr##############

data(airquality)
airquality <- as.tibble(airquality)
airquality

dim(airquality)
str(airquality)

names(airquality)[1:3]
subset_1 <- select(airquality, Ozone:Wind)
head(subset_1)

subset_2 <- select(airquality, -(Ozone:Wind))
head(subset_2)

subset_3 <- select(airquality, ends_with("e"))
head(subset_3)[1:4, ]

ny.oz <- filter(airquality, Ozone > 60)
dim(ny.oz)
summary(ny.oz$Ozone)

ny.ot <- filter(airquality, Ozone > 60 & Temp > 80)
dim(ny.ot)
head(select(ny.ot, Ozone, Temp))

oz <- arrange(airquality, Ozone)
head(select(oz, Ozone, Day), 4)


ny_air2 <- rename(airquality, oz = Ozone, solar = Solar.R)
head(ny_air2, 4)

ny_air3 <- mutate(airquality,
                  oz.detrend = Ozone - mean(Ozone, na.rm = TRUE))
head(ny_air3, 4)


month <- group_by(airquality, Month)

summarize(month,
          oz = mean(Ozone, na.rm = T),
          solar = mean(Solar.R, na.rm = T))

group_by(airquality, Month) %>%
  summarize(oz = mean(Ozone, na.rm = T), tmp = mean(Temp, na.rm = T))

library(readxl)
marks <- read_excel("marks.xlsx")
head(marks)

marks_long <- marks %>%
  pivot_longer(!name, names_to = "year", values_to = "GPA")
marks_long

marks_wide <- marks_long %>%
  pivot_wider(names_from = "year", values_from = "GPA")
marks_wide

marks_long<-marks%>%
  pivot_longer(!name,names_to = "year", values_to="GPA")

marks_long
data("airquality")
airquality <- as.tibble(airquality)

