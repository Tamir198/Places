import 'dart:io';
import 'package:flutter/foundation.dart';

import '../helpers/SQL_helper.dart';
import '../helpers/map_helper.dart';
import '../models/place_location.dart';
import '../models/place.dart';

class UserPlacesProvider with ChangeNotifier{

  List<Place> _items = [];

  List<Place> get items => [..._items];

  Future<void> addPlace(File image, String title, PlaceLocation pickedLocation)async {
    final String readableAddress = await MapHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);

    final Place newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: PlaceLocation(
            latitude: pickedLocation.latitude,
            longitude: pickedLocation.longitude,
            address: readableAddress
        ),
        image: image);

    _items.add(newPlace);
    notifyListeners();

    SQLHelper.insertDB('user_places', {
      'id' : newPlace.id,
      'title' : newPlace.title,
      'image' : newPlace.image.path,
      'loc_lat' : newPlace.location.latitude,
      'loc_lng' : newPlace.location.longitude,
      'address' : newPlace.location.address,
    });
  }

  //Getting the data from local db
  Future<void> getPlacesData() async {
    final List<Map<String, Object>> data = await SQLHelper.getTableData('user_places');

    _items = data.map(
            (item) => Place(
                id: item['id'],
                title: item['title'],
                location: PlaceLocation(
                    latitude: item['loc_lat'],
                    longitude: item['loc_lng'],
                    address: item['address']
                ),
                //Load the file into memory from the image path
                image: File(item['image']))
    ).toList();
    notifyListeners();
  }

  Place findPlaceById(String id){
    return _items.firstWhere((place) => place.id  == id);
  }

}
