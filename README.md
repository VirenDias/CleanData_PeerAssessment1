# Getting and Cleaning Data Course Project

The `run_analysis.R` does the following:

1. Downloads and unzips the data in the current working directory if the relevant `.zip` file is not present.
2. Reads in the train and test data and merges the two datasets.
3. Reads in the activity and variable labels and assigns them appropriately.
4. Merges the subjects and activities with the data.
5. Extracts the data relevant to the mean and standard deviation for each measurement.
6. Creates a separate tidy dataset with the average of each variable for each activity and each subject.
7. Writes the tidy dataset to a file, `tidy_data.txt`.

The `CodeBook.md` file contains information about the data in `tidy_data.txt`.