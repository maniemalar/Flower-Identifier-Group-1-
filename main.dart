import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(const FlowerIdentifierApp());
}

class FlowerIdentifierApp extends StatelessWidget {
  const FlowerIdentifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flower Identifier',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  late Interpreter interpreter;
  List<String> labels = [];

  String _flowerName = '';
  double _confidence = 0.0;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _flowerName = '';
        _confidence = 0.0;
      });
      await runModel(_image!);
    }
  }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/model_unquant.tflite');
      final labelTxt = await rootBundle.loadString('assets/labels.txt');
      labels = labelTxt.split('\n');
      print('✅ Model & labels loaded');
    } catch (e) {
      print('❌ Failed to load model: $e');
    }
  }

  Future<void> runModel(File imageFile) async {
    print('Running model for image: ${imageFile.path}'); // Debugging
    final imageBytes = await imageFile.readAsBytes();
    img.Image? oriImage = img.decodeImage(imageBytes);
    if (oriImage == null) {
      print('❌ Failed to decode image.'); // Debugging
      return;
    }

    img.Image resized = img.copyResize(oriImage, width: 224, height: 224);
    var input = imageToByteListFloat32(resized);

    // Debugging: Check input tensor shape
    print('Input tensor shape (prepared): ${input.shape}');


    var output = List.filled(labels.length, 0.0).reshape([1, labels.length]);
    print('Output tensor shape (prepared): ${output.shape}'); // Debugging

    try {
      interpreter.run(input, output);
      print('✅ Model inference successful.'); // Debugging
    } catch (e) {
      print('❌ Error during model inference: $e'); // Debugging
      return;
    }

    print('Raw Model Output: $output'); // Crucial debug output

    double highestProb = 0.0;
    int predictedIndex = 0;

    // Ensure output[0] exists and is a List before iterating
    if (output.isNotEmpty && output[0] is List) {
      for (int i = 0; i < labels.length; i++) {
        if (i < output[0].length) { // Ensure index is within bounds of actual output
          double prob = output[0][i];
          if (prob > highestProb) {
            highestProb = prob;
            predictedIndex = i;
          }
        } else {
          print('Warning: Output length mismatch with labels. Labels index $i out of bounds for output[0] length ${output[0].length}');
        }
      }
    } else {
      print('Error: Model output is not in expected format.');
      setState(() {
        _flowerName = 'Error: Output format';
        _confidence = 0.0;
      });
      return;
    }


    // Debugging: Print highest probability and predicted index before setting state
    print('Highest Probability: $highestProb');
    print('Predicted Index: $predictedIndex');
    print('Predicted Flower Name (from labels): ${labels[predictedIndex]}');


    setState(() {
      _flowerName = labels[predictedIndex];
      _confidence = highestProb;
    });
  }

  List<List<List<List<double>>>> imageToByteListFloat32(img.Image image) {
    return List.generate(
      1,
          (_) => List.generate(
        224,
            (y) => List.generate(
          224,
              (x) {
            final pixel = image.getPixel(x, y);
            final r = pixel.r / 255.0;
            final g = pixel.g / 255.0;
            final b = pixel.b / 255.0;
            return [r, g, b];
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color pastelPink = const Color(0xFFFFE4E1);
    final Color softPink = const Color(0xFFFFD1DC);
    final Color textColor = Colors.pink.shade800;

    return Scaffold(
        backgroundColor: pastelPink,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'Welcome to Flower Identification App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please upload your flower picture to know the name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _image!,
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Container(
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.pink.shade200),
                    ),
                    child: const Center(
                      child: Text(
                        'No image selected 🌸',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Column(
                    children: [
                      Text(
                        _flowerName.isNotEmpty ? 'Flower: $_flowerName' : 'Flower: -',
                        style: TextStyle(fontSize: 18, color: textColor),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _flowerName.isNotEmpty
                            ? 'Confidence: ${(_confidence * 100).toStringAsFixed(2)}%'
                            : 'Confidence: -',
                        style: TextStyle(fontSize: 16, color: textColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),


                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Upload from Gallery'),
                    onPressed: () => _pickImage(ImageSource.gallery),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: textColor,
                      backgroundColor: softPink,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Capture with Camera'),
                    onPressed: () => _pickImage(ImageSource.camera),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: textColor,
                      backgroundColor: softPink,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            ),
        );
    }
}