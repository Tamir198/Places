import 'package:flutter/material.dart';
import 'package:flutter_app/providers/user_places.dart';
import 'package:flutter_app/screens/add_place_screen.dart';
import 'package:flutter_app/screens/place_detail_screen.dart';
import 'package:flutter_app/screens/place_list_screen.dart';
import 'package:provider/provider.dart';

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
