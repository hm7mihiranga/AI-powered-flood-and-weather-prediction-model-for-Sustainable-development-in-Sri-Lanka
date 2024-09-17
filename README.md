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


