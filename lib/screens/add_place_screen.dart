import 'dart:io';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/place_location.dart';
import '../providers/user_places.dart';
import '../widgets/image_input_widget.dart';
import '../widgets/location_input_widget.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String routName = '/addPlaceRout';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    Provider.of<UserPlacesProvider>(context, listen: false)
        .addPlace(_pickedImage, _titleController.text, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    SizedBox customSizedBox = SizedBox(height: 10);
    return Scaffold(
        appBar: AppBar(title: Text('Add a new place')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
                child: Padding(padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                        decoration: InputDecoration(labelText: 'title'),
                        controller: _titleController),
                    customSizedBox,
                    ImageInputWidget(_selectImage),
                    customSizedBox,
                    LocationInputWidget(_selectPlace),
                  ],
                ),
              ),
            )),
            RaisedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Add place'),
                //Make sure that the widget is at the very bottom of the screen
                elevation: 0,
                color: Theme.of(context).accentColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  _savePlace();
                })
          ],
        ));
  }
}
