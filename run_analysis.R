## Read in all relevant data
train <- read.table("../data/UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("../data/UCI HAR Dataset/train/y_train.txt")
test <- read.table("../data/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("../data/UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("../data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("../data/UCI HAR Dataset/test/subject_test.txt")
activities <- read.table("../data/UCI HAR Dataset/activity_labels.txt")

## Bind subject and activity IDs to training and test sets
names(subject_test)[names(subject_test) == "V1"] <- "subject"
names(subject_train)[names(subject_train) == "V1"] <- "subject"
train <- bind_cols(train, subject_train)
test <- bind_cols(test, subject_test)

names(test_labels)[names(test_labels) == "V1"] <- "activity"
names(train_labels)[names(train_labels) == "V1"] <- "activity"
train <- bind_cols(train, train_labels)
test <- bind_cols(test, test_labels)

## Make the features (i.e. column headers) a little more readable.
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
features <- lapply(features$V2, tolower)
features <- gsub("bodybody", ".body", features)
features <- gsub("-", ".", features)
features <- gsub(",", ".", features)
features <- gsub("acc", ".acc", features)
features <- gsub("gyro", ".gyro", features)
features <- gsub("mag", ".mag", features)
features <- sub("^t", "time.", features)
features <- sub("^f", "frequency.", features)

## Binding together column headers, test and traing sets.
col_header <- c("subject", "activity", features)
master_data <- bind_rows(train, test)
master_data <- master_data[, c(562:563, 1:561)]
names(master_data) <- col_header

## Subsetting data to only include mean and std columns
mean_col <- grep("mean()", colnames(master_data), fixed = TRUE)
sd_col <- grep("std()", colnames(master_data), fixed = TRUE)
subset_data <- master_data[ , c(1, 2, mean_col, sd_col)]

## Using descriptive labeling for activities column via subsetting
subset1 <- subset(subset_data, subset_data$activity == 1)
subset1$activity <- sub(1, tolower(activities$V2[1]), subset1$activity)
subset2 <- subset(subset_data, subset_data$activity == 2)
subset2$activity <- sub(2, tolower(activities$V2[2]), subset2$activity)
subset3 <- subset(subset_data, subset_data$activity == 3)
subset3$activity <- sub(3, tolower(activities$V2[3]), subset3$activity)
subset4 <- subset(subset_data, subset_data$activity == 4)
subset4$activity <- sub(4, tolower(activities$V2[4]), subset4$activity)
subset5 <- subset(subset_data, subset_data$activity == 5)
subset5$activity <- sub(5, tolower(activities$V2[5]), subset5$activity)
subset6 <- subset(subset_data, subset_data$activity == 6)
subset6$activity <- sub(6, tolower(activities$V2[6]), subset6$activity)

subset_data <- bind_rows(subset1, subset2, subset3, subset4, subset5, subset6)

## Grouping and summarizing to provide final, tidy output
tidy_data <- subset_data %>% group_by(subject, activity) %>% summarise_all(funs(mean))

## Export to table
write.table(tidy_data, file = "tidydata.txt", row.names = FALSE)

## Some basic housekeeping.  Removing objects that are no longer needed.
rm(train)
rm(test)
rm(features)
rm(subject_test)
rm(subject_train)
rm(train_labels)
rm(test_labels)
rm(activities)
rm(subset1)
rm(subset2)
rm(subset3)
rm(subset4)
rm(subset5)
rm(subset6)
rm(mean_col)
rm(sd_col)