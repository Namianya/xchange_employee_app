import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  const ImageCapture({ Key? key }) : super(key: key);

  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {

  dynamic _imageFile;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = imageFile;
    });
  }

  Future<void> _cropImage() async {
    File? cropped =await ImageCropper.cropImage(
      sourcePath: _imageFile!.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}