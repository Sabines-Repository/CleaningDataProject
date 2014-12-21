## read all relevant files

test_data <- read.table("test/X_test.txt", stringsAsFactors = FALSE)
test_activity <- read.table("test/y_test.txt", stringsAsFactors = FALSE)
test_subject <- read.table("test/subject_test.txt", stringsAsFactors = FALSE)

train_data <- read.table("train/X_train.txt", stringsAsFactors = FALSE)
train_activity <- read.table("train/y_train.txt", stringsAsFactors = FALSE)
train_subject <- read.table("train/subject_train.txt", stringsAsFactors = FALSE)

features <- read.table("features.txt", stringsAsFactors = FALSE)
activity_labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)

## prepare the header for the data table
features$V1 <- NULL
header <- t(rbind("subject", "activity", features))

## add the subject and activity columns to the test and train dataset
test <- cbind(test_subject, test_activity, test_data)
train <- cbind(train_subject, train_activity, train_data)

## combine the test and train dataset
combined <- rbind(test, train)

## set the header of the combined dataset
colnames(combined) <- header

## define the columns to keep (headers containing mean, std, 
## plus the first two columns which have been added above)
keep <- grep("mean|std",names(combined))
keep <- append(c(1,2),keep)

combined <- combined[keep]

## create nice activity labels
activity_labels <- matrix(c(1:6,"walking","walking upstairs",
                            "walking downstairs","sitting","standing","laying"),6,2)
combined$activity <- lapply(combined$activity, function(x){
  x <- activity_labels[activity_labels[,1] == x, 2]})

## create a tidy dataset where the measured variables are linearized 
## into a variable and a value column
names <- colnames(combined)
names <- names[3:length(names)]
library(reshape)
melted <- melt(combined, id=c("subject","activity"), measure.vars=names)

library(reshape2)
library(nlme)

## aggregate the tidy dataset to show the mean for 
## each subject, activity and variable
melted$activity<-unlist(melted$activity)
aggregated <- aggregate(value~subject+activity+variable, melted, mean )

## write the aggregated to a txt file for submission to the project work
write.table(aggregated,"output.txt",row.name=FALSE)
