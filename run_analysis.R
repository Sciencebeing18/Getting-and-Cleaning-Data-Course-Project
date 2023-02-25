#Download the data. The data provided is in the zip file format
# Unzip dataSet to /data directory
unzip(zipfile="./R Prog/getdata_projectfiles_UCI HAR Dataset.zip",exdir="./data")
unzip(zipfile="./midtermdata/getdata_projectfiles_UCI HAR Dataset.zip",exdir="./midtermdata")
#defining the path where the new folder has been unziped
pathdata = file.path("./midtermdata", "UCI HAR Dataset")
#creating a file which has the file names
files = list.files(pathdata, recursive=TRUE)
#print files
files

#Reading training tables - xtrain / ytrain, subject train
xtrain = read.table(file.path(pathdata, "train", "X_train.txt"),header = FALSE)
ytrain = read.table(file.path(pathdata, "train", "y_train.txt"),header = FALSE)
subject_train = read.table(file.path(pathdata, "train", "subject_train.txt"),header = FALSE)
#Reading the testing tables
xtest = read.table(file.path(pathdata, "test", "X_test.txt"),header = FALSE)
ytest = read.table(file.path(pathdata, "test", "y_test.txt"),header = FALSE)
subject_test = read.table(file.path(pathdata, "test", "subject_test.txt"),header = FALSE)
#Reading the features data
features = read.table(file.path(pathdata, "features.txt"),header = FALSE)
#Reading activity labels data
activityLabels = read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)
##Appropriately labels the data set with descriptive variable names. 

#Assigning Variable names to train data
colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(subject_train) = "subjectId"
#Assigning Variable Names to test data
colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"
#Assigning variable name to activity labels
colnames(activityLabels) <- c('activityId','activityType')
#Merging the train and test data 
merg_train = cbind(ytrain, subject_train, xtrain)
merg_test = cbind(ytest, subject_test, xtest)
##Merge the training and the test sets to create one data set.

#Create the main data table merging both table tables 
AllInOne = rbind(merg_train, merg_test)
## Extracting only the measurements on the mean and standard deviation for each measurement

#Reading all the values that are available
colNames = colnames(AllInOne)
#Obtaining a subset of all means and standards
mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
#Creating a subset to get the required dataset
MeanAndStd <- AllInOne[ , mean_and_std == TRUE]
##Use descriptive activity names to name the activities in the data set
setWithActivityNames = merge(MeanAndStd, activityLabels, by='activityId', all.x=TRUE)
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Creating a new tidy set
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
#Obtain a text output for the same
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
