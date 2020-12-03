import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/place_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initLocation;
  final bool isSelecting;

  //Constructor with default values
  const MapScreen({
    this.initLocation = const PlaceLocation(latitude: 31.795261540860697, longitude: 34.704558216642646),
    this.isSelecting = false}
    );

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng pickedLocation;

  void selectPlace(LatLng position){
    setState(() {
      pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your map'),
      actions: [
        if(widget.isSelecting) IconButton(
          icon: Icon(Icons.check),
          onPressed: pickedLocation==null ? null : (){
            Navigator.of(context).pop(pickedLocation);
          },)


      ]),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  widget.initLocation.latitude,
                  widget.initLocation.longitude),
            zoom: 16,
          ),
          onTap: (LatLng latLng){
            widget.isSelecting ? selectPlace(latLng) : null;
          },
        markers: (pickedLocation==null && widget.isSelecting) ? null : {
            Marker(
                markerId: MarkerId('Marker1'),
                position: pickedLocation ?? LatLng(widget.initLocation.latitude, widget.initLocation.longitude)
            )
        },
          myLocationEnabled: true,
      )
    );
  }
}
