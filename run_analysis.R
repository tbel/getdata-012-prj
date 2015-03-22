# Reading raw data
activity <- read.csv("dataset/activity_labels.txt", header=FALSE, col.names=c("aID", "activity"), sep=" ")
features <- read.csv("dataset/features.txt", header=FALSE, col.names=c("fID", "feature"), sep=" ")

s_train <- read.csv("dataset/train/subject_train.txt", header=FALSE, col.names=c("subject"))
s_test <- read.csv("dataset/test/subject_test.txt", header=FALSE, col.names=c("subject"))

train_act <- read.csv("dataset/train/Y_train.txt", header=FALSE, col.names=c("aID"))
test_act <- read.csv("dataset/test/Y_test.txt", header=FALSE, col.names=c("aID"))

train_data <- read.table("dataset/train/X_train.txt", heade=FALSE)
test_data <- read.table("dataset/test/X_test.txt", heade=FALSE)

##########################
# taking only means and stds
library(dplyr)
features<-filter(features, (grepl("mean", features$feature)) | (grepl("std", features$feature)))

train_data <- select(train_data, features$fID)
test_data <- select(test_data, features$fID)

##########################
# denormalize (tidy)
data<-rbind(train_data, test_data)
subj <- rbind(s_train, s_test)
activities <- rbind(train_act, test_act)
# nrow(data) == nrow(train_data) + nrow(test_data)
# nrow(subj)
# nrow(activities)

##########################
# proper names for s & a
activities <- merge(activities, activity, by="aID", all = FALSE, sort=FALSE)
# head(activities)
colnames(data) <- features$feature
data <- cbind(subj, activities) %>% select(c(1,3)) %>% cbind(data)
# head(data)

##########################
# avg for activity,subject
head(data)
names(data)
aggdata<-aggregate(data[,c(-1,-2)],
          by=list(subject=data$subject, activity=data$activity),
          mean)
aggdata<-arrange(aggdata, subject, activity)

write.table(aggdata, file="step5dataset.txt", row.name=FALSE)


