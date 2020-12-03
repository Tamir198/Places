import 'package:flutter/material.dart';
import 'package:flutter_app/providers/user_places.dart';
import 'package:flutter_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const String routName = '/PlaceDetailsScreenRout';

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    //The id is expected to be the only argument coming from the page that loads this one
    final String id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<UserPlacesProvider>(context, listen: false)
            .findPlaceById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: mediaQuery.height * 0.2,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          SizedBox(height: 10),
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
