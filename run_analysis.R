library(dplyr)

##Load Datasets
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")

##Load the features vector
features <- read.table("./UCI HAR Dataset/features.txt")

## extract the names and make them all lower case
features_vector <- tolower(features$V2)

##match and replace the corresponding names
features_vector <- gsub("\\()","",features_vector)
features_vector <- gsub("_","",features_vector)

##add as names to the data frame
names(X_test) <- features_vector
names(X_train) <- features_vector

##delete the features vector
rm(features,features_vector)

########## Select only the mean and standard deviation columns. Since there is a column named mean freq we need to exclude it from the selection
##do for Testing dataset

temp1 <- grep("mean",names(X_test))
temp2 <- grep("meanfreq",names(X_test))
temp3 <- grep("angle",names(X_test)) 
temp4 <- setdiff(temp1,temp2)

Xtest_mean <- setdiff(temp4,temp3)

Xtest_std <- grep("std",names(X_test))

X_test <- X_test[,c(Xtest_mean,Xtest_std)]

##repeat for Training dataset
temp1 <- grep("mean",names(X_train))
temp2 <- grep("meanfreq",names(X_train))
temp3 <- grep("angle",names(X_train)) 
temp4 <- setdiff(temp1,temp2)

Xtrain_mean <- setdiff(temp4,temp3)

Xtrain_std <- grep("std",names(X_train))

X_train <- X_train[,c(Xtrain_mean,Xtrain_std)]

##delete temporary variables
rm(temp1,temp2,temp3,temp4,Xtrain_mean,Xtrain_std, Xtest_mean, Xtest_std)

########Load activity labels and bind them
Test_AL <- read.table("./UCI HAR Dataset/test/y_test.txt")
Train_AL <- read.table("./UCI HAR Dataset/train/y_train.txt")

names(Test_AL) <- "activitylabel"
names(Train_AL) <- "activitylabel"

##bind
X_test <- cbind(X_test, Test_AL)
X_train <- cbind(X_train, Train_AL)

##remove temporary variables
rm(Test_AL, Train_AL)



##rename the labels in a better way
X_test$activitylabel <- sub("1","walk",X_test$activitylabel)
X_test$activitylabel <- sub("2","walk_upstairs",X_test$activitylabel)
X_test$activitylabel <- sub("3","walk_downstairs",X_test$activitylabel)
X_test$activitylabel <- sub("4","sit",X_test$activitylabel)
X_test$activitylabel <- sub("5","stand",X_test$activitylabel)
X_test$activitylabel <- sub("6","lay",X_test$activitylabel)

X_train$activitylabel <- sub("1","walk",X_train$activitylabel)
X_train$activitylabel <- sub("2","walk_upstairs",X_train$activitylabel)
X_train$activitylabel <- sub("3","walk_downstairs",X_train$activitylabel)
X_train$activitylabel <- sub("4","sit",X_train$activitylabel)
X_train$activitylabel <- sub("5","stand",X_train$activitylabel)
X_train$activitylabel <- sub("6","lay",X_train$activitylabel)


#################Load subject IDs and bind them
Test_SI <- read.table("./UCI HAR Dataset/test/subject_test.txt")
Train_SI <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(Test_SI) <- "subjectID"
names(Train_SI) <- "subjectID"

##bind
X_test <- cbind(X_test, Test_SI)
X_train <- cbind(X_train, Train_SI)

##remove temporary variables
rm(Test_SI, Train_SI)


##data frames are now ready to be merged by ID
##merge
X_Merged <- rbind(X_test,X_train)
rm(X_test,X_train)

##find the required average value by subject ID and activity lables
X_average <- X_Merged %>% group_by(activitylabel,subjectID) %>% summarise_each(funs(mean))

##write the final result (tidy data set) to a file (name: tidy_set.txt) as required
write.table(X_average, "./tidy_set.txt", row.names = FALSE)

##ENDS



