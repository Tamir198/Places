import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_places.dart';
import '../screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const String routName = '/PlaceDetailsScreenRout';

  @override
  Widget build(BuildContext context) {
    SizedBox space =  SizedBox(height: 10);
    Size mediaQuery = MediaQuery.of(context).size;
    //The id is expected to be the only argument coming from the page that loads this one
    final String id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<UserPlacesProvider>(context, listen: false).findPlaceById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: mediaQuery.height*0.65,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          space,
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          space,
          FlatButton(
            child: Text('View the place on map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                      builder: (BuildContext context) =>
                          MapScreen(
                            initLocation: selectedPlace.location,
                            isSelecting: false,
                          )));
            },
          )
        ],
      ),
    );
  }
}
