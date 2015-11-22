# Coursera "Getting and Cleaning Data", Week 3, Course Project

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

setwd("~/Coursera")

library(reshape2)

filename <- "HARdataset.zip"

# Download dataset and unzip file:
if (!file.exists(filename)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, filename, method="curl")
}
if (!file.exists("getdata-projectfiles-UCI HAR Dataset")) {
  unzip(filename)
}

# Load "activity_lables.txt"
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activitylabels[,2])

# Load "features.txt"
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only data on mean and standard deviation
extractFeatures <- grep(".*mean.*|.*std.*", features[,2])
extractFeatures.names <- features[extractFeatures,2]
extractFeatures.names = gsub('-mean', 'Mean', extractFeatures.names)
extractFeatures.names = gsub('-std', 'Std', extractFeatures.names)
extractFeatures.names <- gsub('[-()]','',extractFeatures.names)

# Load and process X_test/y_test and X_train/y_train datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[extractFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[extractFeatures]
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge both train and test datasets and add descriptive activity labels
mergedData <- rbind(train, test)
colnames(mergedData) <- c("subject", "activity", extractFeatures.names)

# Convert Activities and Subjects into factors
mergedData$activity <- factor(mergedData$activity, levels = activitylabels[,1], labels = activitylabels[,2])
mergedData$subject <- as.factor(mergedData$subject)

# Create second, independent data set, with the mean of each variable for each activity and each subject
mergedData.melted <- melt(mergedData, id = c("subject", "activity"))
mergedData.means <- dcast(mergedData.melted, subject + activity ~ variable, mean)
write.table(mergedData.means, "tidy_data.txt", row.names = FALSE, quote = FALSE)
