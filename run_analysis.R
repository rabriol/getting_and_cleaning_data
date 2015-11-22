run <- function() {
    library(plyr)
    
    if (!file.exists("./UCI HAR Dataset")) {
      # download the file UCI HAR Dataset.zip
      file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      file_name <- "UCI HAR Dataset.zip"
      download.file(file_url, file_name, method="curl")
      
      unzip(file_name)
    }
    
    # load the files X_train.txt and X_test.txt
    ds_train_x <- read.csv(file="./UCI HAR Dataset/train/X_train.txt", header=FALSE, colClasses=c("numeric"), sep="")
    ds_test_x <- read.csv(file="./UCI HAR Dataset/test/X_test.txt", header=FALSE, colClasses=c("numeric"), sep="")
    
    # bind X_train.txt and X_test.txt
    ds_x <- rbind(ds_train_x, ds_test_x)
    
    # load features
    features <- read.table(file="./UCI HAR Dataset/features.txt", col.names=c("feature_id", "feature"))
    
    # set columns name for ds_x
    colnames(ds_x) <- features$feature
    
    # loading files y_train.txt and y_test.txt
    ds_train_y <- read.csv(file="./UCI HAR Dataset/train/y_train.txt", header=FALSE, colClasses=c("numeric"), sep="")
    ds_test_y <- read.csv(file="./UCI HAR Dataset/test/y_test.txt", header=FALSE, colClasses=c("numeric"), sep="")
    
    # binding y_train.txt and y_test.txt
    ds_y <- rbind(ds_train_y, ds_test_y)
    
    # set columns name for ds_y
    colnames(ds_y) <- c("activity")
    
    # loading files subject_train.txt [train part] and subject_train.txt [test part]
    ds_train_s <- read.csv(file="./UCI HAR Dataset/train/subject_train.txt", header=FALSE, colClasses=c("numeric"), sep="")
    ds_test_s <- read.csv(file="./UCI HAR Dataset/test/subject_test.txt", header=FALSE, colClasses=c("numeric"), sep="")
    
    # binding subject_train.txt [train part] and subject_train.txt [test part]
    ds_s <- rbind(ds_train_s, ds_test_s)
    
    # set columns name for ds_s
    colnames(ds_s) <- c("subject")
    
    # extracts only the columns that macht mean or std in the name
    mean_and_std_columns <- grepl("mean\\(\\)|std\\(\\)", colnames(ds_x))
    ds_mean_and_std <- ds_x[,mean_and_std_columns]
    
    # binding subject, activity_id and the mean and std columns
    ds <- cbind(ds_s, ds_y, ds_mean_and_std)
    
    ## creating a new variable to name the activities
    values <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
    index <- c(1, 2, 3, 4, 5, 6)
    ds$activity_label <- values[match(ds[, 2], index)]
    
    # makes the calculus to get the mean of all columns except the columns Subject, Activity and Activity_label that were used to group by
    tidy_data <- ddply(ds, .(subject, activity, activity_label), numcolwise(mean))
    
    ## writing the tidy data frame in a file called ds_tidy.txt
    write.table(tidy_data, "./tidy_data.txt", row.name=FALSE, sep="\t")
}

# executes the program
run();
