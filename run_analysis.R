#controls
    library(dplyr)
    library(tidyr)
    library(stringr)

#read in the common data sets
    feature_labels <- read.csv("features.csv", header = FALSE)
    activity_labels <- read.csv("activity_labels.csv", header = FALSE)
    
#read in each of the 3 "test" datasets
    subject_test <- read.table("subject_test.txt")
    x_test <- read.table("X_test.txt")
    y_test <- read.table("Y_test.txt")

#read in each of the 3 "training" datasets
    subject_train <- read.table("subject_train.txt")
    x_train <- read.table("X_train.txt")
    y_train <- read.table("Y_train.txt")
    
#process common data
    feature_labels <- as.vector(feature_labels[,2])
    x_test <- rbind(feature_labels, x_test)
          #create a vector of the first row values and replace the column names
          names(x_test) <-  unlist(x_test[1,])
          #remove the first row
          x_test <- x_test[-1,]
    x_train <- rbind(feature_labels, x_train)
          #create a vector of the first row values and replace the column names
          names(x_train) <-  unlist(x_train[1,])
          #remove the first row
          x_train <- x_train[-1,]
    colnames(subject_test) <- "subject"
    colnames(subject_train) <- "subject"

#process the "test" datasets; merge activity labels and y_test by activity number
    act_test <- as.data.frame(merge(tbl_df(activity_labels), tbl_df(y_test)))
    colnames(act_test) <- c("activitylabel", "activity")
    test_data <- cbind(subject_test, act_test, x_test)

#process the "train" datasets; merge activity labels and y_train by activity number
    act_train <- as.data.frame(merge(tbl_df(activity_labels), tbl_df(y_train)))
    colnames(act_train) <- c("activitylabel", "activity")
    train_data <- cbind(subject_train, act_train, x_train)
    
#combine the two main data sets, test and train
    working_set <- rbind(test_data, train_data)
    
#create a list of columns by which to subset the working data set
    feature_labels <- read.csv("features.csv", header = FALSE)
    feature_labels2 <- tbl_df(feature_labels)
    feature_labels2 <- mutate(feature_labels, average = str_sub(gsub(".*mean", "mean", V2),1,4), stdv = str_sub(gsub(".*std", "stdv", V2),1,4))
    mean_stdv_columns <- as.data.frame(filter(feature_labels2, average == "mean" | stdv == "stdv"))[,1]
      factor_up <- ncol(working_set) - ncol(x_test)
    mean_stdv_columns <- mean_stdv_columns + factor_up

#subset the combined datasets for just those columns which have mean or stdv
    working_subset <- sapply(subset(working_set, select = mean_stdv_columns), as.numeric)
    working_subset <- cbind(working_set[,1:3], working_subset)
    working_subset2 <- group_by(tbl_df(working_subset), subject, activity)
    working_subset2 <- summarize_each(working_subset2, funs(mean))
    arrange(working_subset2, subject)
    
    