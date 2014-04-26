# Start
library(data.table)

WORKINGDIR <- "d:/Coursera/getdata-002/Assignment/"

# Set desired top level directory
setwd(WORKINGDIR)

# Create data directory if needed
if(!file.exists("./data")) {
    dir.create("./data")
}

# Download dataset if needed
if(!file.exists("./data/dataset.zip")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile="./data/dataset.zip",method="curl")
}

# Read activity labels
conunzip        <- unz("./data/dataset.zip", "UCI HAR Dataset/activity_labels.txt")
activitylabels  <- read.table(conunzip)
activitylabels[,2] <- tolower(activitylabels[,2])
activitylabels[,2] <- gsub("_", "", activitylabels[,2])

# Read features names
conunzip        <- unz("./data/dataset.zip", "UCI HAR Dataset/features.txt")
features        <- read.table(conunzip)

# Read test data frames
conunzip        <- unz("./data/dataset.zip", "UCI HAR Dataset/test/subject_test.txt")
testsubjectdf   <- read.table(conunzip)
conunzip        <- unz("./data/dataset.zip", "UCI HAR Dataset/test/X_test.txt")
testxdf         <- read.table(conunzip)
conunzip        <- unz("./data/dataset.zip", "UCI HAR Dataset/test/y_test.txt")
testydf         <- read.table(conunzip)

# Read train data frames
conunzip        <- unz("./data/dataset.zip", "UCI HAR Dataset/train/subject_train.txt")
trainsubjectdf  <- read.table(conunzip)
conunzip        <- unz("./data/dataset.zip", "UCI HAR Dataset/train/X_train.txt")
trainxdf        <- read.table(conunzip)
conunzip        <- unz("./data/dataset.zip", "UCI HAR Dataset/train/y_train.txt")
trainydf        <- read.table(conunzip)

# Merge training and test sets to create one data set
mergedsubjectdf <- rbind(testsubjectdf, trainsubjectdf)
mergedxdf       <- rbind(testxdf, trainxdf)
mergedydf       <- rbind(testydf, trainydf)

# Extract only the mean and standard deviation measurements
feature.index   <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
extractedxdf    <- mergedxdf[,feature.index]
names(extractedxdf) <- features[feature.index,2]
names(extractedxdf) <- tolower(names(extractedxdf))
names(extractedxdf) <- gsub("\\(|\\)|-", "", names(extractedxdf))


# Add descriptive activity names to the data set
mergedydf[, 1]  <- activitylabels[mergedydf[,1], 2]
names(mergedydf) <- "activity"

# Label the subject data set appropriately
names(mergedsubjectdf) <- "subject"

# Create the tidy dataset
tidydataset <- cbind(mergedsubjectdf, mergedydf, extractedxdf)

# Create second tidy data set with average for each variable for each activity and each subject

dt <- data.table(tidydataset)
secondtidydataset <- dt[,lapply(.SD,mean),by="subject,activity"]

write.table(tidydataset, "tidydataset.txt")
write.table(secondtidydataset, "secondtidydataset.txt")
