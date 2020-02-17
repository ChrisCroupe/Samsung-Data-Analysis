---
title: "run_analysis_README"
author: "Chris Croupe"
date: "2/13/2020"
output: word_document
---
## run_analysis script description 

For information ion the data sets please see the code book

This script executes the following steps ... 

Reads the test, train, label, subject, and features data sets into the environment

Combines the data files - test and train data, label data, subject data and label data

Adds the feature names to the data files

Adds the "Activity" rows

Adds "Subject" rows

There are duplicate column names in this data set - removes duplicate column names

Selects the mean and standard deviation columns only

Maps Activities to readbale names from coded identifiers

Makes the variable names more readble

Creates summary data set with average for each variable for each subject and activity

Writes the output table "run_analysis_output.txt"
