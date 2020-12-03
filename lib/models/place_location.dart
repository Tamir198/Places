import 'package:flutter/material.dart';

class PlaceLocation{
  final double latitude, longitude;
  final String address;

  const PlaceLocation(
      {@required this.latitude,@required this.longitude, this.address});


}