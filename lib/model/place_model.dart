// import 'dart:io';

import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Place {
  final String id;
  final String name;
  final String image;

  Place({
    required this.name,
    required this.image,
  }) : id = uuid.v4();
}
