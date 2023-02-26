#Download the data. The data provided is in the zip file format
# Unzip dataSet to /data directory
unzip(zipfile="./R Prog/getdata_projectfiles_UCI HAR Dataset.zip",exdir="./data")

library(data.table)
library(dplyr)

#Reading training tables
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
#Reading the testing tables
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
#Reading the features data
featureNames <- read.table("./data/UCI HAR Dataset/features.txt")
#Reading activity labels data
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
##Appropriately labels the data set with descriptive variable names. 


#Merging the train and test data 
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)
#Naming the columns
colnames(features) <- t(featureNames[2])
##Merge the training and the test sets to create one data set.
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)


## Extracting only the measurements on the mean and standard deviation for each measurement
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completeData)
#Creating extractedData with selected columns of requiredColumns
extractedData <- completeData[,requiredColumns]
dim(extractedData)

##Uses descriptive activity names to name the activities in the data set
#changing the numeric type data into character to make it acceptable for activity names
extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}
#Factor activity variable
extractedData$Activity <- as.factor(extractedData$Activity)
##Appropriately labels the data set with descriptive variable names
names(extractedData)
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))


##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)
#Creating a new tidy set
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
#Obtain a text output for the same
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
