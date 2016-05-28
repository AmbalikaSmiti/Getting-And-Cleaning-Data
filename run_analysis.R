#Tidy Data set- Course Project

#downloading the dataset and unzip it
filename <- "dataset.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


#loading the list of features and activity labels, keeping the farure names and activity labels as character and not as factors

features<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
activity_labels <-read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

#keeping onlyu those features with mean and std in their values
x<-grep(".*mean.*|.*std.*", features[,2])
features_req <- features[x,2]
features_req <- gsub('[-()]', '', features_req )



#loading the train datasets
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
nrow(subject_train) #checking number of rows in subject_train
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")[x] #keeping only columns with required features
nrow(x_train) #checking number of rows in x_train
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
nrow(y_train) #checking number of rows in y_train
train<- cbind(subject_train,y_train,x_train) #combining all columns of train data

#loading the test datasets
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")[x] #keeping only columns with required features
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
test <- cbind(subject_test,y_test,x_test) #combining all columns of test data
names(test)

#merging the train and test data together 
data <- rbind(train,test)
#renaming the columns names of data
colnames(data) <- c("subject", "activity", features_req)

# converting the activities & subjects into factors
data$activity <- factor(data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
data$subject <- as.factor(data$subject)
str(data) #check to confirm the variable type
head(data)

library(reshape2)
datam <- melt(data, id = c("subject", "activity"),na.rm=TRUE)
head(datam) #checking how data has been converted into dataframe for each subject and activity
data_mean <- dcast(datam, subject + activity ~ variable, mean)

write.table(data_mean, "tidy.txt", row.names = FALSE, quote = FALSE)
