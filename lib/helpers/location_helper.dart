const GOOGLE_API_KEY = "AIzaSyBMVwKD-AkciAPHo_kUzuj8FbrbX9ZDi_8";

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=14&size=400x400&key=$GOOGLE_API_KEY";
  }
}
