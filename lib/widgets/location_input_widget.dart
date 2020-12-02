import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/map_helper.dart';
import 'package:flutter_app/screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInputWidget extends StatefulWidget {

  final Function onSelectPlace;
  LocationInputWidget(this.onSelectPlace);

  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String _previewLocationImageUrl;

  void showMapPreview(double latitude, double longitude){

    final String staticMapImageUrl = MapHelper.createLocationPreviewImageUrl(latitude, longitude);

    setState(() {
      _previewLocationImageUrl = staticMapImageUrl;
    });

  }


  Future<void> _getLocation() async{
    try{

      final LocationData data = await Location().getLocation();
      showMapPreview(data.latitude, data.longitude);
      widget.onSelectPlace(data.latitude,data.longitude);

    }catch(error){
      return;
    }

  }



  Future<void> _pickMapLocation() async {
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => MapScreen(isSelecting: true)
        ));

    if(selectedLocation == null){
      return;
    }
    showMapPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude,selectedLocation.longitude);
  }




  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Column(children: [
      Container(
          alignment: Alignment.center,
          height: mediaQuery.height * 0.30,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          width: double.infinity,
          child: _previewLocationImageUrl == null
              ? Text('No location chosen', textAlign: TextAlign.center)
              : Image.network(_previewLocationImageUrl,
              fit: BoxFit.cover, width: double.infinity)
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        FlatButton.icon(
            label: Text('Current location'),
            icon: Icon(Icons.location_on),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              _getLocation();
            }),
        FlatButton.icon(
            label: Text('Select on map'),
            icon: Icon(Icons.map),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              _pickMapLocation();
            }),
      ],)
    ]);
  }
}
