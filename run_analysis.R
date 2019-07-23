# Downloading the dataset
my_data <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                         destfile = "dataset.zip")

#Unzip the dataset
unzip("dataset.zip")

path=paste0(getwd(),"/UCI HAR Dataset")
train_path=paste0(path,"/train")
test_path=paste0(path,"/test")

###READING ALL FILES
#Reading training data - xtrain.txt and ytrain.txt
x_train = read.table(file.path(train_path, "X_train.txt"),header = FALSE)
y_train = read.table(file.path(train_path, "y_train.txt"),header = FALSE)
subject_train = read.table(file.path(train_path, "subject_train.txt"),header = FALSE)

#Reading the testing tables - x_test.txt and y_test.txt
x_test = read.table(file.path(test_path, "X_test.txt"),header = FALSE)
y_test = read.table(file.path(test_path, "y_test.txt"),header = FALSE)
subject_test = read.table(file.path(test_path, "subject_test.txt"),header = FALSE)

#Read the features data - features.txt
features = read.table(file.path(path, "features.txt"),header = FALSE)

#Read activity labels data - activity_labels.txt
activityLabels = read.table(file.path(path, "activity_labels.txt"),header = FALSE)

###ADDING APPRORIATE COLUMN NAMES FOR THE DATA
#Train Data
colnames(x_train) = features[,2]
colnames(y_train) = "activityId"
colnames(subject_train) = "subjectId"

#Test data
colnames(x_test) = features[,2]
colnames(y_test) = "activityId"
colnames(subject_test) = "subjectId"

#Using descriptive activity names to name the activities in the data set
colnames(activityLabels) <- c("activityId", "activityName")

###COMBINING ALL THE DATA
#Merging the train and test data 
merge_train = cbind(x_train, y_train, subject_train)
merge_test = cbind(x_test, y_test, subject_test)

#Merging all the data tables into One
merge_train_test = rbind(merge_train, merge_test)

#Read all the column names in the merged data
colNames = colnames(merge_train_test)

#Subset of all the mean and standards of the correspondonging activityID and subjectID 
mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) 
                | grepl("std.." , colNames))

#A subset of True mead_and_std
dataset_true_MeanAndStd <- merge_train_test[ , mean_and_std == TRUE]

#Merge mean_ad_std subsetted TRUE data with activities
datasetActivityNames = merge(dataset_true_MeanAndStd, activityLabels, by='activityId', all.x=TRUE)

#Cleaned data(Tidy dataset)
tidyset <- aggregate(. ~subjectId + activityId, datasetActivityNames, mean)
Final_Tidy_Data <- tidyset[order(tidyset$subjectId, tidyset$activityId),]

#The last step is to write the ouput to a text file 
write.table(Final_Tidy_Data, "Tidy_data.txt", row.name=FALSE)
