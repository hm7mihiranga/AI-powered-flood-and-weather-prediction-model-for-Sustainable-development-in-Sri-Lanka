# AI-powered-flood-and-weather-prediction-model-for-Sustainable-development-in-Sri-Lanka
In this we used to flood and weather detection using machine learning &amp; AI in a novel way.

### 01) Cloud Pattern Detection Model Implementation
The dataset used for this project was retrieved from https://www.kaggle.com/c/understanding_cloud_organization

## Introduction
![Teaser Animation](Cloud_Pattern_Model/Teaser_AnimationwLabels.gif)

Clouds are crucial in influencing weather patterns, and understanding their organization can help us predict rainfall. In this project, you aim to classify cloud formations from satellite images to predict whether it will rain or not. By identifying specific cloud types, such as those associated with rain, you can improve the accuracy of weather predictions.</br></br>

Using satellite images provided by NASA's Worldview, captured by the MODIS instrument on the `TERRA` and `AQUA` satellites, your model will classify different cloud patterns and assess whether they are likely to produce rain. The cloud formations are labeled based on their structures, with patterns like `Fish, Flower, Gravel,` and `Sugar` providing insights into the type of weather they may bring.</br></br>

The labeled images were created by a team of scientists through a collaborative effort, marking areas where different cloud types appear. By segmenting and analyzing these formations, your model will predict whether rainfall is likely in a given area based on the cloud patterns detected.</br></br>

This project contributes to improving weather forecasting and helps scientists better understand the relationship between cloud organization and rainfall.</br></br>

For this project, I’ll be utilizing cloud classification to predict rainy or not, and Kaggle’s GPU resources are particularly beneficial for training our model efficiently. The initial model has been trained for approximately  20 epochs, but for improved accuracy, it's recommended to train the model for 50 to 100 epochs, incorporating callback functions to optimize performance.

Additionally, the preprocessing steps used have been effective in achieving baseline accuracy for our prototype. These steps ensure that the data is properly prepared, which is crucial for obtaining reliable results and improving the overall performance of the model.

### 02) Flood Prediction Model

## Introduction

Flooding is a frequent and devastating natural disaster that affects many regions around the world, including Sri Lanka. With its intricate river systems and varying weather patterns, predicting flood risks is crucial for minimizing damage to infrastructure, agricultural losses, and human life. Accurate flood prediction enables local authorities to take proactive measures, including timely evacuations and infrastructure safeguarding.
This project focuses on developing a machine learning-based model to predict flood risks at various gauging stations across Sri Lanka. By analyzing historical rainfall and water level data, the model aims to forecast water levels and predict flood risk status (e.g., normal, alert, minor flood, major flood) up to one hour before and one hour after a given event. This predictive model will provide local authorities and communities with actionable insights, allowing for better disaster preparedness and risk management.
The project involves using a dataset containing historical records of rainfall, water levels, and predefined thresholds for normal, alert, and flood conditions. By applying machine learning techniques such as Random Forest, Logistic Regression, and others, the model is expected to identify patterns and predict critical thresholds with high accuracy.

## Methodology

### Data Collection
The dataset used for this project includes historical flood-related data collected from gauging stations across Sri Lanka. The data comprises several key features:

Date and Time: Time-specific records of rainfall and water levels.
Rainfall (mm): Measured rainfall in millimeters at each station.
Water Levels (m): Water levels recorded hourly.
Flood Risk Status: Categorized as Normal, Alert, Minor Flood, or Major Flood based on specific thresholds for each station.
Predefined Thresholds: These include the water level thresholds for each station (Alert, Minor Flood, and Major Flood).
This dataset will be used to train the machine learning models to predict flood statuses and water levels.

### Data Preprocessing
Data preprocessing is essential to ensure the dataset is clean and suitable for model training. The following steps will be taken:
Handling Missing Data: Any missing values will be identified and handled using imputation techniques (e.g., mean, median, or forward-fill methods).
Feature Engineering: New features such as "1-hour before" and "1-hour after" water levels and rainfall will be created using shift-based transformations of the time-series data.
Normalization/Scaling: Continuous variables, such as rainfall and water levels, will be scaled to ensure that models perform optimally during training.

### Exploratory Data Analysis (EDA)
Exploratory Data Analysis (EDA) will be conducted to understand trends, correlations, and distribution patterns in the data. Visualization tools like histograms, line plots, and heatmaps will be used to detect seasonal variations, trends in water levels, and relationships between rainfall and flood risk. EDA will also highlight the stations most prone to flooding and the most critical thresholds for each station.

### Model Development
The project will involve developing machine learning models to predict water levels and flood statuses:
Random Forest: A decision-tree-based ensemble method that will be used to predict water levels and flood risk statuses. Random Forest is robust to overfitting and performs well on time-series data with complex relationships between variables.
Logistic Regression: This model will be used to classify the flood status (Normal, Alert, Minor Flood, Major Flood) based on features such as rainfall, water levels, and station location.
Other Machine Learning Models: Additional models such as Support Vector Machines (SVM), Gradient Boosting, and Neural Networks will be explored for comparison purposes.

### Model Training and Validation
The dataset will be split into training and test sets to evaluate model performance. Cross-validation will be used to assess the robustness of the models and prevent overfitting. Evaluation metrics such as accuracy, precision, recall, and F1-score will be used to measure the performance of the classification models. For water level prediction, metrics such as Mean Squared Error (MSE) and Mean Absolute Error (MAE) will be used.

### Threshold Mapping and Prediction
After model training, the predicted water levels will be compared against predefined thresholds for each gauging station to classify the flood risk status:
Normal: Water level below alert threshold.
Alert: Water level between alert and minor flood thresholds.
Minor Flood: Water level between minor and major flood thresholds.
Major Flood: Water level exceeds major flood threshold.
These thresholds will be mapped to real-time data for continuous monitoring and early warning predictions.

# WeatherZen

WeatherZen is a Flutter application designed to provide real-time weather forecasts and flood alerts.

## Features

- **Real-time Weather Updates**: Get accurate and up-to-date weather information.
- **Flood Alerts**: Stay informed about potential flood risks in your area.
- **Cross-Platform Support**: Runs seamlessly on both Android and iOS devices.
- **Firebase Integration**: Real-time data updates using Firebase Firestore.
- **Image Prediction**: Leverages a Flask backend for advanced image prediction functionality.

## Prerequisites

- **Flutter SDK**: Ensure you have the Flutter SDK installed. [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- **IDE**: Use an IDE that supports Flutter development, such as:
  - Android Studio
  - Visual Studio Code
  - IntelliJ IDEA
  
  Install the Flutter and Dart plugins for your chosen IDE.
- **Git**: Install Git to clone repositories and manage version control.

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-link>
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Create a Firebase project.
   - Add your `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) file to the appropriate location.
   - Set up Firebase Firestore and initialize it in the `main.dart` file.

4. Set up the Flask backend:
   - Install the required Python packages:
     ```bash
     pip install -r requirements.txt
     ```
   - Run the Flask app:
     ```bash
     python app.py
     ```

## Running the App

1. Connect a device or start an emulator/simulator.
2. Run the app:
   ```bash
   flutter run
   ```

## Additional Notes

- Ensure you have set the correct API keys for OpenWeatherMap in the respective Dart files.
- The Flask backend must be running locally for the image prediction functionality to work correctly.
- You may need to configure platform-specific settings for Android and iOS. Refer to the [Flutter documentation](https://flutter.dev/docs) for detailed instructions.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

