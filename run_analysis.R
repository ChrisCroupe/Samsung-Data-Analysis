## Getting and Cleaning Data Project
## Chris Croupe
## 02/13/2019

library(tidyverse)
library(plyr)


## 1
## Read the required data sets into the environment
## Data files
test_data <- read.table("X_test.txt")
train_data <- read.table("X_train.txt")
## Label files
test_labels <- read.table("y_test.txt")
train_labels <- read.table("y_train.txt")
## Subject files
test_subject <- read.table("subject_test.txt")
train_subject <- read.table("subject_train.txt")
## Feature file - for column lables
features <- read.table("features.txt")
## Combine the data files
combined_raw_data <- rbind(test_data, train_data)
## Combine the subject files
combined_subject_data <- rbind(test_subject, train_subject)
## Combine the label data
combined_label_data <- rbind(test_labels, train_labels)
## Add the feature names to the data files
colnames(combined_raw_data) <- features$V2
## Add Activity rows
combined_data <- cbind(combined_label_data, combined_raw_data)
## Add subject rows
combined_data <- cbind(combined_subject_data, combined_data)
## clean up 
rm(train_subject, train_labels, train_data, test_subject, test_labels, test_data, features, 
                combined_subject_data, combined_raw_data, combined_label_data)

## Give Subject and Activity columns correct names
colnames(combined_data)[1] <- "Subject"
colnames(combined_data)[2] <- "Activity"

## There are duplicate column names in this data set - remove duplicate column names
colnames(combined_data) <- make.unique(colnames(combined_data), sep = "_")


## 2
##Select the mean and standard deviation columns only
reduced_data <- select(combined_data, Subject, Activity, contains("mean()"), contains("std()"))
rm(combined_data)

## 3
## Give activities readable names
reduced_data$Activity <- mapvalues(reduced_data$Activity, from = c(1,2,3,4,5,6),
                                    to = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting","Standing", "Laying"))


## 4
## Give variables descriptive names
colnames(reduced_data) = gsub("^t", "Time Series ", colnames(reduced_data))
colnames(reduced_data) = gsub("^f", "Frequency Series ", colnames(reduced_data))
colnames(reduced_data) = gsub("Acc", " Accelerometer ", colnames(reduced_data))
colnames(reduced_data) = gsub("Gyro", " Gyroscope ", colnames(reduced_data))
colnames(reduced_data) = gsub("Mag", " Magnitude ", colnames(reduced_data))

## 5
## Create summary data set with average for each variable for each subject and activity
list <- colnames(reduced_data)
list <- list[3:68] ## get rid of Subject and Activity columns for use in "summariz_at" call
summary_mean_data <- ddply(reduced_data, c("Subject", "Activity"), summarize_at, list, mean)
rm(list) ## clean up

## Write output table
write.table(summary_mean_data, file = "run_analysis_output.txt", row.name = FALSE)

