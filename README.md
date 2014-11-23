getting_and_cleaning_data_course_project-
=========================================
Summary
This repository is for the course project of the Coursera course "Getting and Cleaning data." The purpose of this project is to prepare tidy data from the raw data. 

Raw data
In the "UCI HAR Dataset," there are two raw data sets "test" and "train." There are 561 unlabeled features in the x_test.txt and x_train.txt files. The activity labels are in the y_test.txt and y_train.txt files. The test subjects are in the subject_test.txt and subject_train.txt files. 

How the script works
The script run_analysis.R merges the test and training sets into one data set. Then it assigns labels the data and removes the unwanted columns so that only the columns related to mean and standard deviation are kept. At the end the script creates a tidy data set containing the means of all the columns per test subject and per activity. Then, a file called tidydata.txt containing the tidy data set is written.

Tidy Data
The tidy data set can be seen in the tidydata.txt file in this repository.

Code Book
A code book that describes the variables can be seen in the codebook.md file in this repository.
