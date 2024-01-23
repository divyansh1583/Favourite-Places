import 'package:favourite_places/model/place_model.dart';
import 'package:favourite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState createState() => _AddScreenState();
}

class _AddScreenState extends ConsumerState<AddScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
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
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            ),
            onPressed: () {
              ref.read(placesProvider.notifier).addPlace(
                    Place(name: _nameController.text),
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
    );
  }
}
