library(readr)
library(dplyr)

train <- read_table("./UCI HAR Dataset/train/X_train.txt",col_names = FALSE)
train_subject <- read_table("./UCI HAR Dataset/train/subject_train.txt",col_names = FALSE)
features <- read_table("./UCI HAR Dataset/features.txt",col_names = FALSE)
train_activities <- read_table("./UCI HAR Dataset/train/y_train.txt",col_names = FALSE)
test <- read_table("./UCI HAR Dataset/test/X_test.txt",col_names = FALSE)
subject_test <- read_table("./UCI HAR Dataset/test/subject_test.txt",col_names = FALSE)
activity_test <- read_table("./UCI HAR Dataset/test/y_test.txt",col_names = FALSE)
activity_labels <- read_table("./UCI HAR Dataset/activity_labels.txt",col_names = FALSE)


train_total <- cbind(train_subject,train_activities,train)#recompose the total train dataset with subject and activity number
test_total <- cbind(subject_test,activity_test,test)#recompose the total test dataset with subject and activity number


##label columns

#modify format features data by removing the number at the beginning of each row

featuress <- gsub("^[0-9][0-9]?[0-9]? ","",features[[1]]) #gsub replace the numbers by nothing.

tfeatures <- t(featuress) #transpose featuress into a matrix with one line

colnames(train_total,do.NULL=TRUE)
colnames(train_total) <- c("subject","activity",tfeatures)
colnames(test_total,do.NULL=TRUE)
colnames(test_total) <- c("subject","activity",tfeatures)

train_test <- rbind(train_total,test_total)#merge train_total and test_total datasets

valid_column_names <- make.names(names=names(train_test), unique=TRUE, allow_ = TRUE)#remove special characters ("-") in column names
names(train_test) <- valid_column_names
```
train_test_sub <- select(train_test,subject, activity,contains("mean"),contains("std")) #select columns with the name containing the words "mean" or "sd"

##Replace activity numbers by activity names

activity_labels <- lapply(activity_labels, function(x) tolower(x))#lower capitals in activity names  
activity_labels <- lapply(activity_labels,function(x) gsub("_"," ",x))#remove "_" in activity names

activity_labels <- data.frame(activityNr=activity_labels$X1,activity=activity_labels$X2)#transform list back to data frame

test_train_label <- merge(activity_labels,train_test_sub,by.x="activityNr",by.y="activity",all=TRUE)#merge activity data frame with the test_total data frame

drop <- "activityNr" #drop the "activityNr" column
test_train_label <- test_train_label[ , !(names(test_train_label) %in% drop)]

##Data frame with average of each variable for each activity and each subject

test_train_label_2 <- summarize_all(group_by(test_train_label,activity,subject),funs(mean))

write.table(test_train_label_2,file="./TidyDataset.txt",row.name=FALSE) #export output to .txt file


