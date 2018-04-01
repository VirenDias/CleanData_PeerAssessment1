# Download and unzip the data (if required)
zipName <- "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "UCI HAR Dataset"
if(!file.exists(zipName)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = paste(getwd(), "/", zipName, sep = ""))
}

if(!file.exists(fileName)) {
    unzip(zipName)
}

# Read in the train data
trainSubjects <- read.table(file.path("UCI HAR Dataset", "train", "subject_train.txt"))
trainValues <- read.table(file.path("UCI HAR Dataset", "train", "X_train.txt"))
trainActivities <- read.table(file.path("UCI HAR Dataset", "train", "y_train.txt"))

# Read in the test data
testSubjects <- read.table(file.path("UCI HAR Dataset", "test", "subject_test.txt"))
testValues <- read.table(file.path("UCI HAR Dataset", "test", "X_test.txt"))
testActivities <- read.table(file.path("UCI HAR Dataset", "test", "y_test.txt"))

# Merge the train and test datasets
mergedSubjects <- rbind(trainSubjects, testSubjects)
mergedValues <- rbind(trainValues, testValues)
mergedActivities <- rbind(trainActivities, testActivities)

# Read in the labels
activityLabels <- read.table(file.path("UCI HAR Dataset", "activity_labels.txt"))
variableLabels <- read.table(file.path("UCI HAR Dataset", "features.txt"))

# Give the variables and activities labels 
names(mergedValues) <- variableLabels[[2]]
mergedActivities[[1]] <- activityLabels[mergedActivities[[1]], 2]

# Merge the subjects, activities and values
names(mergedSubjects) <- "subject"
names(mergedActivities) <- "activity"
allData <- cbind(mergedSubjects, mergedActivities, mergedValues)

# Extract the required data - the mean and standard deviation for each measurement
regexPattern <- "mean\\(\\)|std\\(\\)"
requiredData <- allData[, c(1, 2, grep(regexPattern, names(allData), ignore.case = TRUE))]

# Create a separate tidy dataset with the average of each variable for each activity and each subject
library(dplyr)
tidyData <- requiredData %>% 
    group_by(subject, activity) %>% 
    summarise_all(mean)

# Write the tidy data to a file
write.table(tidyData, "tidy_data.txt", row.name = FALSE)