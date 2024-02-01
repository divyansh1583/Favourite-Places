import 'dart:io';

import 'package:favourite_places/model/place_model.dart';
import 'package:favourite_places/providers/places_provider.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState createState() => _AddScreenState();
}

class _AddScreenState extends ConsumerState<AddScreen> {
  final _nameController = TextEditingController();
  File? capturedImage;
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void changeImage(File image) async{
    final imagePath=await syspaths.getApplicationDocumentsDirectory();
    final imageName=path.basename(image.path);
    final savedImage=await image.copy('${imagePath.path}/$imageName');
    capturedImage = savedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Screen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(
                fontSize: 23,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: 'Enter a place name',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
            const SizedBox(height: 20),
            ImageInput(changeImage: changeImage),
            const SizedBox(height: 20),
            const LocationInput(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              ),
              onPressed: () {
                if (capturedImage == null || _nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a place name and image'),
                    ),
                  );
                  return;
                }
                ref.read(placesProvider.notifier).addPlace(
                      Place(name: _nameController.text, image: capturedImage!.path),
                    );
                Navigator.pop(context);
              },
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 23),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
