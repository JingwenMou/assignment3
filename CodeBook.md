This is a codebook that describes the variables, the data, and any transformations or work that are performed to clean up the data collected from the accelerometers from the Samsung Galaxy S smartphone.

The code in run_analysis.R generates the result tidy dataset. 
The working directory 

The initial data files:
- subject_test.txt
- X_test.txt
- y_test.txt
- subject_train.txt
- subject_test.txt
- X_train.txt
- y_train.txt
- activity_labels.txt
- features.txt

1. merge the training and test datasets
- Bind the subject_test.txt and subject_train.txt to get a 10299x1 data frame "subject".
- Bind the x_train.txt and x_test.txt to get a 10299x561 data frame "merged_x".
    - Variables in merged_x have numeric values ranged in [-1, 1].
- Bind the y_train.txt and y_test.txt to get a 10299x1 data frame "merged_y".
    - Variables in merged_x have numeric values ranged in [1, 5].

2. extracts the mean and standard deviation for each measurements
- Reads features.txt, which contains the names of variables in merged_x. 
- Then use the grep function to extract the mean and standard deviation(std).

3. Uses descriptive activity names to name the activities in the data set
