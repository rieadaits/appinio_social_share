import 'dart:io';

import 'package:flutter/material.dart';
import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppinioSocialShare appinioSocialShare = AppinioSocialShare();


  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Share Feature",
        home: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                MaterialButton(
                    color: Colors.blue,
                    child: const Text(
                        "Pick Image from Gallery",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed: () {
                      pickImage();
                    }
                ),
                MaterialButton(
                    color: Colors.blue,
                    child: const Text(
                        "Pick Image from Camera",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed: () {
                      pickImageC();
                    }
                ),
                SizedBox(height: 20,),
                image != null ? Image.file(image!): Text("No image selected"),
                ElevatedButton(
                  child: const Text("ShareToWhatsapp"),
                  onPressed: () {
                    shareToWhatsApp("", image!.path,);
                  },
                ),
                ElevatedButton(
                  child: const Text("ShareToMessenger"),
                  onPressed: () {
                    shareToMessenger(filePath: image!.path,);
                  },
                ),
                ElevatedButton(
                  child: const Text("ShareToFacebookStory"),
                  onPressed: () {
                    shareToFacebook("", image!.path,);
                  },
                ),
                ElevatedButton(
                  child: const Text("ShareToDirectInstagram"),
                  onPressed: () {
                    shareToDirectInstagram("", image!.path,);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  shareToWhatsApp(String message, String filePath) async {
    await appinioSocialShare.shareToWhatsapp(message, filePath: filePath);
  }

  shareToMessenger({String? message, String? filePath}) async {
    await appinioSocialShare.shareToMessenger(message: message, filePath: filePath);
  }

  shareToFacebook(String message, String filePath) async {
    await appinioSocialShare.shareToFacebook(message, filePath);
  }

  shareToDirectInstagram(String message, String filePath) async {
    await appinioSocialShare.shareToInstagramDirect(filePath: filePath);
  }
}

