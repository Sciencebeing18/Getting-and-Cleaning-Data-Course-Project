Code Book for the Getting and Cleaning Data Course Project

THE SOURCE DATA:
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
 
 
 In order to obtain the secTidySet result and run_analysis.R these steps were followed:
 
 1.Merge the training and the test sets to create one data set.

2.Extract only the measurements on the mean and standard deviation for each measurement. 

3.Use descriptive activity names to name the activities in the data set

4.Appropriately label the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The variables in the code are:

subjecttrain, activitytrain, subjecttest, activitytest, featurestrain and featurestest contain the data from the downloaded files.

subject,features,activity and completeData a merge the previous datasets to further analysis.



Tidy.txt contains the final result of the project
