# Spotify Genre Determination Using Audio Features

**Author:** Joshua Chang  
**Published:** March 15, 2023

## Table of Contents

1. [Introduction](#introduction)
2. [Data Overview](#data-overview)
3. [Methods](#methods)
4. [Model Building & Selection Results](#model-building--selection-results)
5. [Final Model Analysis](#final-model-analysis)
6. [Conclusion](#conclusion)
7. [References](#references)

---

## Introduction

This project uses a dataset of songs from Spotify, provided by Andrii Samoshyn on Kaggle, to analyze the determination of music genres based on various audio feature variables used by Spotify. The goal is to investigate how well machine learning models can predict the genre of a song using features such as danceability, energy, loudness, and more. The dataset consists of over 40,000 observations, each containing these audio features and the genre of the corresponding song. This genre prediction is essential for building recommendation systems and helping users discover new music.

---

## Data Overview

The dataset used in this project is called `spotify` and contains the following key characteristics:

- **Number of Rows:** 42,305
- **Number of Columns:** 22

### Summary of Data

#### Character Variables

| Variable        | Missing Values | Unique Values | Example Values |
|-----------------|----------------|---------------|----------------|
| type            | 0              | 1             | song           |
| id              | 0              | 35,877        | 5f6f7...f8f2   |
| uri             | 0              | 35,877        | spotify:track:4O4Y8l... |
| genre           | 0              | 15            | rap, pop, hip-hop |
| song_name       | 20,786         | 15,439        | "Blinding Lights", "Levitating" |

#### Numeric Variables

| Variable        | Missing Values | Mean    | Std Dev  | Min    | Max    |
|-----------------|----------------|---------|----------|--------|--------|
| danceability    | 0              | 0.64    | 0.16     | 0.07   | 0.99   |
| energy          | 0              | 0.76    | 0.18     | 0.00   | 1.00   |
| loudness        | 0              | -6.47   | 2.94     | -33.36 | 3.15   |
| tempo           | 0              | 147.47  | 23.84    | 57.97  | 220.29 |
| duration_ms     | 0              | 250,866 | 102,958  | 25,600 | 913,052|

Upon initial exploration, the majority of songs fall under the genre 'Underground Rap'. The `genre` variable has 15 unique genres including hip-hop, trap, pop, and more.

---

## Methods

In this analysis, two machine learning models were used to predict the genre based on the audio features:

1. **Decision Tree Classifier** - A model that splits the dataset into decision nodes based on the most important features.
2. **K-Nearest Neighbors (KNN)** - A model that classifies new observations based on the k-nearest data points in the feature space.

### Data Preprocessing

The genre is the target variable, and all audio features serve as the input variables. The models were tuned using repeated V-fold cross-validation to ensure reliable performance estimates.

### Model Tuning

- **Decision Tree Model:** The minimum number of samples required to split a node was tuned using grid search.
- **KNN Model:** The number of neighbors (`k`) was optimized.

The models were evaluated using the ROC curve and precision values to determine the best model.

---

## Model Building & Selection Results

After tuning both models, here are the key results:

- **Decision Tree:**
  - ROC AUC: 0.839
  - Precision: 0.608

- **K-Nearest Neighbors (KNN):**
  - ROC AUC: 0.887
  - Precision: 0.517

While the **KNN model** had a higher ROC AUC, indicating better classification performance overall, the **Decision Tree** model had a higher precision value, suggesting it was better at correctly predicting the positive genre class.

---

## Final Model Analysis

The final **KNN model** was selected due to its higher ROC AUC score, which indicates better overall classification performance. The final model was evaluated using a confusion matrix, which confirmed its ability to correctly classify genres.

It should be noted that the KNN model's performance might still be improved with further tuning. Other machine learning models like random forests or support vector machines could also be explored in future work.

---

## Conclusion

This project demonstrates the potential for using machine learning models to classify music genres based on audio features. The **KNN model** was the best-performing model in terms of ROC AUC, but there is still room for improvement. Future work may include testing more advanced algorithms, incorporating additional features like lyrics or artist information, and exploring hyperparameter optimization further.

The results also highlight the importance of using well-selected models for real-world applications, such as Spotify's recommendation systems.

---

## References

- [Kaggle Dataset by Andrii Samoshyn](https://www.kaggle.com/datasets/mrmorj/dataset-of-songs-in-spotify?resource=download)
