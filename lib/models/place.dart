import 'package:flutter/cupertino.dart';
import 'dart:io';

import '../models/place_location.dart';

class Place {
  final String id, title;
  final File image;
  final PlaceLocation location;

  Place({@required this.id, @required this.title, @required this.location, @required this.image});
}
