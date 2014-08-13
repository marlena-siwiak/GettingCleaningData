Getting and Cleaning Data Project
=========================

To obtain a Tidy\_Dataset.txt run the run_analysis.R script with Samsung data placed in the working directory.
The script loads the train and test datasets as well as datasets on subjects and activity ids, and features names. The required input files are:

X\_train.txt
X\_test.txt
subject\_train.txt
subject\_test.txt
y\_train.txt
y\_test.txt

The train and test main sets are then merged, so are the activities and subject ids from train and test. Columns in the merged dataset are named according to the loaded features names. The columns indicating measurements of mean and standard deviation are extracted, and two more columns indicating activities and subject ids are added. The activities labels marked by numbers are transformed into human readable form, according to the key given in activity\_labels.txt.

Columns names for features are changed according to the rules presented during lectures, however, not all rules were applicable for this dataset. For instance, features names are too long to use only lower case, so the camel case was used instead. All signs which may cause problems while reading dataset in R or other programs, such as "( ) , _ -", were deleted, and most shortcuts were replaced by their full names, e.g. "Magnitude" instead of "Mag". In general most features names are very similar to those in the input dataset, for instance:

fBodyBodyGyroJerkMag-mean() was replaced with fBodyBodyGyroscopeJerkMagnitudeMean

The features of the form angle(*), indicating an angle between to vectors, were transformed as follows:

e.g. angle(tBodyAccMean,gravity) to AngleOftBodyAccelerationMeanAndGravity.

In the end, for each combination of subject id, activity and feature, the mean of feature values is calculated, and the dataset is transformed into the tidy format with four columns, as described in the code book. 

