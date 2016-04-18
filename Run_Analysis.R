#  Project on Data Cleaning  Course 3

library(dplyr)

# Download Zipped File to Filename Zipfile in "Data" directory

fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile="data/UCI_HAR_data.zip"
download.file(fileurl,destfile=zipfile)

# Unzip the File and extract files in "Data" directory

unzip(zipfile,exdir="data")

# Read 3 files to Datafram for the "Test" dataset - Features(x), Activity(y) and subject ID

test_x<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_y<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
test_subject<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Read 3 files to Datafram for the "Train" dataset - Features(x), Activity(y) and subject ID

train_x<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_y<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
train_subject<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Read files for feature List and Activity Labels

features<-read.table("./data/UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)
activity<-read.table("./data/UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)

# Extract Mean and Stadard Deviation column for the Test Dataset

colnames(test_x)<-features[,2]
sub_test_x<-test_x[,c(colnames(test_x)[grep("-mean|-std",colnames(test_x))])]

# Add Feature Description and Activity Label and Subject ID to Test Data set

test_y<-left_join(test_y,activity)
colnames(test_y)<-c("act-num","activity")
sub_test_xy<-sub_test_x
sub_test_xy$Activity<-test_y$activity
sub_test_xy$Subject<-test_subject$V1
sub_test_xy$Group<-"test"

# Extract Mean and Stadard Deviation column for the Train Dataset

colnames(train_x)<-features[,2]
sub_train_x<-train_x[,c(colnames(train_x)[grep("-mean|-std",colnames(train_x))])]

# Add Feature Description and Activity Label and Subject ID to Train Data set

train_y<-left_join(train_y,activity)
colnames(train_y)<-c("act-num","activity")
sub_train_xy<-sub_train_x
sub_train_xy$Activity<-train_y$activity
sub_train_xy$Subject<-train_subject$V1
sub_train_xy$Group<-"train"

# Merge Test Dataset and Train Dataset

mergeddata<-rbind(sub_train_xy,sub_test_xy)

# Create Tidy Dataset with Means for each column for each Activity and each subject.

tidy<-ddply(mergeddata,.(Subject,Activity),function(x) colMeans(x[,1:79]))

# Write tidy dataset as csv

write.csv(tidy, "./data/UCI_HAR_tidy.csv", row.names=FALSE)
