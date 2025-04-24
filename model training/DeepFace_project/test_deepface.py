from deepface import DeepFace

# Define the image paths
img1 = "555.jpg"  # Change this to your actual image file
img2 = "666.jpg"  # Change this to your actual image file

# Run DeepFace verification with Facenet512
result = DeepFace.verify(img1, img2, model_name="Facenet512")

# Print the result
print("Verification Result:", result)

