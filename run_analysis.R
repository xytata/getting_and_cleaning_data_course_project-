# clean up workspace
rm(list=ls())
setwd('/Users/xytata/Coursera2/')

training = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
testing = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testing[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# clean features
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Merge training and test sets to one data set
entiredata = rbind(training, testing)

# Get only the data on mean and std. dev.
colsneeded <- grep(".*Mean.*|.*Std.*", features[,2])

# reduce the features table to what is needed
features <- features[colsneeded,]

# add the last two columns (subject and activity)
colsneeded <- c(colsneeded, 562, 563)

# remove the extra columns from entiredata
entiredata <- entiredata[,colsneeded]

# reassign column names (features) to entiredata
colnames(entiredata) <- c(features$V2, "Activity", "Subject")
colnames(entiredata) <- tolower(colnames(entiredata))

currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  entiredata$activity <- gsub(currentActivity, currentActivityLabel, entiredata$activity)
  currentActivity <- currentActivity + 1
}

entiredata$activity <- as.factor(entiredata$activity)
entiredata$subject <- as.factor(entiredata$subject)

tidydata = aggregate(entiredata, by=list(activity = entiredata$activity, subject=entiredata$subject), mean)

# Remove the subject and activity column
tidydata[,90] = NULL
tidydata[,89] = NULL

# export the tidyData set
write.table(tidydata, "tidydata.txt", row.name=FALSE, sep="\t")
