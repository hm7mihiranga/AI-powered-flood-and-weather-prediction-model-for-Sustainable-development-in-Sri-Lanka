import cv2
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
from tensorflow.keras.models import load_model
import numpy as np
from collections import Counter

# Provided mappings
indexes = [0, 1, 2, 3]
labels = ['Fish', 'Flower', 'Gravel', 'Sugar']
colors = ['maroon', 'darkblue', 'purple', 'teal']
colormaps = ['PuRd_r', 'Blues_r', 'Purples_r', 'winter_r']
rgb_colors = [(56, 255, 255), (255, 70, 90), (48, 255, 99), (255, 255, 102)]

label_to_idx = dict(zip(labels, indexes))
idx_to_label = dict(zip(indexes, labels))
label_to_color = dict(zip(labels, colors))
idx_to_color = dict(zip(indexes, colors))
label_to_rgb_color = dict(zip(labels, rgb_colors))
idx_to_rgb_color = dict(zip(indexes, rgb_colors))
label_to_colormap = dict(zip(labels, colormaps))
idx_to_colormap = dict(zip(indexes, colormaps))

# Load your saved model
model = load_model('cloud_segmentation_model.h5')

# Load and preprocess the input image
def load_and_preprocess_image(image_path):
    img = cv2.imread(image_path)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)  # Convert from BGR to RGB
    img = cv2.resize(img, (256, 256))  # Resize to match model input size
    img = img / 255.0  # Normalize pixel values
    img = np.expand_dims(img, axis=0)  # Add batch dimension
    return img

# Make predictions using the model
def predict(image_path):
    img = load_and_preprocess_image(image_path)
    pred_mask = model.predict(img)[0]  # Predict the mask
    return pred_mask

# Decode the predicted mask to assign each pixel a class
def decode_prediction(pred_mask):
    decoded_mask = np.argmax(pred_mask, axis=-1)  # Get class with highest probability
    return decoded_mask

# Path to your input image
image_path = 'hasi.jpg'  # Change this to your actual image path

# Predict the mask
pred_mask = predict(image_path)

# Decode the predicted mask
decoded_mask = decode_prediction(pred_mask)

# Define a custom color map for the segmentation mask using the RGB values
def create_custom_cmap(rgb_colors):
    custom_colors = [tuple([c / 255 for c in color]) for color in rgb_colors]
    return mcolors.ListedColormap(custom_colors)

# Create a custom color map using the provided RGB colors
custom_cmap = create_custom_cmap(rgb_colors)

# Plot the decoded mask using the custom color map
plt.figure(figsize=(8, 8))
plt.imshow(decoded_mask, cmap=custom_cmap)
plt.colorbar(ticks=indexes, label='Classes')
plt.title("Decoded Segmentation Mask with Class Labels")
plt.show()

# Display class label, color, and colormap information
for idx in indexes:
    label = idx_to_label[idx]
    color = idx_to_color[idx]
    rgb_color = idx_to_rgb_color[idx]
    colormap = idx_to_colormap[idx]
    print(f"Class {idx}: {label}")
    print(f" - Color: {color}")
    print(f" - RGB Color: {rgb_color}")
    print(f" - Colormap: {colormap}")


# Assuming 'decoded_mask' is your predicted mask with the label index at each pixel

# Function to find the most frequent labels
def find_most_frequent_labels(decoded_mask, idx_to_label, top_n=1):
    # Flatten the decoded mask to 1D and count occurrences of each label
    flat_mask = decoded_mask.flatten()
    label_counts = Counter(flat_mask)

    # Get the top 'n' most frequent labels
    most_frequent_labels = label_counts.most_common(top_n)

    # Convert label indices to label names
    frequent_label_names = [idx_to_label[label_idx] for label_idx, _ in most_frequent_labels]

    return frequent_label_names, most_frequent_labels

# Decode the predicted mask if not already done
# decoded_mask = decode_prediction(pred_mask)  # Uncomment if pred_mask is present

# Find the top 2 most frequent labels (or change top_n as per your need)
most_frequent_labels, label_frequencies = find_most_frequent_labels(decoded_mask, idx_to_label, top_n=2)

# Display the result
print(f"Most Frequent Label Names: {most_frequent_labels}")
print(f"Label Frequencies: {label_frequencies}")