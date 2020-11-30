import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/user_places.dart';
import 'package:flutter_app/widgets/image_input_widget.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String routName = '/addPlaceRout';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final TextEditingController _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _savePlace(){
    //if invalid input
    if(_titleController.text.isEmpty || _pickedImage == null){
      return;
    }
    Provider.of<UserPlacesProvider>(context, listen: false).addPlace( _pickedImage, _titleController.text);
    Navigator.of(context).pop();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add a new place')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'title'),
                      controller: _titleController
                    ),
                    SizedBox(height: 10),
                    ImageInputWidget(_selectImage),
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
