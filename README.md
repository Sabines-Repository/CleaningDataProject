Getting and Cleaning Data Course Project



run_analytics.R reads a test and training dataset recorded on a mobile device. Each dataset 
consists of three files:
1) a set of parameters measured (X_test.txt, X_train.txt)
2) a file containing a subject ID revealing who was carrying the mobile device (subject_test.txt, subject_train.txt)
3) a file containing the activity that was performed (y_test.txt, y_train.txt)
These three files have the same number of lines in the matching order.

Hence, the columns of the three files have been merged into a single dataset. 

Next the test and train dataset have been merged into a single long dataset.

The original datasets have the same number of columns.

The two datasets were merged into a single one and augmented with a header line.

The single dataset has been augmented with a header line.

Columns that do not contain mean, std, subject or activity have been dropped.

Next the activities have been renamed to resamble natural language.

The dataset has then be converted into a tidy dataset which I considered to consist of the columns subject, activity, variable and value. Basically the many columns have been linearized into the variable/value columns. This process is called melting in R.

After melting the tidy dataset has been aggregated into a table stating each combination of subject, activity and variable and the mean of the values.

The aggregated data have been written to a file named output.txt. The content of 
output.txt is described in the file CodeBook.md