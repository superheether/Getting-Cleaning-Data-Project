#Step 1. Merges the training and the test sets to create one data set

#1.1 Upload files from "UCI HAR Dataset" into Environment
#Use "Import Dataset" in Environment - import tables individually: X_train, y_train, subject_train, X_test, y_test, subject_test, activity_labels
#Tables will appear in Environment to use in code
#Note: no need to rename tables as R will recognize their uploaded file names that appear in Environment; 
#you can also view the tables by clicking on the table icon to the right of the table name


#1.2 Assigning column names in each table

> colnames(X_train) <- features[,2]
> colnames(y_train) <- "activityId"
> colnames(subject_train) <- "subjectId"
> colnames(X_test) <- features[,2]
> colnames(y_test) <- "activityId"
> colnames(subject_test) <- "subjectId"
> colnames(activity_labels) <- c('activityId', 'activityType')

#1.3 Merging unstructured data into one set

> all_train <- cbind(y_train, X_train, subject_train)
> all_test <- cbind(y_test, X_test, subject_test)
> Test_Train <- rbind(all_test, all_train)

#1.3.1 Checking output dimensions of merged set

> dim(Test_Train)
[1] 10299   563

#Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

#2.1 Reading column names

> AllColNames <- colnames(Test_Train)

#2.2 Creating a vector to define mean and standard of merged data set.

> StandardMeans <- (grepl("activityId", AllColNames) | 
+                       grepl("subjectId", AllColNames) | 
+                       grepl("mean..", AllColNames) | 
+                       grepl("std", AllColNames))

#Step 3. Uses descriptive activity names to name the activities in data set.

> TableActivityNames <- merge(Test_Train, activity_labels, 
+                             by='activityId',
+                             all.x = TRUE)

#Step 4. Appropriately labels the data set with descriptive variable names.

> TidySet <- aggregate(. ~subjectId + activityId, Test_Train, mean)
> TidySetTable <- TidySet[order(TidySet$subjectId, TidySet$activityId),]

#Step 5. From the data set in Step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

> write.table(TidySetTable, "TidySetTable.txt", row.names = FALSE)

#For fun, view your completed tidy data set and celebrate: you did it!

> View(TidySetTable)
