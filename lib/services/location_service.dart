import 'package:clima/model/location_model.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Location> getCurrentLocation() async {
    var location = Location(latitude: 0, longitude: 0);
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      location = Location(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (exception) {
      print('LocationService get location error : $exception');
    }
    return location;
  }
}
