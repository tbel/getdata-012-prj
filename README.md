## Getting and Cleaning Data Course Project (getdata-012-prj)
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

## Data for the project
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Assignment
You should create one R script called run_analysis.R that does the following. 

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 

* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Content
file | desc
---- | ----
README.md | this repository description
CodeBook.md | code book that describes the variables, the data, and any transformations and work performed
run_analysis.R | script doing main job: data cleanup, joins, aggregations
step5dataset.txt | tidy data set with the average of each variable for each activity and each subject

## Working with  the code
* clone the repo
* download data zip file for the project
* unzip into "dataset" folder into local repo folder
* run code from run_analysis.R
