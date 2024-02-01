import 'package:favourite_places/model/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

List<Place> placesList = [];

Future<Database> getData() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    version: 1,
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,name TEXT,image TEXT)');
    },
  );
  return db;
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(placesList);

  Future loadPlaces() async {
    final db = await getData();
    final placesData = await db.query('user_places');
    state = placesData
        .map((e) => Place(
              name: e['name'] as String,
              image: e['image'] as String,
            ))
        .toList();
  }

  void addPlace(Place placeName) async {
    //Sql database here
    final db = await getData();
    db.insert('user_places', {
      'id': placeName.id,
      'name': placeName.name,
      'image': placeName.image,
    });
    state = [...state, placeName];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
