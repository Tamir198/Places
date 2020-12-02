import 'dart:convert';

import 'package:http/http.dart' as http;

//String googleApiKey = 'YOUR GOOGLE MAPS API KEY';
String googleApiKey = 'YOUR KEY HERE';

class MapHelper{

  static String createLocationPreviewImageUrl(double latitude, double longitude){
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude"
        "&zoom=13&size=600x300&maptype=roadmap"
        "&markers=color:blue%7Clabel:C%7C$latitude,$longitude"
        " &key=$googleApiKey";
  }

  static Future<String> getPlaceAddress(double latitude, double longitude) async {
    //For more info check - https://developers.google.com/maps/documentation/geocoding/overview#reverse-example
    final String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleApiKey";
    final http.Response response = await http.get(url);
    //First address that will be found should be the most relevant
    print(response);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

}