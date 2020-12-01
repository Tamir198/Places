String googleApiKey = 'YOUR GOOGLE MAPS API KEY';

class MapHelper{
  static String createLocationPreviewImageUrl(double latitude, double longitude){
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude"
        "&zoom=13&size=600x300&maptype=roadmap"
        "&markers=color:blue%7Clabel:C%7C$latitude,$longitude"
        " &key=$googleApiKey";
  }


}