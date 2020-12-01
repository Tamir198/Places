import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/map_helper.dart';
import 'package:location/location.dart';

class LocationInputWidget extends StatefulWidget {
  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String _previewLocationImageUrl;

  Future<void> _getLocation() async{
    final LocationData data = await Location().getLocation();
    print(data.latitude);
    print(data.longitude);
    final String staticMapImageUrl = MapHelper.createLocationPreviewImageUrl(data.latitude, data.longitude);

    setState(() {
      _previewLocationImageUrl = staticMapImageUrl;
    });


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
            onPressed: () {  }),
      ],)
    ]);
  }
}
