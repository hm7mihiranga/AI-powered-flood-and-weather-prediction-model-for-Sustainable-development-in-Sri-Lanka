# from flask import Flask, request, jsonify
# import cv2
# import numpy as np
# from tensorflow.keras.models import load_model
# from collections import Counter
# import os
#
# from flask_cors import CORS
#
# app = Flask(__name__)
# CORS(app)
#
# model = load_model(r"E:\Projects\Weather_App_UI\weatherzen_model\predict_weather_rain\cloud_segmentation_model.h5")
#
# indexes = [0, 1, 2, 3]
# labels = ['Fish', 'Flower', 'Gravel', 'Sugar']
# rgb_colors = [(56, 255, 255), (255, 70, 90), (48, 255, 99), (255, 255, 102)]
#
# idx_to_label = dict(zip(indexes, labels))
#
#
# def load_and_preprocess_image(image_path):
#     img = cv2.imread(image_path)
#     img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
#     img = cv2.resize(img, (256, 256))
#     img = img / 255.0
#     img = np.expand_dims(img, axis=0)
#     return img
#
#
# def predict(image_path):
#     img = load_and_preprocess_image(image_path)
#     pred_mask = model.predict(img)[0]
#     return pred_mask
#
#
# def decode_prediction(pred_mask):
#     decoded_mask = np.argmax(pred_mask, axis=-1)
#     return decoded_mask
#
#
# def find_most_frequent_labels(decoded_mask, idx_to_label, top_n=1):
#     flat_mask = decoded_mask.flatten()
#     label_counts = Counter(flat_mask)
#     most_frequent_labels = label_counts.most_common(top_n)
#     frequent_label_names = [idx_to_label[label_idx] for label_idx, _ in most_frequent_labels]
#     return frequent_label_names
#
#
# @app.route('/predict', methods=['POST'])
# def predict_image():
#     if 'image' not in request.files:
#         return jsonify({'error': 'No image uploaded'}), 400
#
#     file = request.files['image']
#
#     image_path = os.path.join('uploads', file.filename)
#     file.save(image_path)
#
#     pred_mask = predict(image_path)
#     decoded_mask = decode_prediction(pred_mask)
#
#     most_frequent_labels = find_most_frequent_labels(decoded_mask, idx_to_label, top_n=1)
#     most_frequent_label = most_frequent_labels[0]
#
#     prediction_message = ""
#     if most_frequent_label == 'Fish':
#         prediction_message = "Fair weather, but if the clouds thicken or lower, rain may be on the way."
#     elif most_frequent_label == 'Gravel':
#         prediction_message = "Fair weather, but if it becomes more extensive or dense, it could suggest an impending change in weather to Rainy."
#     elif most_frequent_label == 'Sugar':
#         prediction_message = "There is a high possibility of rain."
#     elif most_frequent_label == 'Flower':
#         prediction_message = "It can change to a rainy situation, suggesting fair weather."
#
#     # Return the prediction result as a JSON response
#     return jsonify({'label': most_frequent_label, 'message': prediction_message,
#                     'confidence': 1.0})  # You can replace '1.0' with actual confidence if available
#
#
# if __name__ == '__main__':
#     os.makedirs('uploads', exist_ok=True)
#     app.run(debug=True)






from flask import Flask, request, jsonify, render_template, redirect, url_for
import cv2
import numpy as np
from tensorflow.keras.models import load_model
from collections import Counter
import os
from flask_cors import CORS  # Importing CORS for Flutter integration

# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enabling CORS for communication with the Flutter app

# Load the pre-trained model
model = load_model(r"E:\Projects\Weather_App_UI\weatherzen_model\predict_weather_rain\cloud_segmentation_model.h5")

# Provided mappings
indexes = [0, 1, 2, 3]
labels = ['Fish', 'Flower', 'Gravel', 'Sugar']
rgb_colors = [(56, 255, 255), (255, 70, 90), (48, 255, 99), (255, 255, 102)]

idx_to_label = dict(zip(indexes, labels))


# Function to verify if the uploaded image is a sky image
def is_sky_image(image_path, lower_sky=(90, 20, 100), upper_sky=(135, 255, 255), sky_threshold=0.3):
    img = cv2.imread(image_path)
    hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    lower_sky = np.array(lower_sky)
    upper_sky = np.array(upper_sky)
    mask = cv2.inRange(hsv, lower_sky, upper_sky)
    sky_pixels = np.count_nonzero(mask)
    total_pixels = img.shape[0] * img.shape[1]
    sky_ratio = sky_pixels / total_pixels
    return sky_ratio > sky_threshold


# Function to preprocess the image
def load_and_preprocess_image(image_path):
    img = cv2.imread(image_path)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img = cv2.resize(img, (256, 256))
    img = img / 255.0
    img = np.expand_dims(img, axis=0)
    return img


# Predict the mask
def predict(image_path):
    img = load_and_preprocess_image(image_path)
    pred_mask = model.predict(img)[0]
    return pred_mask


# Decode the predicted mask
def decode_prediction(pred_mask):
    decoded_mask = np.argmax(pred_mask, axis=-1)
    return decoded_mask


# Function to find the most frequent labels
def find_most_frequent_labels(decoded_mask, idx_to_label, top_n=1):
    flat_mask = decoded_mask.flatten()
    label_counts = Counter(flat_mask)
    most_frequent_labels = label_counts.most_common(top_n)
    frequent_label_names = [idx_to_label[label_idx] for label_idx, _ in most_frequent_labels]
    return frequent_label_names


# Define the route for the prediction (used for Flutter)
@app.route('/predict', methods=['POST'])
def predict_image():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400

    file = request.files['image']
    image_path = os.path.join('uploads', file.filename)
    file.save(image_path)

    # Check if it's a sky image
    if not is_sky_image(image_path):
        return jsonify({'error': 'Please upload a verified sky image'}), 400

    # Predict and decode the mask
    pred_mask = predict(image_path)
    decoded_mask = decode_prediction(pred_mask)

    # Find the most frequent label
    most_frequent_labels = find_most_frequent_labels(decoded_mask, idx_to_label, top_n=1)
    most_frequent_label = most_frequent_labels[0]

    # Get the prediction message
    prediction_message = ""
    if most_frequent_label == 'Fish':
        prediction_message = "Fair weather, but if the clouds thicken or lower, rain may be on the way."
    elif most_frequent_label == 'Gravel':
        prediction_message = "Fair weather, but if it becomes more extensive or dense, it could suggest an impending change in weather to Rainy."
    elif most_frequent_label == 'Sugar':
        prediction_message = "There is a high possibility of rain."
    elif most_frequent_label == 'Flower':
        prediction_message = "It can change to a rainy situation, suggesting fair weather."

    # Return the prediction result as a JSON response
    return jsonify({'label': most_frequent_label, 'message': prediction_message, 'confidence': 1.0})


# Run the Flask app
if __name__ == '__main__':
    os.makedirs('uploads', exist_ok=True)
    app.run(debug=True)

