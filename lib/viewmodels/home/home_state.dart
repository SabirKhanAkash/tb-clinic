import 'package:latlong2/latlong.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class BottomNavBarItemSelection extends HomeState {
  final int currentItemIndex;

  BottomNavBarItemSelection(this.currentItemIndex);
}

class MyCurrentLocation extends HomeState {
  final LatLng currentLatLng;

  MyCurrentLocation(this.currentLatLng);
}
