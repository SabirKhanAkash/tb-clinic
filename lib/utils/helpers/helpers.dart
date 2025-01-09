import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:tb_clinic/core/services/api_service.dart';
import 'package:tb_clinic/utils/config/app_key.dart';
import 'package:tb_clinic/utils/config/app_text.dart';

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

  Future<List<LatLng>> getRoute(LatLng origin, LatLng destination) async {
    final apiKey = AppKey().openRouteApiKey;
    final url = Uri.parse(
        '${AppText().openRouteApiBaseUrl}?api_key=$apiKey&start=${origin.longitude},${origin.latitude}&end=${destination.longitude},${destination.latitude}');

    try {
      final response = await ApiService().get(url.toString());
      if (response?.statusCode == 200) {
        final data = json.decode(response?.data);
        if (data is Map &&
            data.containsKey('features') &&
            data['features'] is List &&
            data['features'].isNotEmpty) {
          final feature = data['features'][0];
          if (feature is Map &&
              feature.containsKey('geometry') &&
              feature['geometry'] is Map &&
              feature['geometry'].containsKey('coordinates')) {
            final List<dynamic> coordinates = feature['geometry']['coordinates'];
            return coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
          } else {
            print('Error: Invalid geometry structure');
            return [];
          }
        } else {
          print('Error: Invalid features structure');
          return [];
        }
      } else {
        print('Failed to fetch route: ${response?.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching route: $e');
      return [];
    }
  }
}
