library(plyr)

## get the data set
if (!file.exists("./clean_data")){dir.create("./clean_data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./clean_data/a3data.zip")
unzip(zipfile = "./clean_data/a3data.zip", exdir = "./clean_data")

## read all the files into R
subject_test <- read.table("./clean_data/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./clean_data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./clean_data/UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./clean_data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./clean_data/UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("./clean_data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./clean_data/UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("./clean_data/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./clean_data/UCI HAR Dataset/features.txt")

## 1. merge the training and test datasets
subject <- rbind(subject_test, subject_train)
merged_x <- rbind(x_train, x_test)
merged_y <- rbind(y_train, y_test)
colnames(subject) <- "subject"
colnames(merged_x) <- as.character(features[,2])
colnames(merged_y) <- "activity_label"
merged_data <- cbind(subject, merged_x, merged_y)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std <- features[grep("mean|std",features[,2], ignore.case = TRUE),]
extracted <- c(merged_x[, mean_std[,1]], subject, merged_y)


## 3. Uses descriptive activity names to name the activities in the data set
extracted$activity_label <- as.character(extracted$activity_label)
extracted$activity_label <- factor(extracted$activity_label, labels = as.character(activity_labels[,2]))

## 4. Appropriately labels the data set with descriptive variable names.
names(extracted) <- sub("Acc", "accelerometer", names(extracted))
names(extracted) <- sub("Gyro", "gyroscope", names(extracted))

## 5.
install.packages("data.table")
library(data.table)
extracted$merged_y <- as.factor(extracted$merged_y)
extracted$subject <- as.factor(extracted$subject)
extracted <- data.table(extracted)
tidy_data <- aggregate(. ~subject + merged_y, extracted, mean)
