import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Helpers {
  Future<Either<String, LatLng>> getMyLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const Left("Location Service is not enabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const Left("Location Permission is denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return const Left("Location Permission is permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation, forceAndroidLocationManager: true);
    return Right(LatLng(position.latitude, position.longitude));
  }
}
