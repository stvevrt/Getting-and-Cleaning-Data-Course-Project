##  R script for Getting and Cleaning Data Course Project
##  Perform the following actions:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
##      each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.

run_analysis<-function(){
  #Load two primary data tables
  train<-read.table("X_train.txt")
  test<-read.table("X_test.txt")
  #features.txt contains labels for each column in train and test
  headings<-read.table("features.txt")
  #Assign correct column labels to train and test
  names(train)<-headings$V2
  names(test)<-headings$V2
  #remove unnecessary columns from train and test
  #first find columns with mean and std
  meanandstd<-grep("-mean\\(\\)|-std\\(\\)",headings$V2)  
  #select those columns from train and test
  train<-train[,meanandstd]
  test<-test[,meanandstd]
  #subject_test and subject_train link the subject to the test and train data
  subject_test<-read.table("subject_test.txt")
  subject_train<-read.table("subject_train.txt")
  #assign correct label to subject_test and subject_train
  names(subject_test)<-"subject"
  names(subject_train)<-"subject"
  #Add subject to test and train data
  train<-cbind(subject_train,train)
  test<-cbind(subject_test,test)
  #y_train.txt and y_test.txt create association between activity and test, train
  activity_train<-read.table("y_train.txt")
  activity_test<-read.table("y_test.txt")
  #load list of activities
  activity<-read.table("activity_labels.txt")
  #add descriptive name to activity_train and activity_test
  activity_train<-merge(activity_train,activity,by.x="V1", by.y="V1")
  activity_test<-merge(activity_test,activity,by.x="V1", by.y="V1")
  #set correct column names in activity_train and activity_test
  names(activity_train)<-c("activity_num","activity")
  names(activity_test)<-c("activity_num","activity")
  #add descriptive activity column to train and test
  train<-cbind(activity_train,train)
  test<-cbind(activity_test,test)
  #combine test and train
  combined<-rbind(test,train)
  #remove unnecessary "activity_num" column
  c2<-combined[,2:69]
  #create summarized data set with average for each variable for each
  #activity and each subject
  c3<-aggregate(c2, by=list(activity=c2$activity,subject=c2$subject),
                FUN=mean, na.rm=FALSE)
  #remove unnecessary columns
  c4<-c3[,-c(3,4)]
  #sort by activity then subject
  c5<-c4[order(c4$activity,c4$subject),]
  #write file containing tidy data set
  write.table(c5,file="tidy_data.txt",row.name=FALSE)
}
