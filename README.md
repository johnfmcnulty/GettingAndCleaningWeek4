# GettingAndCleaningWeek4: Final Assignment

## Overview

Corresponding script run_analysis.R should run all of the steps mentioned below (Run_Analysis Details) and save file tidydata.txt

Please remember when reading table to make sure to set header = TRUE

##  Run_Analysis Details

1.) Read in the relevant table from the UCI HAR Dataset files stored on the established directory

2.) Binds the subject and activity IDs to the respective test and train datasets.

3.) Rename the column headers to make them more readable.  NOTE: I used my own preferred formatting here, which is to use all lowercare and to seperate variable characteristics (direction, acceleration type, etc.) with periods.  Given that there is to be no further maniupations of the data to be used with this dataset within the confines of this course, I didn't alter the column names any further than that, but given a real world scenario I would likely manipulate further.
  a.) Additionally, moved subject and activity to column positions 1 and 2, respectively.

4.) Create a new data frame by binding test and train datasets alone with the established column headers.  

5.) Subset data to include the datatypes specified for this assignment (mean and standard deviation).  Done so by filtering out to only columns that contain "mean()" or "std()".  This removes vectors used on the angle variable, but it is my understanding that we can choose whether or not to include these.  Of course, any subsetting here would normally be in accordance of what data we would want to measure per project goals.

6.) Replace integers in activities column with descriptive labelling corresponding with each activity as outlined in the activities file. This is done using the subset function, which isn't the most elegant solution, but was chose to make sure that the existing data maintains the same order.  Once labals are applied to all subsets, the are binded together under a new data frame object.

7.) Creates independent tidy data set by grouping data by subject and activity and applying average of each variable.  This is done using dplyr functions group_by and summarise_each.  New data set should have 180 observations over 68 variables.

8.) Writes out tidy data set as "tidydata.txt" and saves to established directory.



