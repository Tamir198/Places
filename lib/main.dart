import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'providers/user_places.dart';
import 'screens/add_place_screen.dart';
import 'screens/place_detail_screen.dart';
import 'screens/place_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes:{
          AddPlaceScreen.routName : (context) => AddPlaceScreen(),
          PlaceDetailsScreen.routName : (context) => PlaceDetailsScreen()
        }
      ),
    );
  }
}
