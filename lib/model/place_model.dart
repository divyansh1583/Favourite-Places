import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Place {
  final String id;
  final String name;

  Place({
    required this.name,
  }) : id = uuid.v4();
}
