# GettingAndCleaningDataCourseProject
Coursera

This repository hosts the course project for the Coursera course "Getting and Cleaning Data", Week 3.

Submission requirements:
1) a tidy data set as described
2) a link to a Github repository with the script for performing the analysis
3) a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called CodeBook.md.

Task was to create one R script called "run_analysis.R" that does the following:
1. Downloads the dataset in case it does not already exist in my working directory.
2. Loads the activity data of both training and test datasets.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Loads the activity data for each dataset and merges the columns with the dataset
5. Merges the training and the test sets to create one single data set.
6. Uses descriptive activity names to name the activities in the data set
7. Appropriately labels the data set with descriptive variable names. 
8. From the data set in step 7, creates a second, independent tidy data set
with the average of each variable for each activity and each subject.

Result is shown as "tidy_data.txt".
