Introduction

Flooding is a frequent and devastating natural disaster that affects many regions around the world, including Sri Lanka. With its intricate river systems and varying weather patterns, predicting flood risks is crucial for minimizing damage to infrastructure, agricultural losses, and human life. Accurate flood prediction enables local authorities to take proactive measures, including timely evacuations and infrastructure safeguarding.
This project focuses on developing a machine learning-based model to predict flood risks at various gauging stations across Sri Lanka. By analyzing historical rainfall and water level data, the model aims to forecast water levels and predict flood risk status (e.g., normal, alert, minor flood, major flood) up to one hour before and one hour after a given event. This predictive model will provide local authorities and communities with actionable insights, allowing for better disaster preparedness and risk management.
The project involves using a dataset containing historical records of rainfall, water levels, and predefined thresholds for normal, alert, and flood conditions. By applying machine learning techniques such as Random Forest, Logistic Regression, and others, the model is expected to identify patterns and predict critical thresholds with high accuracy.

Methodology

1. Data Collection
The dataset used for this project includes historical flood-related data collected from gauging stations across Sri Lanka. The data comprises several key features:

Date and Time: Time-specific records of rainfall and water levels.
Rainfall (mm): Measured rainfall in millimeters at each station.
Water Levels (m): Water levels recorded hourly.
Flood Risk Status: Categorized as Normal, Alert, Minor Flood, or Major Flood based on specific thresholds for each station.
Predefined Thresholds: These include the water level thresholds for each station (Alert, Minor Flood, and Major Flood).
This dataset will be used to train the machine learning models to predict flood statuses and water levels.

2. Data Preprocessing
Data preprocessing is essential to ensure the dataset is clean and suitable for model training. The following steps will be taken:

Handling Missing Data: Any missing values will be identified and handled using imputation techniques (e.g., mean, median, or forward-fill methods).
Feature Engineering: New features such as "1-hour before" and "1-hour after" water levels and rainfall will be created using shift-based transformations of the time-series data.
Normalization/Scaling: Continuous variables, such as rainfall and water levels, will be scaled to ensure that models perform optimally during training.
3. Exploratory Data Analysis (EDA)
Exploratory Data Analysis (EDA) will be conducted to understand trends, correlations, and distribution patterns in the data. Visualization tools like histograms, line plots, and heatmaps will be used to detect seasonal variations, trends in water levels, and relationships between rainfall and flood risk. EDA will also highlight the stations most prone to flooding and the most critical thresholds for each station.

4. Model Development
The project will involve developing machine learning models to predict water levels and flood statuses:

Random Forest: A decision-tree-based ensemble method that will be used to predict water levels and flood risk statuses. Random Forest is robust to overfitting and performs well on time-series data with complex relationships between variables.
Logistic Regression: This model will be used to classify the flood status (Normal, Alert, Minor Flood, Major Flood) based on features such as rainfall, water levels, and station location.
Other Machine Learning Models: Additional models such as Support Vector Machines (SVM), Gradient Boosting, and Neural Networks will be explored for comparison purposes.
5. Model Training and Validation
The dataset will be split into training and test sets to evaluate model performance. Cross-validation will be used to assess the robustness of the models and prevent overfitting. Evaluation metrics such as accuracy, precision, recall, and F1-score will be used to measure the performance of the classification models. For water level prediction, metrics such as Mean Squared Error (MSE) and Mean Absolute Error (MAE) will be used.

6. Threshold Mapping and Prediction
After model training, the predicted water levels will be compared against predefined thresholds for each gauging station to classify the flood risk status:

Normal: Water level below alert threshold.
Alert: Water level between alert and minor flood thresholds.
Minor Flood: Water level between minor and major flood thresholds.
Major Flood: Water level exceeds major flood threshold.
These thresholds will be mapped to real-time data for continuous monitoring and early warning predictions.

