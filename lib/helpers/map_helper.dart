import 'dart:convert';

import 'package:http/http.dart' as http;

//String googleApiKey = 'YOUR GOOGLE MAPS API KEY';
String googleMapsApiKey = 'YOUR GOOGLE MAPS API KEY';

class MapHelper{

  static String createLocationPreviewImageUrl(double latitude, double longitude){

    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude"
        "&zoom=13&size=600x300&maptype=roadmap"
        "&markers=color:blue%7Clabel:C%7C$latitude,$longitude"
        " &key=$googleMapsApiKey";
  }

  static Future<String> getPlaceAddress(double latitude, double longitude) async {
    //For more info check - https://developers.google.com/maps/documentation/geocoding/overview#reverse-example
    final String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleMapsApiKey";
    final http.Response response = await http.get(url);
    //First address that will be found by the geocoding api should be the most relevant
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

}