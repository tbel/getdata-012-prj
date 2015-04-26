## Code Book for Getting and Cleaning Data Course Project (getdata-012-prj)
This describes the variables, the data, and any transformations and work performed

## Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

"step5dataset.txt" is a data set with the average of each variable for each activity and each subject.


#### Step 1 is to read the data from files into memory

```R
activity <- read.csv("dataset/activity_labels.txt", header=FALSE, col.names=c("aID", "activity"), sep=" ")
features <- read.csv("dataset/features.txt", header=FALSE, col.names=c("fID", "feature"), sep=" ")

s_train <- read.csv("dataset/train/subject_train.txt", header=FALSE, col.names=c("subject"))
s_test <- read.csv("dataset/test/subject_test.txt", header=FALSE, col.names=c("subject"))

train_act <- read.csv("dataset/train/Y_train.txt", header=FALSE, col.names=c("aID"))
test_act <- read.csv("dataset/test/Y_test.txt", header=FALSE, col.names=c("aID"))

train_data <- read.table("dataset/train/X_train.txt", heade=FALSE)
test_data <- read.table("dataset/test/X_test.txt", heade=FALSE)
```

#### Remove data we Won't use
* I chose to use dplyr package for 
* filter columns by text search word "mean" and "std" in them

```R
library(dplyr)
features<-filter(features, (grepl("mean", features$feature)) | (grepl("std", features$feature)))

train_data <- select(train_data, features$fID)
test_data <- select(test_data, features$fID)
```

#### Join train and test data sets

```R
data<-rbind(train_data, test_data)
subj <- rbind(s_train, s_test)
activities <- rbind(train_act, test_act)
# TEST
# nrow(data) == nrow(train_data) + nrow(test_data)
# nrow(subj)
# nrow(activities)
```

#### Bind all pieces together, subject + activity + variable data
```R
activities <- merge(activities, activity, by="aID", all = FALSE, sort=FALSE)

colnames(data) <- features$feature
data <- cbind(subj, activities) %>% select(c(1,3)) %>% cbind(data)
```

#### Step#5, find avg of each variable for each subject-activity pair
```R
aggdata<-aggregate(data[,c(-1,-2)],
          by=list(subject=data$subject, activity=data$activity),
          mean)
aggdata<-arrange(aggdata, subject, activity)
all_comb<-expand.grid(subject=sort(unique(aggdata$subject)), activity=sort(unique(aggdata$activity)))
aggdata <- merge(all_comb, aggdata, by=c("subject","activity"),all=TRUE)
write.table(aggdata, file="step5dataset.txt", row.name=FALSE)
```
