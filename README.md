#Coursera Getting and Cleaning Data

##Introduction

This project is a result of Coursera Getting and Cleaning Data course.
The goal of this project is to give students an opportunity to collect, clean and transform a raw data to a tidy data.

On this project, the students was expected to accomplish the follow tasks:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set.
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

And...

- Include a README.md in the repo with your scripts
- A code book that describes the variables

##Raw Data

The raw dataset consists of data collected in a study using an accelerometers of Samsung Galaxy S smartphones. You can check more informations about this study [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and download the dataset [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The experiment contained here was based on the principals components:

- X_train.txt and X_test.txt: contain all the measurement data.
- y_train.txt and y_test.txt: contain an activity code for each observation of the measurement data.
- subject_train.txt and subject_test.txt: contain a subject code for each observation of the measurement data.
- features.txt: contains information about each measurement variable contained in X_train.txt and X_test.txt.
- activity_lables.txt: contains a descriptive label for each activity code.

## Program
The program created here consists only the script run_analisys.R. To run the program, just type source('run_analisys.R') and the program will generate a tidy dataset called tidy_data.txt

## Understanding what the program do
The program do the follow steps:

- Check if the file 'UCI HAR Dataset' exists, if not it download it and unzip it.
- Start reading and merging the 561 features of X_train.txt and X_test.txt.
- Read from features.txt and set the labels for X_train.txt and X_test.txt.
- Read and merge y_train.txt and y_test.txt.
- Read the merge subject_train.txt and subject_test.txt.
- Select from X_train.txt and X_test.txt just the columns that match 'mean' or 'std'
- Create a new column called Activity_label based Activity
- Bind by column Subject, Activity and Selected columns from 561 features
- Calculates through 'plyr' library the mean of all columns by Subject, Activity, Activity_label
- At the end it generates a new file called tidy_data.txt
