import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/helpers/SQL_helper.dart';

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

    SQLHelper.insertDB('user_places', {'id' : newPlace.id, 'title' : newPlace.title, 'image' : newPlace.image.path});
  }


  Future<void> getPlacesData() async {
    final List<Map<String, Object>> data = await SQLHelper.getData('user_places');
    _items = data.map(
            (item) => Place(
                id: item['id'],
                title: item['title'],
                location: null,
                //Load the file into memory from the image path
                image: File(item['image']))
    ).toList();
    notifyListeners();
  }


}
