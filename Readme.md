# Readme

This directory contains a a script titled *run_analysis.r* which assumes to have the UCI HAR Dataset
unzipped in the same folder. The original dataset archive may be obtained from the following URL:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#>

## Overview of *run_analysis.r*
The script does the following high-level steps:

1. Load the test and train data from inside the UCI HAR Dataset folder.
2. Append the appropriate test and training subject and activity labels.
3. Combine the two datasets into a single dataset.
4. Trim the dataset to keep only those features that were the result of calculating
  mean or std deviation of the smartphone data. (See the link above for more details)
5. Replace the activity labels, represented as numbers, with their plain-text equivalents.
6. Form a dataset that summarizes the mean of each measurement by subject and activity.
7. Output this dataset to *activity_averages.txt*.

For more information about the cleaned dataset, refer to the Codebook.md.
