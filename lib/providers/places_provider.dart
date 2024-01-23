import 'package:favourite_places/model/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Place> placesList = [];

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(placesList);

  void addPlace(Place placeName) {
    state = [...state, placeName];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
