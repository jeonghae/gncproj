#Course Project

#read measurement feature and activity lables
feature<-read.table("./UCI HAR Dataset/features.txt")
activity_lables<-read.table("./UCI HAR Dataset/activity_labels.txt")

#Merges the training and the test sets to create one data set. 
x_data <- rbind(read.table("./UCI HAR Dataset/test/X_test.txt"),read.table("./UCI HAR Dataset/train/X_train.txt"))

#Extracts only the measurements on the mean and standard deviation for each measurement.
col_feature<-feature[,2]
colnames(x_data)<-col_feature
filtered_data<-x_data[,grepl("mean\\(\\)|std\\(\\)", colnames(x_data))]

#Merges the training and the test sets for activity
y_data <- rbind(read.table("./UCI HAR Dataset/test/y_test.txt"),read.table("./UCI HAR Dataset/train/y_train.txt"))
colnames(y_data)<-"activity"
#Uses descriptive activity names to name the activities in the data set
y_data$activity_lable <- "unset"
y_data$activity_lable[y_data$activity == 1] <- "WALKING"
y_data$activity_lable[y_data$activity == 2] <- "WALKING_UPSTAIRS"
y_data$activity_lable[y_data$activity == 3] <- "WALKING_DOWNSTAIRS"
y_data$activity_lable[y_data$activity == 4] <- "SITTING"
y_data$activity_lable[y_data$activity == 5] <- "STANDING"
y_data$activity_lable[y_data$activity == 6] <- "LAYING"

#Merges the training and the test sets for subject
s_data <- rbind(read.table("./UCI HAR Dataset/test/subject_test.txt"),read.table("./UCI HAR Dataset/train/subject_train.txt"))
colnames(s_data)<-"subject"

# Merges measures, activity, activity_lable and subject 
m_data <- cbind(filtered_data,y_data,s_data)

#creates a second, independent tidy data set with the average of each variable for each activity and each subject
CompleteData <- group_by(m_data, activity_lable, subject)
tidy_data<-CompleteData %>% summarise_each(funs(mean))
dim(tidy_data)

#Write a txt file created with write.table() using row.name=FALSE 
write.table(tidy_data,file="tidy.txt",sep=" ",row.names=FALSE)


          








