# Peer-graded Assignment: Getting and Cleaning Data Course Project

This is the repository for the peer-graded assignment of the Getting and Cleaning Data course, Coursera. This repository contains three files:
1/README.md
2/run_analysis.R
3/codebook.md

run_analysis.R contains the script to clean and merge the data provided for the project. The output is the TidyDataset.txt uploaded in Coursera. To read TidyDataset.txt in R, use following code: read.table (file_path, header = TRUE).

The variables created in the script are defined below:

train_total= train dataset with subject and activity number. Contains column names.
test_total= test dataset with subject and activity number. Contains column names.
featuress= list of the names of the measured features without number in front oh them
tfeatures= transposed list of feature names (featuress) into a matrix with one line, 561 columns
train_test= merged train_total and test_total dataset
valid_column_names= column names without special character "-"
train_test_sub= subsetted dataset containing columns with the words "mean" or "sd" in their name.
activity_labels= activity labels without capital and "_
test_train_label= data frame containing a new column with descriptive activity name. 
test_train_label_2= summarizes the average of each variable for each activity and each subject

