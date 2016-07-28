# Getting-and-Cleaning-Data

This project is for the online course "Getting and Cleaning Data". I collect the data from the UCI motion lab and transform it into two clean and tidy data sets. The first data set (found in tidydata.txt) removes all the observaions from the sensor data which are not averages or standard deviations. It merges this data with the subject and motion identification data to form a data set. This data set is too large to be displayed on the github page and the user must click on "raw data" to see this data frame.
The second data (found in tidyavg.txt) displays the averages of each sensor observation from the first data set by subject identification number and motion type.

The various commands I used to produce these tidy data sets are found in run_analysis.R.

The codebook explains the elements of the data sets.
