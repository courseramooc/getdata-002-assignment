## Variables

The variables chosen for the tidy data set were largely obtained from the original data set. All the headings are in lowercase without any other characters.


The first column name is "subject", followed by "activity". The rest of the columns names were obtained from the feature set. All the names were set to lowercase, then all "-", "(" and ")" characters were removed.

The values for subjects were obtained from the subject_test.txt and subject_train.txt files as numeric values.

The values for activities were obtained from the activity_labels.txt file. All were set to lowercase and all "_" characters were removed.

## Steps

### Getting the data
The script checks to see if the data is already downloaded, if not, it downloads the data to the data subdirectory. After the data is downloaded, the relevant files are accessed in the zip file with the unzip connection in R.

### Read the activity labels
The activities are read from the activity_labels.txt file. The values are set to lowercase and all "_" characters are removed.

### Read the feature names
The features are read from the features.txt file. After the mean and standard deviations are extracted, the values are set to lowercase and all "-", "(" and ")" characters are removed.

### Read the test data frames
All the data in the test subdirectory are read into data frames labelled "test"

### Read the train data frames
All the data in the train subdirectory are read into data frames labelled "train"

### Extract only the mean and standard deviation measurements
With regular expression statements searching for "-mean" or "-std" in the feautre names, the relevant measurements are extracted

### Label 
The datasets are appropriately labelled

### Create the tidy dataset
The tidy dataset is created by combining by column the repsective datasets created in the previous steps

### Create second tidy dataset
With the aid of the data.table library the second tidy dataset by determining the average subgrouped by subject and activity
