## ----- Tidy Data for Motion ----- ##
## ----- The following code downloads files from UCI
## ----- The data is observations from a smartphone which records different features
## ----- of the subject's motion.


library(dyplr)

        ## ----- Check to See if Data is Local; if not, download
if(!file.exists("./motion")) {dir.create("./motion")}
FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FileUrl, destfile = "./motion/Data.zip")

        ## ----- unzip data
unzip(zipfile = "./motion.Data.zip", exdire = "./motion")

        ## ----- Read files into R as data tables
  ## ----- Read Activity Type: contains the labels identifying subject's motion
activity <- read.table(".motion/UCI HAR Dataset/activity_labels.txt")  

  ## ----- Read Features: second object contains the labels of data off of device (gravity etc.)  
features <- read.table(".motion/UCI HAR Dataset/features.txt")[[2]]  

  ## ----- Read Training Data
x_train <- read.table(".motion/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(".motion/UCI HAR Dataset/train/Y_train.txt")  
subject_train <- read.table(".motion/UCI HAR Dataset/train/subject_train.txt") 

  ## ----- Read Test Data
x_test <- read.table(".motion/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table(".motion/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table(".motion/UCI HAR Dataset/test/subject_test.txt") 

        ## ----- Assign Labels to the columns
colnames(x_train) <- features
colnames(x_test) <- features
colnames(y_train) <- "activity"
colnames(y_test) <- "activity"
colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"

        ## ----- Rbind x_data into one frame
x_data <- rbind(x_train, x_test)

        ## ----- Identify and remove column features which are not mean or st deviation from x_data
n <- grepl(("mean"|"std"), features)
x_data_clean <- x_data[, n == TRUE] 

        ## ----- Rbind y data and subject data
y_data <- rbind(y_train, y_test)
subjects <- rbind(subject_train, subject_test)

        ## ----- Cbind x_data_clean, y_data, subjects: Tidy dataset of 10,299 obs and 81 variables
tidy <- cbind(subjects, y_data, x_data_clean)
write.table(tidy, ".tidy.txt")

        ## ----- Second Tidy Data Set
  ## ----- use ddply to return second data type
tidyavg <- ddply(tidy, .(subject, activity), .fun = function(x) {colMeans(s)})
write.table(tidyavg, ".tidyavg.txt")

  ## ----- 'tidyavg' is a dataframe of 180 obs and 81 variable, from which can be read
  ## ----- the subject's identification number, the motion subject was taking at the time of obs, and 
  ## ----- the mean of the feature for that subject doing that motion.
