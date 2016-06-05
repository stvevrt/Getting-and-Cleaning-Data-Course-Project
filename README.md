Getting-and-Cleaning-Data-Course-Project

Data was collected from 30 participants, engaging in 6 different activities, using Samsung Galaxy S smartphones.
Data was downloaded from this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Further details about the data are included in CodeBook.md

Based on the data, an R script called run_analysis.R was created that:
1.  Merges test and train into one data set.
2.  Extracts only mean and standard deviation for each measurement
3.  Uses descriptive activity names to name activities in data set.
4.  Appropriately labels data set with descriptive names
5.  Creates an independent data set called tidy_data.txt that averages each variable for each activity and subject.

There is only one script used called run_analysis.R.
This script must be run in the same directory that the data files are stored in.  
The script reads the main data files "X_train.txt" and "X_text.txt" and stores them in files named train and test.
The headings are read from a file called "features.txt" and assigned at the headings of the train and test files.
It is determined which columns contain the mean and standard deviation, then these columns are extracted from train and test.
The participants are described as "subjects" in the study, and this data is stored in files called "subject_train.txt" and 
  "subject_test.txt".  These files are read into subject_train and subject_test.
The one column in each of these files is set to "subject"
The subject_train file is combined with the train file; and the subject_test file is combined with the test file
  (files now contain the subject data for each record)
The activity that each record corresponds to is stored in files "y_train.txt" and "y_text.txt".  These files are loaded into
  activity_train and activity_test.
Descriptions of the activites are taken from file "activity_labels.txt" and added to the files activity_train and activity_test.
  (activity_train and activity_test now contain both the activity number and activity name)
The activity_train file is combined with the train file and the activity_test file is combined with the test file.
  (train and test now contain the activity number and activity description for each record)
The train and test files are combined into one file called combined.
The activity number column is not required so is removed.
Using the aggregate function, the data is summarized so that the mean is calculated for each combination of activity and subject.
Duplicated columns "activity" and "subject" are removed.
The resulting data is sorted by activity and subject.
The data is written to a file called "tidy_data.txt"


