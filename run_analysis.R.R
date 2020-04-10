## Downloading File
if(!file.exists("data")){dir.create("data")}

fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="C:/Users/Herman/Documents/MDRP/Getting-and-Cleaning-Data-Assignment/data/Samsung.zip")

datedownloaded<-date()

## Reading data into R
if(!file.exists("UCI HAR Dataset")) {unzip("Samsung.zip")}
activity<- read.table("C:/Users/Herman/Documents/MDRP/Getting-and-Cleaning-Data-Assignment/data/UCI HAR Dataset/activity_labels.txt", 
                      sep="", header=FALSE, col.names=c("code", "activity"))
features<- read.table("C:/Users/Herman/Documents/MDRP/Getting-and-Cleaning-Data-Assignment/data/UCI HAR Dataset/features.txt", 
                      sep="", header=FALSE, col.names=c("n", "functions"))
subj_test<- read.table("C:/Users/Herman/Documents/MDRP/Getting-and-Cleaning-Data-Assignment/data/UCI HAR Dataset/test/subject_test.txt", 
                      sep="", header=FALSE, col.names="subject")
x_test<- read.table("C:/Users/Herman/Documents/MDRP/Getting-and-Cleaning-Data-Assignment/data/UCI HAR Dataset/test/X_test.txt", 
                       sep="", header=FALSE, col.names=features$functions)
y_test<- read.table("C:/Users/Herman/Documents/MDRP/Getting-and-Cleaning-Data-Assignment/data/UCI HAR Dataset/test/y_test.txt", 
                        sep="", header=FALSE, col.names = "code")
subj_train<-read.table("C:/Users/Herman/Documents/MDRP/Getting-and-Cleaning-Data-Assignment/data/UCI HAR Dataset/train/subject_train.txt", 
                        sep="", header=FALSE, col.names="subject")
x_train<-read.table("C:/Users/Herman/Documents/MDRP/Getting-and-Cleaning-Data-Assignment/data/UCI HAR Dataset/train/X_train.txt", 
                         sep="", header=FALSE, col.names=features$functions)
y_train<-read.table("C:/Users/Herman/Documents/MDRP/Getting-and-Cleaning-Data-Assignment/data/UCI HAR Dataset/train/y_train.txt", 
                        sep="", header=FALSE, col.names = "code")

##Loading dplyr
library(dplyr)

## Merging traning and test sets to create one data set
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
Subject <- rbind(subj_train, subj_test)
Merged_Data <- cbind(Subject, y, x)

## Extract only measurement on mean and sd for each measurement
Tidy <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

## Adding descriptive activity names to name the activities in data set
Tidy$code<-activity[Tidy$code,2]

## Labelling data with descriptive variable names
names(Tidy)[2] = "activity"
names(Tidy)<-gsub("Acc", "Accelerometer", names(Tidy))
names(Tidy)<-gsub("Gyro", "Gyroscope", names(Tidy))
names(Tidy)<-gsub("BodyBody", "Body", names(Tidy))
names(Tidy)<-gsub("Mag", "Magnitude", names(Tidy))
names(Tidy)<-gsub("^t", "Time", names(Tidy))
names(Tidy)<-gsub("^f", "Frequency", names(Tidy))
names(Tidy)<-gsub("tBody", "TimeBody", names(Tidy))
names(Tidy)<-gsub("-mean()", "Mean", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-std()", "Standard deviation", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-freq()", "Frequency", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("angle", "Angle", names(Tidy))
names(Tidy)<-gsub("gravity", "Gravity", names(Tidy))

## Average of each variable for each activity and each subject
Tidy2<-Tidy%>%
      group_by(subject, activity) %>%
      summarise_all(funs(mean))
write.table(Tidy2, "Tidy2.txt", row.name=FALSE)
