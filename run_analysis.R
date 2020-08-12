#reading the zip file from url
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}
#reading Features txt file in dataframe feturs
feturs <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
#coercing the dataframe feturs to character 
feturs <- as.character(feturs[,2])

#reading X_train.txt file in dataframe train_x
train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
#reading y_train.txt file in dataframe train_act
train_act <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
#reading subject_train.txt file in dataframe train_sub
train_sub <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

#Merging the dataframes train_x, train_act and train_sub
train <-  data.frame(train_sub, train_act, train_x)
names(train) <- c(c('subject', 'activity'), feturs)

#reading x_test.txt file in dataframe test_x
test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
#reading y_test.txt file in dataframe test_act
test_act <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
#reading subject_test.txt file in dataframe train_sub
test_sub <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

#Merging the dataframes test_x, test_act and test_sub
test <-  data.frame(test_sub, test_act, test_x)
names(test) <- c(c('subject', 'activity'), feturs)

#Finally merging dataframes train and test
all_data <- rbind(train, test)

mean_std <- grep('mean|std', feturs)
sub_data <- all_data[,c(1,2,mean_std + 2)]

act_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
act_labels <- as.character(act_labels[,2])
sub_data$activity <- act_labels[sub_data$activity]

new_name <- names(sub_data)
new_name <- gsub("[(][)]", "", new_name)
new_name <- gsub("^t", "TimeDomain_", new_name)
new_name <- gsub("^f", "FrequencyDomain_", new_name)
new_name <- gsub("Acc", "Accelerometer", new_name)
new_name <- gsub("Gyro", "Gyroscope", new_name)
new_name <- gsub("Mag", "Magnitude", new_name)
new_name <- gsub("-mean-", "_Mean_", new_name)
new_name <- gsub("-std-", "_StandardDeviation_", new_name)
new_name <- gsub("-", "_", new_name)
names(sub_data) <- new_name

Final_tidy_data <- aggregate(sub_data[,3:81], by = list(activity = sub_data$activity, subject = sub_data$subject),FUN = mean)
write.table(x = Final_tidy_data, file = "Final_tidy_data.txt", row.names = FALSE)