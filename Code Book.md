The run_analysis.R script takes you from downloading the data set to preparing the data as per the Coursera requirements.

1. Downloading the dataset
      - Data set downloaded to the folder named UCI HAR Dataset
            
2. Variables assigned
      - features <- features.txt : 561 rows, 2 columns. 
The features selected come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
      - activities <- activity_labels.txt : 6 rows, 2 columns 
List of activities performed when the corresponding measurements were taken and its codes (labels)
      - subj_test <- test/subject_test.txt : 2947 rows, 1 column 
contains test data of 9/30 volunteer test subjects being observed
      - x_test <- test/X_test.txt : 2947 rows, 561 columns 
contains recorded features test data
      - y_test <- test/y_test.txt : 2947 rows, 1 columns 
contains test data of activities’code labels
      - subj_train <- test/subject_train.txt : 7352 rows, 1 column 
contains train data of 21/30 volunteer subjects being observed
      - x_train <- test/X_train.txt : 7352 rows, 561 columns 
contains recorded features train data
      - y_train <- test/y_train.txt : 7352 rows, 1 columns 
contains train data of activities’code labels

3. Merges the training and the test sets to create one data set.
      - X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
      - Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
      - Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
      - Merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

4. Extracts only the measurements on the mean and standard deviation for each measurement
      - Tidy (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

5. Uses descriptive activity names to name the activities in the data set.
      - Entire numbers in code column of Tidy replaced with corresponding activity taken from second column of the  activities variable

6. Appropriately labels the data set with descriptive variable names
code column in Tidy renamed into activities.
      - All Acc in column’s name replaced by Accelerometer
      - All Gyro in column’s name replaced by Gyroscope
      - All BodyBody in column’s name replaced by Body
      - All Mag in column’s name replaced by Magnitude
      - All start with character f in column’s name replaced by Frequency
      - All start with character t in column’s name replaced by Time

7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
      - Tidy2 (180 rows, 88 columns) is created by sumarizing Tidy taking the means of each variable for each activity and each subject, after groupped by subject and activity.
      - Export Tidy2 into Tidy2.txt file.
