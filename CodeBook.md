
Downloading the zip file and reading necessary files in dataframes.
1. First reading the file from url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. If file exists , then download and unzip the file in the working directory
3. Read the file features.txt in dataframe feturs and then coercing the fetures dataframe to character.
4. Read the file Training data files x_train.txt in dataframe train_x, file y_train.txt in dataframe train_act and read the file subject_train.txt in dataframe train_sub.
5. Merging the dataframes train_x, train_act, train_sub and then adding feturs dataframe with variable names 'subject' and 'activity'
6. Similarly read the file Test data files x_test.txt in dataframe test_x, file y_test.txt in dataframe test_act and read the file subject_test.txt in dataframe test_sub.
7. Merging the dataframes test_x, test_act, test_sub and then adding feturs dataframe with variable names 'subject' and 'activity'


At this point we have read all the data in dataframes and joined the data with rbind. We have final data in all_data dataframe.


First objective: Finally joining dataframes train and test with rbind() in dataframe all_data
Second Objective: Extracts only the measurements on the mean and standard deviation for each measurement u
  1. First searching the text mean|std" in dataframe feturs and sving in mean_std 
  2. Extracting measurements on the mean and standard dev for each measurement, saving the results in dataframe sub_data

Third Objective: Uses descriptive activity names to name the activities in the data set
  1. reading the labels from the activity_labels.txt file and saving in activity.labels
  2. Coercing the dataframe act_labels to character

Fourth Objective: Appropriately labels the data set with descriptive variable names.
 1. Replace the names in data set with names from activity labels as below:

"()"  as spaces
"^t" as "TimeDomain_"
"^f" as "FrequencyDomain_"
"Acc" as "Accelerometer"
"Gyro" as "Gyroscope"
"Mag" as "Magnitude"
"-mean-" as "_Mean_"
"-std-" as "_StandardDeviation_"
"-" as "_"
 
Fifth Objective: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  1. Tidy data as output as data_tidy.txt file, do this by saving first in dataframe data.tidy and then writing in file data_tidy.txt