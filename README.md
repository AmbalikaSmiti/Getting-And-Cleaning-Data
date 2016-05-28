Getting and Cleaning Data - Course Project
================

------------------------------------------------------------------------

The projects contains following files
-------------------------------------

1.  Readme.rmd : explaining what is what
2.  codebook.rmd : explains the variables
3.  run\_analysis.r : this R script converts the data sets into tidy data set
4.  tidy.txt : the final output after running the script

------------------------------------------------------------------------

How the script works?
---------------------

1.  It downloads the dataset if does not exist and unzip it
2.  Load the features and activity labels to be used later for labeling columns of final mearged data sets for features and relabel the activity to its descriptive format.
3.  It selects the features having mean and std in their names and then clean the fature names.
4.  Then it loads all the separate x, y and subject files for both train and test data sets, keeping only the required features
5.  Column bind the subject, y and x data for train and test data
6.  merge the train and test datasets into final data
7.  Rename the column names of data
8.  converting the the activity and subject columns into factors
9.  creating the data frame for each activity and subject with all required variables
10. finding the mean value for each variable for each subject and activity pair
11. Then getting the final output into file tidy.txt
