import 'dart:io';

import 'package:favourite_places/model/place_model.dart';
import 'package:flutter/material.dart';

class PlacesDetail extends StatelessWidget {
  const PlacesDetail({super.key, required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.file(
                File(place.image),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 100,
              width: 500,
              decoration: const BoxDecoration(
                color: Colors.black38,
                // borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '${place.name}\n${place.id}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
