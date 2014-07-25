# This file assumes that the UCI HAR Dataset is in the current directory
# Don't forget to set your working directory!
uci_har_folder <- 'UCI HAR Dataset'

# read the feature names
feature_file <- file.path(uci_har_folder, 'features.txt')
features <- read.table(feature_file)
feature_names <- features$V2

# get ready to read the test data
test_data_path <- file.path(uci_har_folder, 'test')
test_data_file <- file.path(test_data_path, 'X_test.txt')
test_labels_file <- file.path(test_data_path, 'y_test.txt')
test_subjects_file <- file.path(test_data_path, 'subject_test.txt')

# read the test data
test_data <- read.table(test_data_file)

# the names are the features, set them appropriately
names(test_data) <- feature_names

# load up the labels (i.e. activity)
test_label_data <- read.table(test_labels_file)
# assign the labels
test_data$label <- test_label_data$V1

# load up the subjects
test_subject_data <- read.table(test_subjects_file)
# assign the subjects
test_data$subject <- test_subject_data$V1

# repeat the same for training data
train_data_path <- file.path(uci_har_folder, 'train')
train_data_file <- file.path(train_data_path, 'X_train.txt')
train_labels_file <- file.path(train_data_path, 'y_train.txt')
train_subjects_file <- file.path(train_data_path, 'subject_train.txt')

# read the train data
train_data <- read.table(train_data_file)

# assign the feature names
names(train_data) <- feature_names
# assign the training labels
train_label_data <- read.table(train_labels_file)
train_data$label <- train_label_data$V1

# assign the training subjects
train_subject_data <- read.table(train_subjects_file)
train_data$subject <- train_subject_data$V1

# merge the two data sets
merged_set <- rbind(train_data, test_data)

# strip to only mean and standard deviation measurements, keeping subject and label also
# we can do this by searching for std() and mean() in the feature names
measurements_to_keep <- feature_names[grep('std\\(|mean\\(', feature_names)]
# then just keep those features, plus label and subject (putting them at the front)
merged_set <- merged_set[,c('label', 'subject', as.character(measurements_to_keep))]

# tidy the activity labels
# start by changing 'label' to 'activity'
names(merged_set) <- c('activity', 'subject', as.character(measurements_to_keep))

# convert them to factors
merged_set$activity <- as.factor(merged_set$activity)

# read the activity names and save them
activity_labels_file <- file.path(uci_har_folder, 'activity_labels.txt')
activity_labels <- read.table(activity_labels_file, stringsAsFactors=FALSE)[,2]

# the ordered activity labels correspond to the levels of the activity factor in the data set
# set them here and we have nice activity labels
levels(merged_set$activity) <- activity_labels

# now we want to make a new, tidy data set
# use a data table to find the mean of all columns, grouped by activity and subject
activity_data <- data.table(merged_set)
aggregate_data <- activity_data[, lapply(.SD, mean), by=list(activity,subject)]

# write out the tidy data set
write.table(aggregate_data, 'activity_averages.txt', row.names=FALSE)
