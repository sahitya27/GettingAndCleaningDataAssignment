
The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

    Download the dataset
        Dataset downloaded and extracted under the folder called UCI HAR Dataset

    Assign each data to variables
        features <- features.txt : 561 rows, 2 columns
        The features selected for this dataset comes from the accelerometer and gyroscope signals.
        activities <- activity_labels.txt : 6 rows, 2 columns
        List of activities performed when the corresponding measurements were taken and its identifier 
        subject_test <- test/subject_test.txt : 2947 rows, 1 column
        contains test data of 9/30 volunteer test subjects being observed
        x_test <- test/X_test.txt : 2947 rows, 561 columns
        contains recorded features test data
        y_test <- test/y_test.txt : 2947 rows, 1 columns
        contains test data of activities’code labels
        subject_train <- test/subject_train.txt : 7352 rows, 1 column
        contains train data of 21/30 volunteer subjects being observed
        x_train <- test/X_train.txt : 7352 rows, 561 columns
        contains recorded features train data
        y_train <- test/y_train.txt : 7352 rows, 1 columns
        contains train data of activities’code labels

    Merges the training and the test sets to create one data set
        merge_train (7352 rows, 563 columns) is created by merging x_train and y_train using cbind() function
        merge_test (2947 rows, 563 column) is created by merging x_test and y_test using cbind() function
        merge_train_test (10299 rows, 563 column) is created by merging Subject, merge_train and merge_test using rbind() function

    Extracts only the measurements on the mean and standard deviation for each measurement
        dataset_true_MeanAndStd (10299 rows, 82 columns) is created by subsetting merge_train_test

    Uses descriptive activity names to name the activities in the data set
        Entire numbers in code column of the dataset_true_MeanAndStd replaced with corresponding activity taken from second column of the activities variable

    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
        Final_Tidy_Data (180 rows, 82 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
        Export Final_Tidy_Data into Tidy_data.txt file.

