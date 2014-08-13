### Loading packages ###
library(reshape2)
library(plyr)

### Loading data ###

# Load test data
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", colClasses="factor")

# Load train data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", colClasses="factor")

# Load other files
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")

#### Analysis ###

# Merge test and train data
X_merged <- rbind(X_train, X_test)
activity_merged <- rbind(activity_train, activity_test)
subject_merged <- rbind(subject_train, subject_test)

# Add column names
colnames(X_merged)<-features$V2

# Extract the measurements on the mean and standard deviation.
collist <- grep("[Mm]ean|std", names(X_merged), value=T)
X_selected<-subset(X_merged, select=collist)

# Name the activities in the data set using descriptive names
levels(activity_merged$V1)<-c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")
activity<-activity_merged$V1
X_selected <- cbind(X_selected, activity)

# Add subject column
subject<-subject_merged$V1
X_selected <- cbind(X_selected, subject)

# Label columns
newnames <- sub("\\(\\)","", names(X_selected))
newnames <- sub("mean", "Mean", newnames)
newnames <- sub("std", "Std", newnames)
newnames <- gsub("-", "", newnames)
newnames <- sub("angle\\(", "AngleOf", newnames)
newnames <- gsub("\\)", "", newnames)
newnames <- sub("gravity", "Gravity", newnames)
newnames <- sub(",", "And", newnames)
newnames <- sub("Acc", "Acceleration", newnames)
newnames <- sub("Gyro", "Gyroscope", newnames)
newnames <- sub("Mag", "Magnitude", newnames)
newnames <- sub("Freq", "Frequency", newnames)

colnames(X_selected) <- newnames

# Create a tidy dataset with the average of each variable for each activity and subject
X_melted <- melt(X_selected, id=c("activity", "subject"), measure.vars=names(X_selected[1:86]))
X_tidy <- ddply(X_melted, .(activity, subject, variable), summarize, mean = mean(value))

# Write table
write.table(X_tidy, file="Tidy_Dataset.txt", na="", sep="\t",  row.names=FALSE, quote=FALSE)

