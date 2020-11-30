import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class UserPlacesProvider with ChangeNotifier{

  List<Place> _items = [];

  List<Place> get items => [..._items];

  void addPlace(File image, String title){
    final Place newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: image);
    _items.add(newPlace);
    notifyListeners();
  }


}
