# Flower Identifier (Group 1)

A mobile application for identifying flower species using image classification, developed using **Flutter** and **TensorFlow Lite**.

The application allows users to select a flower image and uses a trained TensorFlow Lite model to predict the flower species together with a confidence score.

---

## Dataset

**Source:** [Flower Photos by the TensorFlow Team — Kaggle](https://www.kaggle.com/datasets/batoolabbas91/flower-photos-by-the-tensorflow-team)

The flower classification system identifies five flower categories:

| Class | Flower Species |
|------:|----------------|
| 1 | Daisy |
| 2 | Dandelion |
| 3 | Roses |
| 4 | Sunflowers |
| 5 | Tulips |

### Dataset Citation

#### Batool Abbas. **"Flower Photos by the TensorFlow Team."** Kaggle. Retrieved from:  
#### https://www.kaggle.com/datasets/batoolabbas91/flower-photos-by-the-tensorflowteam
---

## Technologies Used

- Flutter
- Dart
- TensorFlow Lite
- Image Classification
- Android Studio
- Kaggle Dataset

---

## Application Features

The Flower Identifier provides a simple mobile interface for flower recognition.

Users can:

1. **Select an Image** — Choose a flower image for identification
2. **Identify Flower** — Process the selected image using the trained TensorFlow Lite model
3. **View Prediction** — Display the predicted flower species
4. **View Confidence Score** — Display the model's confidence in its prediction

The trained model is integrated directly into the Flutter application using TensorFlow Lite.

---

## Image Classification Process

The application follows a simple flower identification process:

1. User selects a flower image
2. The image is prepared for model inference
3. The image is passed to the TensorFlow Lite model
4. The model performs image classification
5. The predicted flower class is obtained using the class labels
6. The predicted flower and confidence score are displayed to the user

---

## Model Files

The application contains the trained TensorFlow Lite model and its corresponding class labels:

```text
assets/
├── model_unquant.tflite
└── labels.txt
```

These files are used by the Flutter application to perform flower classification.

---

## How to Access the Project

Due to the large size of the complete Flutter project and its related files, the full project is stored on **Google Drive** instead of directly in this GitHub repository.

### Full Project Files

[Open Flower Identifier Project on Google Drive](https://drive.google.com/drive/folders/14XMeT4m5U-3z8zGUQNeQV47Rai7dxk-U?usp=share_link)

Download the complete project folder from Google Drive before running the application.

---

## How to Run

### 1. Download the Project

Download the complete project from the Google Drive link provided above.

### 2. Install Flutter

Ensure Flutter and the required development environment are installed.

Check the Flutter installation:

```bash
flutter doctor
```

### 3. Install Dependencies

Navigate to the downloaded Flutter project directory and run:

```bash
flutter pub get
```

### 4. Connect a Device

Connect a supported device or start an emulator.

Check the available devices:

```bash
flutter devices
```

### 5. Run the Application

Run:

```bash
flutter run
```

The Flower Identifier application will launch on the selected device.

---

## Project Structure

The structure below shows only the main files and folders. Generated Flutter, platform, build, and dependency files are omitted for simplicity.

```text
flower_identification_app/
│
├── assets/
│   ├── labels.txt
│   ├── model_unquant.tflite
│   ├── BACKGROUND.png
│   ├── BRANDING.png
│   └── LOGO.png
│
├── lib/
│   └── main.dart
│
├── android/
├── ios/
├── web/
├── windows/
├── macos/
│
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
└── README.md
```

> **Note:** This is a simplified representation of the project structure. Flutter automatically generates additional platform, build, plugin, dependency, and configuration files that are not shown here.

---

## Results Summary

The developed application performs flower image classification across five flower categories:

- Daisy
- Dandelion
- Roses
- Sunflowers
- Tulips

The application integrates a trained **TensorFlow Lite image classification model** with a **Flutter mobile application**.

Users can provide a flower image and receive the predicted flower species together with the model's confidence score.

The project demonstrates the integration of machine learning and mobile application development for flower image classification.

---

## Future Improvements

Future improvements may include:

- Support for more flower species
- Improve flower classification accuracy
- Add an "Unknown Flower" confidence threshold
- Include additional information about identified flowers
- Improve the user interface and user experience
- Further optimise model performance

---

## Authors

- MANIEMALAR A/P MONEYUAL
- RAJA AHMAD AFIQ BIN RAJA NASARUDDIN
- TAMILLAMUTHEN A/L KARTHIGESU
- NICOLE VIVIENNE VOO
- GLORIA ASTEFEN JANE GUDIN
- VINOTHINI A/P CHANDRA MOHAN
- VIMALRAJ A/L SELVARAJU

---

## Course Information

**Course:** KD04103 Mobile Application Development  
**Project:** Group Assignment — Flower Identifier  
**Semester:** Semester 2, 2024/2025  
**Faculty:** Faculty of Computing and Informatics

---

## License

This project was developed for **educational and academic purposes only**.
