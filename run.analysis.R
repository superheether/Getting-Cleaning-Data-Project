#Step 1. Merges the training and the test sets to create one data set

#1.1 Upload files from "UCI HAR Dataset" into Environment
#Use "Import Dataset" in Environment - import tables individually: X_train, y_train, subject_train, X_test, y_test, subject_test, activity_labels
#Tables will appear in Environment to use in code


#1.2 Assigning column names in each table

> colnames(X_train) <- features[,2]
> colnames(y_train) <- "activityId"
> colnames(subject_train) <- "subjectId"
> colnames(X_test) <- features[,2]
> colnames(y_test) <- "activityId"
> colnames(subject_test) <- "subjectId"
> colnames(activity_labels) <- c('activityId', 'activityType')
> all_train <- cbind(y_train, X_train, subject_train)
> all_test <- cbind(y_test, X_test, subject_test)
> Test_Train <- rbind(all_test, all_train)
> dim(Test_Train)
[1] 10299   563
> View(Test_Train)
> AllColNames <- colnames(Test_Train)
> AllColNames

> StandardMeans <- (grepl("activityId", AllColNames) | 
+                       grepl("subjectId", AllColNames) | 
+                       grepl("mean..", AllColNames) | 
+                       grepl("std", AllColNames))
> AllStandardMeans <- AllColNames[, StandardMeans == TRUE]

> AllStandardMeans <- AllColNames[ , StandardMeans == TRUE]

> TableActivityNames <- merge(Test_Train, activity_labels, 
+                             by='activityId',
+                             all.x = TRUE)


> View(TableActivityNames)
> TidySet <- aggregate(. ~subjectId + activityId, Test_Train, mean)
> View(TidySet)
> TidySetTable <- TidySet[order(TidySet$subjectId, TidySet$activityId),]
> View(TidySetTable)
> write.table(TidySetTable, "TidySetTable.txt", row.names = FALSE)

> TidySetTable <- read.csv("~/R/TidySetTable.txt", header=FALSE)
>   View(TidySetTable)
