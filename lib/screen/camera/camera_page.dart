import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'dart:developer' as devtools;

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  CameraController? cameraController;
  bool isDetecting = false;
  List<dynamic> recognitions = [];
  double imageWidth = 0;
  double imageHeight = 0;
  bool isCameraInitialized = false;
  bool isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    loadModel();
    initCamera();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 4,
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    await cameraController!.initialize();
    if (!mounted) return;

    setState(() {
      isCameraInitialized = true;
    });

    cameraController!.startImageStream((CameraImage img) {
      if (!isDetecting) {
        isDetecting = true;
        runModel(img);
      }
    });
  }

  runModel(CameraImage img) async {
    if (mounted) {
      imageWidth = img.width.toDouble();
      imageHeight = img.height.toDouble();

      var results = await Tflite.runModelOnFrame(
        bytesList: img.planes.map((plane) => plane.bytes).toList(),
        imageHeight: img.height,
        imageWidth: img.width,
        imageMean: 127.5,    // Nilai standar TensorFlow Lite
        imageStd: 127.5,     // Nilai standar TensorFlow Lite
        rotation: 90,        // Rotasi sesuai orientasi device
        numResults: 5,       // Menampilkan 5 hasil teratas
        threshold: 0.1,      // Threshold yang lebih rendah untuk mendeteksi lebih banyak objek
        asynch: true,
      );

      if (results != null && results.isNotEmpty) {
        if (mounted) {
          setState(() {
            recognitions = results;
            isDetecting = false;
          });
        }
      } else {
        isDetecting = false;
      }
    }
  }

  switchCamera() async {
    if (cameraController != null && mounted) {
      await cameraController!.dispose();
      
      setState(() {
        isFrontCamera = !isFrontCamera;
        isCameraInitialized = false;
      });
      
      cameraController = CameraController(
        cameras[isFrontCamera ? 1 : 0],
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      
      await cameraController!.initialize();
      
      setState(() {
        isCameraInitialized = true;
      });
      
      cameraController!.startImageStream((CameraImage img) {
        if (!isDetecting) {
          isDetecting = true;
          runModel(img);
        }
      });
    }
  }

  @override
  void dispose() {
    Tflite.close();
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Widget> stackChildren = [];
    Size screenSize = MediaQuery.of(context).size;
    
    // Menambahkan kamera preview
    stackChildren.add(
      Positioned(
        top: 0,
        left: 0,
        width: screenSize.width,
        height: screenSize.height,
        child: AspectRatio(
          aspectRatio: cameraController!.value.aspectRatio,
          child: CameraPreview(cameraController!),
        ),
      ),
    );

    // Overlay untuk hasil deteksi
    if (recognitions.isNotEmpty) {
      stackChildren.add(
        Positioned(
          top: 50,
          left: 10,
          width: screenSize.width - 20,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recognitions.map((result) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${result["label"]}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${(result["confidence"] * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    }

    // Tombol untuk kembali dan switch kamera
    stackChildren.add(
      Positioned(
        bottom: 30,
        left: 0,
        width: screenSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: "back",
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
            FloatingActionButton(
              heroTag: "switch",
              backgroundColor: Colors.green,
              onPressed: cameras.length > 1 ? switchCamera : null,
              child: const Icon(Icons.switch_camera),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: stackChildren,
        ),
      ),
    );
  }
}