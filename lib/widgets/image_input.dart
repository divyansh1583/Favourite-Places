import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.changeImage});
  final void Function(File image) changeImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var isImageCaptured = false;
  File? capturedImage;
  void captureImage() {
    final imagePicker = ImagePicker();
    imagePicker
        .pickImage(source: ImageSource.camera, maxWidth: 600)
        .then((image) {
      if (image == null) {
        return;
      } else {
        setState(() {
          isImageCaptured = true;
          capturedImage = File(image.path);
        });
        widget.changeImage(capturedImage!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        // color: const Color(0xff7c9,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 3,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: isImageCaptured
          ? GestureDetector(
              onTap: captureImage,
              child: Stack(
                fit: StackFit.expand,
                //add image decoration https://api.flutter.dev/flutter/painting/BoxDecoration-class.html
                children: [
                  Image.file(
                    capturedImage!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black38,
                    child: const Center(
                      child: Text(
                        "Tap to change image",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: ElevatedButton.icon(
                label: const Text('Add Image'),
                icon: const Icon(Icons.camera_alt),
                onPressed: captureImage,
              ),
            ),
    );
  }
}
