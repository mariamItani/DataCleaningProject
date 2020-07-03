
README

This README file describes the content of the folder, and the process used to clean the data, starting from the data provided from UCL and ending with the tidy_set file (result file).

This repository contains four files:
(1) README.md: General description of the files and the process (this file).
(2) CodeBook.md: Description of the data, variables and transformations on data variables, more or less CodeBook for the end dataset.
(3) run_analysis.R: The r script file containg the code relating to the process described in here.
(4) tidy_set.txt: The outcome of the process, the output of the R file when run on the initial datasets provided.

The run_analysis file should be placed in a folder containing the dataset file indicated in the CodeBook.md [with the source link], extracted to a sub-directory named: UCI HAR Dataset

PROCESS DESCRIPTION

STARTS
(1) Download the datasets and extract to a sub-directory named: UCI HAR Dataset
(2) Load the libraries needed, namely dplyr
(3) Load the datasets (X_test and X_train)
(4) Load the features vector, format and rename as appropriate, then add as names to the X_test and X_train data frames
(5) Select the required columns (mean and standard deviation) and update the X_test and X_train data frames to be only this selection
(6) Load activity labels and subject IDs corresponding to X_test and X_train respectively, and bind them as well.
(7) update the labels of activity labels [rename]
(8) The data frames are now ready to be merged: Merge the data frames
(9) Do the required average grouping and summarisation
(10) save the output data frame to a new file named tidy_set.txt
ENDS